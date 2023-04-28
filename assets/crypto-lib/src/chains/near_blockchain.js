import * as BN from "bn.js";
import Long from "long";

export class NearBlockchain {
  getBlockChainDataFromMnemonic(
    mnemonic,
    passphrase = "",
    derivationPath = "44'/397'/0'/0'/0'"
  ) {
    const { CoinType, HDWallet, Base64, HexCoding } = window.WalletCore;
    const wallet = HDWallet.createWithMnemonic(mnemonic, passphrase);
    const coinNear = CoinType.near;
    //getDerivedKey(coin: CoinType, account: number, change: number, address: number): PrivateKey;
    const privateKey = wallet.getDerivedKey(coinNear, 0, 0, 1);
    // const privateKey = wallet.getKeyForCoin(coinNear);
    const privateKeyString = Base64.encode(privateKey.data());
    const hexString = HexCoding.encode(privateKey.getPublicKeyEd25519().data());

    return JSON.stringify({
      mnemonic: wallet.mnemonic(),
      publicKey: hexString.substring(2),
      // publicKey: wallet.getAddressForCoin(coinNear),
      privateKey: privateKeyString,
      passphrase: passphrase,
      derivationPath: derivationPath,
    });

    // const { CoinType, HDWallet, Base64, HexCoding } = window.WalletCore;
    // const wallet = HDWallet.createWithMnemonic(mnemonic, passphrase);
    // console.log(`derivationPath ${derivationPath}`);
    // console.log(`derivationPath ${"44'/397'/0'/0'/0'" === derivationPath}`);
    // console.log(`passphrase ${passphrase}`);

    // const privateKeyDerivedWallet = wallet.getKey(
    //   CoinType.near,
    //   `44'/397'/0'/0'/0'`
    // );
    // const privateKeyString = Base64.encode(privateKeyDerivedWallet.data());
    // const publicKey = privateKeyDerivedWallet.getPublicKeyEd25519();
    // const hexString = HexCoding.encode(publicKey.data());
    // return JSON.stringify({
    //   mnemonic: wallet.mnemonic(),
    //   publicKey: hexString.slice(2),
    //   privateKey: privateKeyString,
    //   passphrase: passphrase,
    //   derivationPath: derivationPath,
    // });
  }

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
      const parsedActions = JSON.parse(actions);

      const twActions = parsedActions.map((action) =>
        this.getActionObject(action, amountBytes, nonce, gas)
      );

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

  getActionObject(action, amountBytes, nonce, gas) {
    const actionHandlers = {
      transfer: () => this.transferAction(amountBytes),
      functionCall: () => this.functionCallAction(action, gas, amountBytes),
      addKey: () => this.addKeyAction(action, amountBytes, nonce),
      deleteKey: () => this.deleteKeyAction(action),
      stake: () => this.stakeAction(action),
      unstake: () => this.unstakeAction(action),
      createAccount: () => this.createAccountAction(action),
      deleteAccount: () => this.deleteAccountAction(action),
      deployContract: () => this.deployContractAction(action),
    };

    const handler = actionHandlers[action.type];
    if (!handler) {
      throw new Error(`Unsupported action type: ${action.type}`);
    }

    return handler();
  }

  transferAction(amountBytes) {
    return {
      transfer: TW.NEAR.Proto.Transfer.create({
        deposit: amountBytes,
      }),
    };
  }

  functionCallAction(action, gas, amountBytes) {
    const encoder = new TextEncoder();
    const utf8BytesArgs = encoder.encode(JSON.stringify(action.data.args));
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
  }

  addKeyAction(action, amountBytes, nonce) {
    const { HDWallet, CoinType } = window.WalletCore;

    const mnemonic = action.data.mnemonic;
    const passphrase = action.data.passphrase;
    const index = action.data.indexOfTheDerivationPath;

    const wallet = HDWallet.createWithMnemonic(mnemonic, passphrase ?? "");
    const privateKeyDerivedWallet = wallet.getKey(
      CoinType.near,
      `44'/397'/0'/0'/${index}'`
    );
    const publicKey = privateKeyDerivedWallet.getPublicKeyEd25519();
    const permission = action.data.permission;
    const receiverId = action.data.receiverId;
    const methodNames = action.data.methodNames;

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
                  allowance: amountBytes,
                  receiverId: receiverId,
                  methodNames: methodNames,
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
    return mappedAction;
  }

  deleteKeyAction(action) {
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
  }

  stakeAction(action) {
    throw new Error(`Unsupported action type: ${action.type}`);
  }
  unstakeAction(action) {
    throw new Error(`Unsupported action type: ${action.type}`);
  }

  createAccountAction() {
    const mappedAction = {
      createAccount: TW.NEAR.Proto.CreateAccount.create({}),
    };
    return mappedAction;
  }

  deleteAccountAction(action) {
    const beneficiaryId = action.data.beneficiaryId;
    const mappedAction = {
      deleteAccount: TW.NEAR.Proto.DeleteAccount.create({
        beneficiaryId: beneficiaryId,
      }),
    };
    return mappedAction;
  }

  deployContractAction(action) {
    const wasmByteCode = action.data.wasmByteCode;
    const mappedAction = {
      deleteAccount: TW.NEAR.Proto.DeployContract.create({
        code: wasmByteCode,
      }),
    };
    return mappedAction;
  }
}
