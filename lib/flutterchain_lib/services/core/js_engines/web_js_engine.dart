import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_vm.dart';

import 'dart:js' as js;
import 'dart:async';

JsVMService getJsVM() => WebJsVMService();

class WebJsVMService implements JsVMService {
  WebJsVMService() {
    init();
  }

  @override
  Future<void> init() async {}

  @override
  Future<dynamic> callJS(String function) async {
    final res = js.context.callMethod('eval', [function]);

    return res;
  }
}
