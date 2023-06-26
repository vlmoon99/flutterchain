# Flutter Chain

Flutterchain is a library that provides developers with a simple API to communicate with different blockchains and call smart contracts. It allows developers to easily integrate popular cryptocurrencies into their web 3.0 projects. By leveraging Flutterchain, developers can build powerful decentralized applications without needing to have an in-depth understanding of the underlying blockchain technology. With Flutterchain, developers can easily interact with smart contracts , send transfers , etc. It's an easy-to-use and flexible solution for developers looking to build blockchain-based applications.

## Prerequisites

List any dependencies or prerequisites needed before getting started with this library.

- Node JS
- Installed webpack (js package)
- Installed watch (js package)
- Flutter
- Installed Android Studio and Android SDK (For Android dev)
- Installed Xcode (For IOS, Mac OS dev)

## Building

Instructions for building the library from source code.

1. Clone this repository: `git clone https://github.com/vlmoon99/flutterchain`
2. Navigate to the project root directory: `cd flutterchain`
3. Run `bash dev_build.sh` or `bash prod_build.sh` for building flutterchain lib

## How to use

1. Add This code to the head tag For Web project

```
 <script
      type="application/javascript"
      src="/assets/packages/flutter_inappwebview/assets/web/web_support.js"
      defer
   ></script>

  <script
      type="application/javascript"
      src="/assets/packages/flutterchain/assets/crypto-lib/dist/bundle.js"
      defer
></script>
```

2.  Set minSdkVersion 19 in the android/app/build.gradle file and add android:usesCleartextTraffic="true" in manifest
3.  Add network permission to android manifest -
    ```
    <uses-permission android:name="android.permission.INTERNET"/>
    ```
4.  Inject all dependencies as in a example with Modular or Get it , etc.
    or use default constructor in provided classes (Not recommended)
5.  Initialize the flutterchain library after WidgetsFlutterBinding.ensureInitialized() in the main function.

          WidgetsFlutterBinding.ensureInitialized();
          await initFlutterChainLib();

          To perform all operations with the blockchain, you need to create a private and public key.
          For this task, you have two options:

          1.Creating the wallet with generated mnemonic (Using Trust Wallet Core) :
          Wallet wallet = await cryptoLibrary.createWalletWithGeneratedMnemonic(walletName: walletName);
          Alternatively, if you want to import a mnemonic from somewhere, you can use the following code:
          Wallet wallet = await cryptoLibrary.createWalletByImportedMnemonic(mnemonic: mnemonic!, walletName: walletName);

          2.If you are only using services for signing and sending transactions, you can generate blockchainData using the following methods (In this example, I will be using the Near Blockchain):
          final nearBlockChainService  = NearBlockChainService.defaultInstance();
          NearBlockChainData blockchainData = nearBlockChainService.getBlockChainDataFromMnemonic(your_mnemonic,your_passphrase);

          Once you have obtained the blockchainData containing the private and public key, you can easily communicate with the blockchain.

          You can use my library in a few ways. First of all, you can use it just for signing transactions. To sign any transaction, you need to use BlockchainServices. Currently, I only have support for the Near blockchain.

          final nearBlockChainService  = NearBlockChainService.defaultInstance();


          Retrieve all the necessary information for making a signed transaction:
          // 1. Get Nonce and Blockhash information from the Near blockchain (or you can use your own implementation of this method).
              final transactionInfo = await nearBlockChainService.getNonceAndBlockHashInfo(
              accountId: fromAddress,
              publicKey: publicKey,
              );

          //2.Retrieve gas information.
          final gas = BlockchainGas.gas[BlockChains.near];

          //3.Define actions. All possible actions can be found in my assets/crypto-lib (JS project inside my library) NearBlockchain class
          final actions = [
          {
          "type": "transfer",
          "data": {"amount": NearFormatter.nearToYoctoNear(transferAmount)}
          }
          ];

          //4.Sign the action

        final signedAction = await nearBlockChainService.signNearActions(
        fromAddress: fromAddress,
        toAddress: toAdress,
        transferAmount: NearFormatter.nearToYoctoNear(transferAmount),
        privateKey: privateKey,
        gas: gas,
        nonce: transactionInfo.nonce,
        blockHash: transactionInfo.blockHash,
        actions: actions,
        );

        log("Result of signed the tx ${signedAction}");

        //5.Send the transaction to the Near Blockchain and get the response (or use your own Near RPC network client).
        final res = await nearBlockChainService.nearRpcClient.sendSyncTx([signedAction]);
        log("Result of transaction executing ->  ${res.toJson().toString()}");

        Alternatively, you can use the entire library together. You can see the architecture in the draw.io file flutterchain_arch.drawio inside the library.

        (Important) To use my library together, make sure you are familiar with the DI (Dependency Injection) principles.
        First, you can see an example inside my example folder at modules folder (example/lib/modules).
        You can see how I initialized my dependencies in the .module.dart files.
        After this, you can go to the components and pages (example/lib/modules/home/components/chains/near) and see how I use my library.

        In a nutshell, I have a library that contains BlockchainServices and some Repositories (currently only for the Wallet model).
        I also have a stream with the current wallets.
        The FlutterChainLibrary class provides a high level of API for using WEB 3.0. You can send transfers in native tokens, make smart contract calls, and more.

        For Example :
        final response = cryptoLibrary.sendTransferNativeCoin(
        walletId: walletId,
        typeOfBlockchain: typeOfBlockchain,
        toAddress: toAddress,
        currentDerivationPath: currentDerivationPath,
        transferAmount: NearFormatter.nearToYoctoNear(transferAmount),
        );

        log(response.toJson().toString());

        //The walletId is the wallet ID of wallets inside a walletsStream.
        You take a wallet from there and also provide the blockchain
        type and derivation path of the wallet (https://github.com/satoshilabs/slips/blob/master/slip-0044.md ,
        https://github.com/bitcoin/bips/blob/master/bip-0044.mediawiki).
        If you need some specific functionality for some blockchains - take it from FlutterChainService :

        final nearBlockChainService = cryptoLibrary.blockchainService
        .blockchainServices[BlockChains.near] as NearBlockChainService?;

        and use functions inside NearBlockChainService.
        All data which this library collect saved in flutter_secure_storage package , you can read about it here(https://github.com/mogol/flutter_secure_storage).
        You can easy implement your own repository using extends Repository<Wallet> on your class and make your own data storage.

## Running Examples

Instructions for running the included examples.

1. Navigate to the example directory: `cd example`
2. Run `flutter run` to launch the example app on your preferred device.
3. Explore the example app to see how to use the library in your own project.

## Contributing

Instructions for contributing to this library.

1. Fork this repository
2. Create a new branch: `git checkout -b my-new-branch`
3. Make changes and commit them: `git commit -m "My message"`
4. Push to the remote branch: `git push origin my-new-branch`
5. Create a pull request

## License

This project is licensed under the MIT License
