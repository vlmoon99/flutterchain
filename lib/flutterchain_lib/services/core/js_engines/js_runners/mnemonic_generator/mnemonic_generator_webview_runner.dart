import 'dart:convert';

import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/webview_js_engine.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_runners/mnemonic_generator/mnemonic_generator_js_runner.dart';


MnemonicGeneratorJsRunner getMnemonicJsRunner() => MnemonicGeneratorWebviewRunner();
class MnemonicGeneratorWebviewRunner extends MnemonicGeneratorJsRunner {
  final WebviewJsVMService jsVMService = WebviewJsVMService();

  @override
  Future<String> generateMnemonic({int strength = 128}) async {
    final res =
        await jsVMService.callJS("window.generateMnemonic('$strength')");
    final data = jsonDecode(res);
    return data["mnemonic"];
  }
}
