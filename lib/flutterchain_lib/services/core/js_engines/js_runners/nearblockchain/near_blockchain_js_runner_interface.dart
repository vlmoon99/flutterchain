abstract class NearBlockChainJsRunner {
  Future<String> getBlockChainDataFromMnemonic({
    required String mnemonic,
    required String passphrase,
    String? accountNumber,
    String? change,
    String? address,
  });

  Future<String> signNearActions({
    required String fromAddress,
    required String toAddress,
    required String transferAmount,
    required String privateKey,
    required String gas,
    required int nonce,
    required String blockHash,
    required String actions,
  });

  Future<String> exportSecretKeyToNearApiJSFormat({
    required String privateKey,
    required String publicKey,
  });

  Future<String> getBase58PubKeyFromHexValue(String hexEncodedPubKey);

  Future<String> getPublicKeyFromSecretKeyFromNearApiJSFormat(
      String base58PrivateKey);

  Future<String> getPrivateKeyFromSecretKeyFromNearApiJSFormat(
      String base58PrivateKey);

  Future<String> generateAddressForNearMPC({
    required String accountId,
    required String path,
    required String chain,
    required String network,
    String? publicMPCKey,
  });

  Future<void> authWithNearWalletsWeb({
    required String privateNearAPIjsFormat,
    String? successUrlCallBackWeb,
    String? failureUrlCallBackWeb,
  });

  
}
