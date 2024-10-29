import 'dart:js_interop';

import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_runners/bitcoin/bitcoin_blockchain_js_runner_interface.dart';

BitcoinBlockChainJsRunner getBitcoinJsRunner() =>
    BitcoinBlockChainWebJsRunner();

class BitcoinBlockChainWebJsRunner implements BitcoinBlockChainJsRunner {
  @override
  Future<String> getBlockChainData(
      {required String mnemonic,
      required String passphrase,
      String? accountNumber,
      String? change,
      String? address}) async {
    if (accountNumber == null || change == null || address == null) {
      return _getBlockChainDataFromMnemonic(
        mnemonic.toJS,
        passphrase.toJS,
      );
    } else {
      return _getBlockChainDataFromMnemonic(
        mnemonic.toJS,
        passphrase.toJS,
        accountNumber.toJS,
        change.toJS,
        address.toJS,
      );
    }
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
    return _formBitcoinTransferAction(
      toAddress,
      accountID,
      transferAmount,
      privateKeyHex,
      publicKey,
      dataFromUTXO,
      format,
      feeBayte,
    );
  }

  @override
  Future<String> getAdressBTCFromHexPublicKeyP2PKH(
      {required String publicKeyHEX, required bool needKeyHash}) async {
    return _getAdressBTCFromHexPublicKeyP2PKH(publicKeyHEX, needKeyHash);
  }

  @override
  Future<String> getAdressBTCFromHexPublicKeySegWit(String publicKeyHEX) async {
    return _getAdressBTCFromHexPublicKeySegWit(publicKeyHEX);
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
    return _createPayloadForNearMPC(
      sender,
      receiver,
      satoshis,
      utxos,
      txInfos,
      feeRate,
      network,
    );
  }

    @override
  Future<String> getReversedPayloadsToSignForMPCForBitcoin({
    required String psbtHex,
    required String utxos,
    required String publicKey,
  }) async {
    return _getReversedPayloadsToSignForMPCForBitcoin(
      psbtHex,
      utxos,
      publicKey,
    );
  }

  @override
  Future<String> signTransactionWithMPCSignatureForBitcoin({
    required String psbtHex,
    required String signatures,
    required String publicKey,
  }) async {
    return _signTransactionWithMPCSignatureForBitcoin(
      psbtHex,
      signatures,
      publicKey,
    );
  }

}

@JS('BitcoinBlockchain.getBlockChainDataFromMnemonic')
external String _getBlockChainDataFromMnemonic(
  JSString mnemonic,
  JSString passphrase, [
  JSString? account,
  JSString? change,
  JSString? address,
]);

@JS('BitcoinBlockchain.bitcoinTransferAction')
external String _formBitcoinTransferAction(
  String toAddress,
  String accountID,
  String transferAmount,
  String privateKeyHex,
  String publicKey,
  String dataFromUTXO,
  String format,
  int feeBayte,
);

@JS('BitcoinBlockchain.getAdressBTCFromHexPublicKeyP2PKH')
external String _getAdressBTCFromHexPublicKeyP2PKH(
    String publicKeyHEX, bool needKeyHash);

@JS('BitcoinBlockchain.getAdressBTCFromHexPublicKeySegWit')
external String _getAdressBTCFromHexPublicKeySegWit(
  String publicKeyHEX,
);

@JS('BitcoinUtils.createPayload')
external String _createPayloadForNearMPC(
  String sender,
  String receiver,
  int satoshis,
  String utxos,
  String txInfos,
  double feeRate,
  String network,
);


@JS('BitcoinUtils.getReversedPayloadsToSignForMPC')
external String _getReversedPayloadsToSignForMPCForBitcoin(
  String psbtHex,
  String utxos,
  String publicKey,
);

@JS('BitcoinUtils.signTransactionWithMPCSignature')
external String _signTransactionWithMPCSignatureForBitcoin(
  String psbtHex,
  String signatures,
  String publicKey,
);
