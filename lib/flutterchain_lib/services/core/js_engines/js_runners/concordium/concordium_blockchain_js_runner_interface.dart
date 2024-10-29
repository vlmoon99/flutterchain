abstract class ConcordiumBlockchainJsRunner {
  Future<String> createIdentityRequestParams({
    required String mnemonic,
    required String network,
    required String selectedIdentityProvider,
    required String cryptographicParameters,
    required int identityIndex,
  });

  Future<String> createIdentityRecoveryParams({
    required String seedPhrase,
    required String network,
    required String selectedIdentityProvider,
    required int identityIndex,
    required String cryptographicParameters,
  });

  Future<String> createCredentialDeploymentTransaction({
    required String seedPhrase,
    required String network,
    required int identityIndex,
    required int credNumber,
    required String identity,
    required String selectedIdentityProvider,
    required String global,
  });

  Future<String> getAccountAddressFromMnemonic({
    required String seedPhrase,
    required String network,
    required int identityProviderIndex,
    required int identityIndex,
    required int credNumber,
    required String cryptographicParameters,
  });

  Future<String> getAccountSigningKey({
    required String seedPhrase,
    required String network,
    required int identityProviderIndex,
    required int identityIndex,
    required int credNumber,
  });

  Future<String> getAccountPublicKey({
    required String seedPhrase,
    required String network,
    required int identityProviderIndex,
    required int identityIndex,
    required int credNumber,
  });

  Future<String> createTransferTransactionParams({
    required String senderAddress,
    required String toAddress,
    required int amount,
    required String signingKey,
    required int nonce,
  });

  Future<String> createDelegationTransactionParams({
    required String senderAddress,
    required String amount,
    required String signingKey,
    required int nonce,
    required String restakeEarnings,
    required String delegationTarget,
  });

  Future<String> createBakerTransactionParams({
    required String senderAddress,
    required String signingKey,
    required int nonce,
    required String amount,
    required String restakeEarnings,
    required String bakerSettigs,
    required String bakerKeys,
  });

  Future<String> accountInfoFromProtoFormat(String accountInfo);
  Future<String> cryptographicParametersFromProtoFormat(
      String cryptographicParameters);

  Future<String> transactionHashFromProtoFormat(String txHash);
}
