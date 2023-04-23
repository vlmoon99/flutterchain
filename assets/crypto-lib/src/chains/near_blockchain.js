import * as BN from "bn.js";
import Long from "long";

export class NearBlockchain {
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
      const { HDWallet } = window.WalletCore;

      const amount = new BN(transferAmount);
      const amountBytes = amount.toArrayLike(Uint8Array, "le", 16);
      let parsedActions = JSON.parse(actions);

      const twActions = parsedActions.map((action) => {
        if (action.type === "transfer") {
          return {
            transfer: TW.NEAR.Proto.Transfer.create({
              deposit: amountBytes,
            }),
          };
        } else if (action.type === "functionCall") {
          const encoder = new TextEncoder();
          const utf8BytesArgs = encoder.encode(
            JSON.stringify(action.data.args)
          );
          const methodName = action.data.methodName;
          const mappedAction = {
            functionCall: TW.NEAR.Proto.FunctionCall.create({
              methodName: methodName,
              args: utf8BytesArgs,
              gas: Long.fromString(gas),
              deposit: amountBytes,
            }),
          };
          return mappedAction;
        } else if (action.type === "addKey") {
          const mnemonic = action.data.mnemonic;
          const passphrase = action.data.passphrase;
          const index = action.data.indexOfTheDerivationPath;

          const wallet = HDWallet.createWithMnemonic(
            mnemonic,
            passphrase ?? ""
          );
          // Get the private key at index 0 of the derivation path
          const privateKeyDerivedWallet = wallet.getKey(
            CoinType.near,
            `44'/397'/0'/0'/${index}'`
          );
          // Derive the public key from the private key
          const publicKey = privateKeyDerivedWallet.getPublicKeyEd25519();
          const permission = action.data.permission;
          const receiverId = action.data.receiverId;
          const methodNames = action.data.methodNames;
          // privateKey = privateKeyDerivedWallet.data();
          console.log(`Methods names ${JSON.stringify(methodNames)}`);
          console.log(`receiverId ${JSON.stringify(receiverId)}`);

          const mappedAction = {
            addKey: TW.NEAR.Proto.AddKey.create({
              publicKey: {
                // keyType: 0,
                data: publicKey.data(),
              },
              accessKey: {
                nonce: Long.fromString(nonce),
                functionCall:
                  permission == "functionCall"
                    ? TW.NEAR.Proto.FunctionCallPermission.create({
                        allowance: amountBytes, //bytes of total amount of gas prepaid for the transaction
                        receiverId: receiverId, // receiverIds id
                        methodNames: methodNames, // list of methods that can be sss
                      })
                    : null,
                fullAccess:
                  permission == "fullAccess"
                    ? TW.NEAR.Proto.FullAccessPermission.create()
                    : null,
                permission: action.data.permission,
              },
            }),
          };
          // console.log(`mappedAction ${JSON.stringify(mappedAction)}}`);

          return mappedAction;
        } else if (action.type === "deleteKey") {
          const publicKey = action.data.publicKey;
          const byteArray = Buffer.from(publicKey, "hex");
          const uint8Array = new Uint8Array(byteArray);

          const mappedAction = {
            deleteKey: TW.NEAR.Proto.DeleteKey.create({
              publicKey: TW.NEAR.Proto.PublicKey.create({
                data: uint8Array,
              }),
            }),
          };
          return mappedAction;
        } else if (action.type === "stake") {
          const publicKey = action.data.publicKey;
          const byteArray = Buffer.from(publicKey, "hex");
          const uint8Array = new Uint8Array(byteArray);

          const mappedAction = {
            stake: TW.NEAR.Proto.Stake.create({
              stake: amountBytes,
              publicKey: TW.NEAR.Proto.PublicKey.create({
                data: uint8Array,
              }),
            }),
          };
          return mappedAction;
        } else if (action.type == "createAccount") {
          const mappedAction = {
            createAccount: TW.NEAR.Proto.CreateAccount.create({}),
          };
          return mappedAction;
        } else if (action.type == "deleteAccount") {
          const beneficiaryId = action.data.beneficiaryId;
          const mappedAction = {
            deleteAccount: TW.NEAR.Proto.DeleteAccount.create({
              beneficiaryId: beneficiaryId,
            }),
          };
          return mappedAction;
        } else if (action.type == "deployContract") {
          const wasmByteCode = action.data.wasmByteCode;
          const mappedAction = {
            deleteAccount: TW.NEAR.Proto.DeployContract.create({
              code: wasmByteCode,
            }),
          };
          return mappedAction;
        }
      });

      console.log(`fromAddress ${JSON.stringify(fromAddress)}`);

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
      console.error(JSON.stringify(error));
      return JSON.stringify({ error: error.message });
    }
  }
}
