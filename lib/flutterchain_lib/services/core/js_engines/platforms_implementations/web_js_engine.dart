import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/js_vm.dart';

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

  @override
  Future callJSAsync(String function) async {
    var completer = Completer<dynamic>();

    // Call the JavaScript function which returns a Promise
    var jsPromise = js.context.callMethod('eval', [function]);

    // Convert the JS Promise to a Dart Future
    jsPromise.callMethod('then', [
      (result) {
        completer.complete(result);
      }
    ]);

    jsPromise.callMethod('catch', [
      (error) {
        completer.completeError(error.toString());
      }
    ]);

    return completer.future;
  }
}
