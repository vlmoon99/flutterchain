import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/webview_js_engine.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_runners/nearblockchain/near_blockchain_js_runner_interface.dart';

NearBlockChainJsRunner getNearJsRunner() => NearBlockChainWebviewJSRunner();

class NearBlockChainWebviewJSRunner extends NearBlockChainJsRunner {
  final WebviewJsVMService jsVMService = WebviewJsVMService();

  @override
  Future<String> getBlockChainDataFromMnemonic({
    required String mnemonic,
    required String passphrase,
    String? accountNumber,
    String? change,
    String? address,
  }) async {
    final rawFunction = accountNumber == null
        ? "window.NearBlockchain.getBlockChainDataFromMnemonic('$mnemonic','$passphrase')"
        : """window.NearBlockchain.getBlockChainDataFromMnemonic('$mnemonic','$passphrase', "$accountNumber","$change","$address")""";
    final res = await jsVMService.callJS(rawFunction);
    return res.toString();
  }

  @override
  Future<String> signNearActions({
    required String fromAddress,
    required String toAddress,
    required String transferAmount,
    required String privateKey,
    required String gas,
    required int nonce,
    required String blockHash,
    required String actions,
  }) async {
    return (await jsVMService.callJS(
            "window.NearBlockchain.signNearActions('$fromAddress','$toAddress','$transferAmount', '$gas' , '$privateKey','$nonce','$blockHash','$actions')"))
        .toString();
  }

  @override
  Future<String> exportSecretKeyToNearApiJSFormat(
      {required String privateKey, required String publicKey}) async {
    return (await jsVMService.callJS(
            "window.NearBlockchain.exportSecretKeyToNearApiJSFormat('$privateKey','$publicKey')"))
        .toString();
  }

  @override
  Future<String> getBase58PubKeyFromHexValue(String hexEncodedPubKey) async {
    return (await jsVMService.callJS(
            "window.NearBlockchain.getBase58PubKeyFromHexValue('$hexEncodedPubKey')"))
        .toString();
  }

  @override
  Future<String> getPublicKeyFromSecretKeyFromNearApiJSFormat(
      String base58PrivateKey) async {
    return (await jsVMService.callJS(
            "window.NearBlockchain.getPublicKeyFromSecretKeyFromNearApiJSFormat('$base58PrivateKey')"))
        .toString();
  }

  @override
  Future<String> getPrivateKeyFromSecretKeyFromNearApiJSFormat(
      String base58PrivateKey) async {
    return (await jsVMService.callJS(
            "window.NearBlockchain.getPrivateKeyFromSecretKeyFromNearApiJSFormat('$base58PrivateKey')"))
        .toString();
  }

  @override
  Future<String> generateAddressForNearMPC({
    required String accountId,
    required String path,
    required String chain,
    required String network,
    String? publicMPCKey,
  }) async {
    return (await jsVMService.callJSAsync(
      "window.generateAddressForNearMPC('$accountId', '$path', '$chain', '$network', ${publicMPCKey != null ? "'$publicMPCKey'" : 'undefined'})",
    ))
        .toString();
  }

  @override
  Future<void> authWithNearWalletsWeb(
      {required String privateNearAPIjsFormat,
      String? successUrlCallBackWeb,
      String? failureUrlCallBackWeb}) async {
    throw Exception("method used only in web");
  }
}
