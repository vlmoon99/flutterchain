abstract class BitcoinBlockChainJsRunner {
  Future<String> getBlockChainData({
    required String mnemonic,
    required String passphrase,
    String? accountNumber,
    String? change,
    String? address,
  });

  Future<String> formBitcoinTransferAction({
    required String toAddress,
    required String accountID,
    required String transferAmount,
    required String privateKeyHex,
    required String publicKey,
    required String dataFromUTXO,
    required String format,
    required int feeBayte,
  });

  Future<String> getAdressBTCFromHexPublicKeyP2PKH(
      {required String publicKeyHEX, required bool needKeyHash});

  Future<String> getAdressBTCFromHexPublicKeySegWit(String publicKeyHEX);
  Future<String> createPayloadForNearMPC({
    required String sender,
    required String receiver,
    required int satoshis,
    required String utxos,
    required String txInfos,
    required double feeRate,
    required String network,
  });

  Future<String> getReversedPayloadsToSignForMPCForBitcoin({
    required String psbtHex,
    required String utxos,
    required String publicKey,
  });

  Future<String> signTransactionWithMPCSignatureForBitcoin({
    required String psbtHex,
    required String signatures,
    required String publicKey,
  });
}
