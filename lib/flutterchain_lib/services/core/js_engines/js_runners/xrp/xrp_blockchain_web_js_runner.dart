import 'dart:js_interop';

import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_runners/xrp/xrp_blockchain_js_runner_interface.dart';

XrpBlockChainJSRunner getXRPJsRunner() => XrpBlockchainWebJsRunner();

class XrpBlockchainWebJsRunner implements XrpBlockChainJSRunner {
  @override
  Future<String> createUnsignedTransaction(String txInJson) async =>
      _createUnsignedTransaction(txInJson);

  @override
  Future<String> signTransactionWithMPCSignatureForXRP({
    required String unsignedTx,
    required String signatureData,
  }) async =>
      _signTransactionWithMPCSignatureForXRP(
        unsignedTx,
        signatureData,
      );
}

@JS('XRPUtils.createUnsignedTransaction')
external String _createUnsignedTransaction(String txInJson);

@JS('XRPUtils.signTransactionWithMPCSignature')
external String _signTransactionWithMPCSignatureForXRP(
  String unsignedTx,
  String signatureData,
);
