<div align="center">

![](https://raw.githubusercontent.com/ArturLevchuk/media_storage/refs/heads/main/FlutterChainLogo.png)

</div>

- [About FlutterChain](#about-get)
- [Installing](#installing)
- [How To Use](#how-to-use)
- [Important Notes and Tips](#important-notes-and-tips)
- [Running Examples](#running-examples)
- [Contributing](#contributing)


# About FlutterChain
FlutterChain is a library that provides developers with a simple API to communicate with different blockchains. It allows developers to easily integrate popular cryptocurrencies into their web 3.0 projects without needing to have an in-depth understanding of the underlying blockchain technology. With FlutterChain, developers can easily interact with smart contracts, send transfers, and perform various transaction types. It's an easy-to-use and flexible solution for developers looking to build blockchain-based applications.

## Installing

1. Add This code to the index.html For Web project

```html
<head>
  <!-- other head elements -->
  <script type="application/javascript" src="flutter.js" defer></script>
  <script type="application/javascript" src="/assets/packages/flutter_inappwebview_web/assets/web/web_support.js" defer></script>
  <script type="module" src="/assets/packages/flutterchain/assets/crypto-lib/dist/bundle.js"></script>
  <script type="application/javascript" src="/assets/packages/flutterchain/assets/crypto-lib/dist/dop_bundle.js"></script>
  <link rel="modulepreload" crossorigin href="/assets/packages/flutterchain/assets/crypto-lib/dist/bundle2.js">


</head>

<body>
  <script>
    window.addEventListener("load", async function (ev) {
      {{flutter_js}}
      {{flutter_build_config}}

      _flutter.loader.load({
        serviceWorker: {
          serviceWorkerVersion: '{{flutter_service_worker_version}}',
        },
        onEntrypointLoaded: function (engineInitializer) {
          engineInitializer.initializeEngine().then(function (appRunner) {
            appRunner.runApp();
          });
        },
      });
    });
  </script>
</body>
```

2.  Set Android: minSdkVersion >= 19, compileSdk >= 34, AGP version >= 7.3.0 in the android/app/build.gradle file and add to the AndroidManifest.xml `usesCleartextTraffic` param and Internet permission:
```xml
  <manifest> ...
    <application> ...
      android:usesCleartextTraffic="true"
    </application>
    <uses-permission android:name="android.permission.INTERNET"/>
  </manifest>
```

4.  Initialize the flutterchain library after WidgetsFlutterBinding.ensureInitialized() in the main function.
```dart
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initFlutterChainLib();
  ...
  runApp(MyApp());
}
```

## How to use

This library provides interfaces to interact with various blockchains. You can achieve this by using an implementation of `BlockChainService` or `BlockchainServiceWithSmartContractCallSupport` for your selected blockchain. For example:

```dart
  final service = NearBlockChainService.defaultInstance(); // NearBlockChainService implements BlockchainServiceWithSmartContractCallSupport
  final amount = await service
      .getWalletBalance(NearAccountInfoRequest(accountId: "test.near"));
```

The library also includes its own wallet controller (`FlutterChainLibrary`), allowing you to create wallets for different blockchains simultaneously, securely store them and manage, and execute standardized operations like transferring coins or interacting with smart contracts (where supported by the blockchain). It also provides access to the blockchain specific methods interface. For example:

```dart
  final flutterChainLibrary = FlutterChainLibrary.defaultInstance();

  final wallet = await flutterChainLibrary.createWalletWithGeneratedMnemonic(
      walletName: "my wallet");

  final derivationPathData =
      wallet.blockchainsData?[BlockChains.near]?.first.derivationPath;

  // call from FlutterChainLibrary

  final response = await flutterChainLibrary.sendTransferNativeCoin(
    blockchainType: BlockChains.near,
    derivationPathData: derivationPathData!,
    walletId: wallet.id,
    toAddress: "someAddress",
    transferAmount: "1000",
  );

  //call from blockchainService interface

  final NearBlockChainService nearBlockChainService = flutterChainLibrary
      .blockchainService
      .blockchainServices[BlockChains.near] as NearBlockChainService;

  // final NearBlockChainData blockChainData = wallet.blockchainsData![BlockChains.near]?.first as NearBlockChainData;
  final NearBlockChainData blockChainData = await nearBlockChainService
      .getBlockChainData(mnemonic: wallet.mnemonic) as NearBlockChainData;

  final response2 = await nearBlockChainService.sendTransferNativeCoin(
    NearTransferRequest(
      publicKey: blockChainData.publicKey,
      privateKey: blockChainData.privateKey,
      toAddress: "someAddress",
      transferAmount: "1000",
    ),
  );

  await flutterChainLibrary.deleteAllWallets();
```

## Important Notes and Tips  

`FlutterChainLibrary` and `BlockchainServiceWithSmartContractCallSupport`/`BlockchainService` implementations aren't singletons. Each time a new instance is created, a `jsVMService` (a service that handles blockchain operations behind the scenes) is also instantiated. For optimal performance, it is recommended to reuse the same instance of the blockchain service throughout your app. This can be easily managed by using dependency injection libraries like [flutter_modular](https://pub.dev/packages/flutter_modular) or [get_it](https://pub.dev/packages/get_it).

For more detailed information, refer to the [documentation](https://github.com/vlmoon99/flutterchain/tree/main/documentation) and tests. You'll find guidance on how to use FlutterChainLibrary or various BlockchainServices. Additionally, you can explore different use cases through the examples provided:

- [General example (FlutterChainLibrary wallet; Near, Bitcoin, Concordium blockchain services)](https://github.com/vlmoon99/flutterchain/tree/main/example)
- [Near Chain Signatures](https://github.com/vlmoon99/flutterchain/tree/main/chain_signatures_example)
- [Near Mintbase](https://github.com/vlmoon99/flutterchain/tree/main/mintbase_example)


You can see the architecture in the draw.io file flutterchain_arch.drawio inside the library.

## Running Examples

Instructions for running the included examples.

1. Navigate to the example directory: `cd example`
2. Run `flutter run` to launch the example app on your preferred device.
3. Explore the example app to see how to use the library in your own project.

## Contributing

Instructions for contributing to this library:

1. Fork this repository
2. Create a new branch: `git checkout -b my-new-branch`
3. Make changes and commit them: `git commit -m "My message"`
4. Push to the remote branch: `git push origin my-new-branch`
5. Create a pull request

List any dependencies or prerequisites needed before getting started with editing this library:

- Node JS
- Flutter
- Installed Android Studio and Android SDK (For Android dev)
- Installed Xcode (For IOS, Mac OS dev)

Instructions for building the library from source code:

1. Clone this repository: `git clone https://github.com/vlmoon99/flutterchain`
2. Navigate to the project root directory: `cd flutterchain`
3. Run `bash build.sh` for building flutterchain lib

