import 'dart:convert';
import 'dart:js_interop';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_runners/mnemonic_generator/mnemonic_generator_js_runner.dart';


@JS('generateMnemonic')
external JSString _generateMnemonic(int strength);


MnemonicGeneratorJsRunner getMnemonicJsRunner() => MnemonicGeneratorWebJSRunner();

class MnemonicGeneratorWebJSRunner extends MnemonicGeneratorJsRunner {
  @override
  Future<String> generateMnemonic({int strength = 128}) async {
    final res = _generateMnemonic(strength).toDart;
    final data = jsonDecode(res);
    return data["mnemonic"];
  }
}
