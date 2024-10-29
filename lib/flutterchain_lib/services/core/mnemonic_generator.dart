import 'dart:convert';

import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/js_vm.dart';

class MnemonicGenerator {
  final JsVMService jsVMService;

  MnemonicGenerator({required this.jsVMService});

  Future<String> generateMnemonic({
    int strength = 128,
  }) async {
    final res =
        await jsVMService.callJS("window.generateMnemonic('$strength')");
    final data = jsonDecode(res);
    return data["mnemonic"];
  }
}
