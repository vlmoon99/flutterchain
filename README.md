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
3.  Add this to android manifest <uses-permission android:name="android.permission.INTERNET"/>
4.  Inject all dependencies as in a example with Modular or Get it , etc.
    or use default constructor in provided classes (Not recommended)
5.  Init flutterchain lib after WidgetsFlutterBinding.ensureInitialized()
    in main function()

    ```
     WidgetsFlutterBinding.ensureInitialized();
     await initFlutterChainLib();
    ```

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
