import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/webview_js_engine.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_runners/xrp/xrp_blockchain_js_runner_interface.dart';

XrpBlockChainJSRunner getXRPJsRunner() => XrpBlockchainWebviewRunner();

class XrpBlockchainWebviewRunner extends XrpBlockChainJSRunner {
  final WebviewJsVMService jsVMService = WebviewJsVMService();

  @override
  Future<String> createUnsignedTransaction(String txInJson) async {
    final res = await jsVMService
        .callJS("""window.XRPUtils.createUnsignedTransaction('$txInJson')""");
    return res.toString();
  }

  @override
  Future<String> signTransactionWithMPCSignatureForXRP({
    required String unsignedTx,
    required String signatureData,
  }) async {
    return (await jsVMService.callJS(
            "window.XRPUtils.signTransactionWithMPCSignature('$unsignedTx', '$signatureData')"))
        .toString();
  }
}
