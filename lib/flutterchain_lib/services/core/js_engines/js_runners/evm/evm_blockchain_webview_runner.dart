import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/webview_js_engine.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_runners/evm/evm_blockchain_js_runner_interface.dart';

EvmBlockChainJSRunner getEVMJsRunner() => EvmBlockchainWebviewJsRunner();

class EvmBlockchainWebviewJsRunner extends EvmBlockChainJSRunner {
  final WebviewJsVMService jsVMService = WebviewJsVMService();

  @override
  Future<String> createUnsignedTransaction({
    required String receiver,
    required int weiAmount,
    required String chainInfo,
    required String txCreatingInfo,
    String? smartContractCallEncoded,
  }) async {
    final res =
        await jsVMService.callJS("""window.EVMUtils.createUnsignedTransaction(
      '$receiver', $weiAmount, '$chainInfo', '$txCreatingInfo', ${smartContractCallEncoded != null ? """'$smartContractCallEncoded'""" : 'undefined'})""");
    return res.toString();
  }

  @override
  Future<String> getAbiEncodedSmartContractArgs(
      {required String functionSignature, required String parameters}) async {
    final res = await jsVMService.callJS(
        """window.EVMUtils.getAbiEncodedSmartContractArgs('$functionSignature', '$parameters' )""");
    return res.toString();
  }

  @override
  Future<String> signTransactionWithMPCSignatureForEVMBlockchain({
    required String signatureData,
    required String serializedTransaction,
    required String sender,
    required String typeOfTransaction,
    required String chainInfo,
  }) async {
    return (await jsVMService.callJSAsync(
            "window.EVMUtils.signTransactionWithMPCSignature('$signatureData', '$serializedTransaction', '$sender', '$typeOfTransaction', '$chainInfo')"))
        .toString();
  }
}
