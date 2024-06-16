import { Address, bytesToHex } from "@ethereumjs/util";
import { FeeMarketEIP1559Transaction, LegacyTransaction } from "@ethereumjs/tx";
import { Common } from "@ethereumjs/common";
import Web3 from "web3";

export class EVMUtils {
  createUnsignedTransaction(
    receiver,
    weiAmount,
    chainInfo,
    txCreatingInfo,
    data
  ) {
    chainInfo = JSON.parse(chainInfo);
    const { nonce, gasPrice, gasLimit, maxPriorityFeePerGas } =
      JSON.parse(txCreatingInfo);

    const common = chainInfo.name
      ? Common.custom({
          name: chainInfo.name,
          chainId: chainInfo.chainId,
          networkId: chainInfo.chainId,
        })
      : new Common({ chain: chainInfo.chainId });

    // Construct transaction

    if (maxPriorityFeePerGas) {
      const transactionData = {
        nonce,
        gasLimit,
        maxFeePerGas: gasPrice,
        maxPriorityFeePerGas,
        to: receiver,
        value: BigInt(weiAmount),
        chain: chainInfo.chainId,
      };

      //Add data if it exists to form smart contract call
      if (data) {
        transactionData.data = data;
      }

      // Return the message hash
      let transaction = FeeMarketEIP1559Transaction.fromTxData(
        transactionData,
        {
          common,
        }
      );
      const payload = transaction.getHashedMessageToSign();
      transaction = transaction.serialize();
      return JSON.stringify({
        transaction,
        payload,
        chainInfo,
        typeOfTransaction: "FeeMarketEIP1559Transaction",
      });
    } else {
      // Construct transaction

      const transactionData = {
        nonce,
        gasLimit,
        gasPrice,
        to: Address.fromString(receiver),
        value: BigInt(weiAmount),
      };

      //Add data if it exists to form smart contract call
      if (data) {
        transactionData.data = data;
      }

      // Return the message hash
      let transaction = LegacyTransaction.fromTxData(transactionData, {
        common,
      });
      const payload = transaction.getHashedMessageToSign();
      transaction = transaction.serialize();
      return JSON.stringify({
        transaction,
        payload,
        chainInfo,
        typeOfTransaction: "LegacyTransaction",
      });
    }
  }

  signTransactionWithMPCSignature(
    signatureData,
    serializedTransaction,
    sender,
    typeOfTransaction,
    chainInfo
  ) {
    let transaction = undefined;

    chainInfo = JSON.parse(chainInfo);


    const common = chainInfo.name
    ? Common.custom({
        name: chainInfo.name,
        chainId: chainInfo.chainId,
        networkId: chainInfo.chainId,
      })
    : new Common({ chain: chainInfo.chainId });

    if (typeOfTransaction === "FeeMarketEIP1559Transaction") {
      transaction = FeeMarketEIP1559Transaction.fromSerializedTx(
        Uint8Array.from(JSON.parse(serializedTransaction)),
        { common }
      );
    } else {
      transaction = LegacyTransaction.fromSerializedTx(
        Uint8Array.from(JSON.parse(serializedTransaction)),
        { common }
      );
    }

    const { big_r, big_s } = JSON.parse(signatureData);

    // reconstruct the signature
    const r = Buffer.from(big_r.substring(2), "hex");
    const s = Buffer.from(big_s, "hex");

    // finding v
    let candidates = undefined;
    if (typeOfTransaction === "FeeMarketEIP1559Transaction") {
      candidates = [0n, 1n].map((v) => transaction.addSignature(v, r, s));
    } else {
      // Calculate correct v values
      const vValues = [27, 28]; // Legacy
      const eip155vValues = [
        chainInfo.chainId * 2 + 35,
        chainInfo.chainId * 2 + 36,
      ]; // EIP-155

      candidates = [...vValues, ...eip155vValues].map((v) =>
        transaction.addSignature(v, r, s)
      );
    }

    // find the correct transaction
    const signedTransaction = candidates.find(
      (c) =>
        c.getSenderAddress().toString().toLowerCase() === sender.toLowerCase()
    );

    if (!signedTransaction) {
      throw new Error("Signature is not valid");
    }

    if (signedTransaction.getValidationErrors().length > 0)
      throw new Error("Transaction validation errors");
    if (!signedTransaction.verifySignature())
      throw new Error("Signature is not valid");

    // return signed transaction;
    const serializedTx = bytesToHex(signedTransaction.serialize());
    return serializedTx;
  }

  signTransaction(
    serializedTransaction,
    privateKey,
    typeOfTransaction,
    chainInfo
  ) {
    let transaction = undefined;

    const common = chainInfo.name
    ? Common.custom({
        name: chainInfo.name,
        chainId: chainInfo.chainId,
        networkId: chainInfo.chainId,
      })
    : new Common({ chain: chainInfo.chainId });

    if (typeOfTransaction === "FeeMarketEIP1559Transaction") {
      transaction = FeeMarketEIP1559Transaction.fromSerializedTx(
        Uint8Array.from(JSON.parse(serializedTransaction)),
        { common }
      );
    } else {
      transaction = LegacyTransaction.fromSerializedTx(
        Uint8Array.from(JSON.parse(serializedTransaction)),
        { common }
      );
    }

    const signedTx = transaction.sign(privateKey);

    const serializedTx = bytesToHex(signedTx.serialize());
    return serializedTx;
  }

  getAbiEncodedSmartContractArgs(functionSignature, parameters) {
    parameters = JSON.parse(parameters);
    const web3 = new Web3();

    // Encode the function signature to get the function selector
    const functionSelector =
      web3.eth.abi.encodeFunctionSignature(functionSignature);

    // Extract parameter types from the function signature
    let parameterTypesString = functionSignature.slice(functionSignature.indexOf('(') + 1, functionSignature.indexOf(')'));
    const parameterTypes = parameterTypesString ? parameterTypesString.split(',') : [];
    
    // Encode the parameters using the extracted types and values
    const encodedParameters = web3.eth.abi.encodeParameters(
      parameterTypes,
      parameters
    );

    // Concatenate function selector and encoded parameters
    const data = functionSelector + encodedParameters.slice(2);
    return data;
  }
}
