import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_runners/mnemonic_generator/mnemonic_generator_js_runner.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_runners/mnemonic_generator/mnemonic_generator_js_runner_stub.dart'
    if (dart.library.io) 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_runners/mnemonic_generator/mnemonic_generator_webview_runner.dart'
    if (dart.library.js_interop) 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_runners/mnemonic_generator/mnemonic_generator_web_js_runner.dart';

class MnemonicGenerator {
  final MnemonicGeneratorJsRunner jsRunner = getMnemonicJsRunner();

  /// Generates a mnemonic phrase with the specified strength.
  ///
  /// The strength parameter defines the entropy level of the mnemonic,
  /// typically ranging from 128 to 256 bits. A higher strength provides
  /// a more secure mnemonic.
  ///
  /// Returns a Future that resolves to the generated mnemonic phrase.
  Future<String> generateMnemonic({
    int strength = 128,
  }) async {
    return jsRunner.generateMnemonic(strength: strength);
  }
}
