# Flutter Chain

A brief description of what this library does.

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

1. Clone this repository: `git clone https://github.com/your/repo.git`
2. Navigate to the project root directory: `cd flutterchain`
3. Run `bash dev_build.sh` or `bash prod_build.sh` for building flutterchain lib
4. After that go to the example folder with `cd example` 
5. Add This code to the head tag For Web project 
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


6. Set minSdkVersion 19 in the android/app/build.gradle file and add            android:usesCleartextTraffic="true" in manifest

7. Run `flutter pub get` to get the necessary dependencies.
8. Run `flutter run` to run the example.

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

This project is licensed under the [License Name] License - see the [LICENSE.md](LICENSE.md) file for details.
