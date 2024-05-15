import { Address, bytesToHex } from "@ethereumjs/util";
import { FeeMarketEIP1559Transaction, LegacyTransaction } from "@ethereumjs/tx";
import { Common } from "@ethereumjs/common";

export class EVMUtils {
  createUnsignedTransaction(
    receiver,
    weiAmount,
    chainInfo,
    nonce,
    gasPrice,
    gasLimit,
    maxPriorityFeePerGas
  ) {
    chainInfo = JSON.parse(chainInfo);

    let common = undefined;

    if (!chainInfo.name) {
      common = new Common({ chain: chainInfo.chainId });
    } else {
      common = Common.custom({
        name: chainInfo.name,
        chainId: chainInfo.chainId,
        networkId: chainInfo.chainId,
      });
    }

    // Construct transaction

    if (maxPriorityFeePerGas) {
      const transactionData = {
        nonce,
        gasLimit: gasLimit,
        maxFeePerGas: gasPrice,
        maxPriorityFeePerGas,
        to: receiver,
        value: BigInt(weiAmount),
        chain: chainInfo.chainId,
      };

      // Return the message hash
      let transaction = FeeMarketEIP1559Transaction.fromTxData(
        transactionData,
        {
          common,
        }
      );
      const payload = transaction.getHashedMessageToSign();
      transaction = transaction.serialize();
      return JSON.stringify({ transaction, payload, chainInfo, typeOfTransaction: "FeeMarketEIP1559Transaction" });
    } else {

      const transactionData = {
        nonce,
        gasLimit: gasLimit,
        gasPrice: gasPrice,
        to: Address.fromString(receiver),
        value: BigInt(weiAmount),
      };

      // Return the message hash
      let transaction = LegacyTransaction.fromTxData(transactionData, {
        common,
      });
      const payload = transaction.getHashedMessageToSign();
      transaction = transaction.serialize();
      return JSON.stringify({ transaction, payload, chainInfo, typeOfTransaction: "LegacyTransaction" });
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

    let common = undefined;

    if (!chainInfo.name) {
      common = new Common({ chain: chainInfo.chainId });
    } else {
      common = Common.custom({
        name: chainInfo.name,
        chainId: chainInfo.chainId,
        networkId: chainInfo.chainId,
      });
    }

    if (typeOfTransaction === "FeeMarketEIP1559Transaction") {
      transaction = FeeMarketEIP1559Transaction.fromSerializedTx(
        Uint8Array.from(JSON.parse(serializedTransaction)), {common});
    } else {
      transaction = LegacyTransaction.fromSerializedTx(
        Uint8Array.from(JSON.parse(serializedTransaction)), {common});
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
      const vValues = [27, 28];  // Legacy
      const eip155vValues = [chainInfo.chainId * 2 + 35, chainInfo.chainId * 2 + 36];  // EIP-155
      
      candidates = [...vValues, ...eip155vValues].map((v) => transaction.addSignature(v, r, s));
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

  signTransaction(serializedTransaction, privateKey, typeOfTransaction, chainInfo) {
    let transaction = undefined;

    if (!chainInfo.name) {
      common = new Common({ chain: chainInfo.chainId });
    } else {
      common = Common.custom({
        name: chainInfo.name,
        chainId: chainInfo.chainId,
        networkId: chainInfo.chainId,
      });
    }

    if (typeOfTransaction === "FeeMarketEIP1559Transaction") {
      transaction = FeeMarketEIP1559Transaction.fromSerializedTx(
          Uint8Array.from(JSON.parse(serializedTransaction)), {common}
        );
    } else {
      transaction = LegacyTransaction.fromSerializedTx(
        Uint8Array.from(JSON.parse(serializedTransaction)) , {common}
      );
    }

    const signedTx = transaction.sign(privateKey);

    const serializedTx = bytesToHex(signedTx.serialize());
    return serializedTx;
  }
}
