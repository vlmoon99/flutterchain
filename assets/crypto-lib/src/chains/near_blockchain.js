import * as BN from "bn.js";
import Long from "long";

export class NearBlockchain {
  //Create Wallet Methods
  generateMnemonic(passphrase) {
    const { CoinType, HDWallet, Base64 } = window.WalletCore;
    const wallet = HDWallet.create(128, passphrase ?? "");

    let coinNear = CoinType.near;
    const privateKeyString = Base64.encode(
      wallet.getKeyForCoin(coinNear).data()
    );
    return JSON.stringify({
      mnemonic: wallet.mnemonic(),
      publicKey: wallet.getAddressForCoin(coinNear),
      privateKey: privateKeyString,
      passphrase: passphrase,
    });
  }
  createNearWalletFromMnemonic(mnemonic, passphrase) {
    const { CoinType, HDWallet, Base64 } = window.WalletCore;
    const wallet = HDWallet.createWithMnemonic(mnemonic, passphrase ?? "");
    let coinNear = CoinType.near;
    const privateKeyString = Base64.encode(
      wallet.getKeyForCoin(coinNear).data()
    );
    return JSON.stringify({
      mnemonic: wallet.mnemonic(),
      publicKey: wallet.getAddressForCoin(coinNear),
      privateKey: privateKeyString,
      passphrase: passphrase,
    });
  }

  //Sign transaction method
  signNearActions(
    fromAddress,
    toAddress,
    transferAmount,
    gas,
    privateKey,
    nonce,
    blockHash,
    actions
  ) {
    try {
      const { TW, WalletCore } = window;
      const { AnySigner, CoinType, Base58 } = WalletCore;
      const amount = new BN(transferAmount);
      const amountBytes = amount.toArrayLike(Uint8Array, "le", 16);
      let parsedActions = JSON.parse(actions);

      const twActions = parsedActions.map((action) => {
        console.log(`JSON ${typeof action}`);
        if (action.type === "transfer") {
          return {
            transfer: TW.NEAR.Proto.Transfer.create({
              deposit: amountBytes,
            }),
          };
        } else if (action.type === "functionCall") {
          const encoder = new TextEncoder();
          const utf8BytesArgs = encoder.encode(action.data.args);
          const methodName = action.data.methodName;

          const mappedAction = {
            functionCall: TW.NEAR.Proto.FunctionCall.create({
              methodName: methodName,
              args: action.data.args !== "" ? utf8BytesArgs : [],
              gas: Long.fromString(gas),
              deposit: amountBytes,
            }),
          };
          return mappedAction;
        }
      });

      const input = TW.NEAR.Proto.SigningInput.create({
        signerId: fromAddress,
        nonce: Long.fromString(nonce),
        receiverId: toAddress,
        blockHash: Base58.decodeNoCheck(blockHash),
        actions: twActions,
        privateKey: Uint8Array.from(Buffer.from(privateKey, "base64")),
      });

      const encoded = TW.NEAR.Proto.SigningInput.encode(input).finish();
      const outputData = AnySigner.sign(encoded, CoinType.near);
      const output = TW.NEAR.Proto.SigningOutput.decode(outputData);

      return JSON.stringify(output);
    } catch (error) {
      console.error(JSON.stringify({ error: error }));
      return JSON.stringify({ error: error.message });
    }
  }
}
