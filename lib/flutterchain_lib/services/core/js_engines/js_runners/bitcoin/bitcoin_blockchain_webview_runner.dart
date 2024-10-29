import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/webview_js_engine.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_runners/bitcoin/bitcoin_blockchain_js_runner_interface.dart';

BitcoinBlockChainJsRunner getBitcoinJsRunner() =>
    BitcoinBlockChainWebviewJsRunner();

class BitcoinBlockChainWebviewJsRunner extends BitcoinBlockChainJsRunner {
  final WebviewJsVMService jsVMService = WebviewJsVMService();

  @override
  Future<String> getBlockChainData({
    required String mnemonic,
    required String passphrase,
    String? accountNumber,
    String? change,
    String? address,
  }) async {
    final rawFunction = accountNumber == null
        ? "window.BitcoinBlockchain.getBlockChainDataFromMnemonic('$mnemonic','$passphrase')"
        : """window.BitcoinBlockchain.getBlockChainDataFromMnemonic('$mnemonic','$passphrase', "$accountNumber","$change","$address")""";
    final res = await jsVMService.callJS(rawFunction);
    return res.toString();
  }

  @override
  Future<String> formBitcoinTransferAction({
    required String toAddress,
    required String accountID,
    required String transferAmount,
    required String privateKeyHex,
    required String publicKey,
    required String dataFromUTXO,
    required String format,
    required int feeBayte,
  }) async {
    final res = await jsVMService.callJS(
        "window.BitcoinBlockchain.bitcoinTransferAction('$toAddress', '$accountID', '$transferAmount', '$privateKeyHex', '$publicKey', '$dataFromUTXO', '$format', $feeBayte)");
    return res.toString();
  }

  @override
  Future<String> getAdressBTCFromHexPublicKeyP2PKH(
      {required String publicKeyHEX, required bool needKeyHash}) async {
    final res = await jsVMService.callJS(
        "window.BitcoinBlockchain.getAdressBTCFromHexPublicKeyP2PKH('$publicKeyHEX', $needKeyHash)");
    return res.toString();
  }

  @override
  Future<String> getAdressBTCFromHexPublicKeySegWit(String publicKeyHEX) async {
    final res = await jsVMService.callJS(
        "window.BitcoinBlockchain.getAdressBTCFromHexPublicKeySegWit('$publicKeyHEX')");
    return res.toString();
  }

  @override
  Future<String> createPayloadForNearMPC({
    required String sender,
    required String receiver,
    required int satoshis,
    required String utxos,
    required String txInfos,
    required double feeRate,
    required String network,
  }) async {
    final res = await jsVMService.callJS(
        "window.BitcoinBlockchain.createPayloadForNearMPC('$sender', '$receiver', $satoshis, '$utxos', '$txInfos', $feeRate, '$network')");
    return res.toString();
  }

  @override
  Future<String> getReversedPayloadsToSignForMPCForBitcoin({
    required String psbtHex,
    required String utxos,
    required String publicKey,
  }) async {
    return (await jsVMService.callJS(
            "window.BitcoinUtils.getReversedPayloadsToSignForMPC('$psbtHex', '$utxos', '$publicKey')"))
        .toString();
  }

  @override
  Future<String> signTransactionWithMPCSignatureForBitcoin({
    required String psbtHex,
    required String signatures,
    required String publicKey,
  }) async {
    return (await jsVMService.callJS(
            "window.BitcoinUtils.signTransactionWithMPCSignature('$psbtHex', '$signatures', '$publicKey')"))
        .toString();
  }
}
