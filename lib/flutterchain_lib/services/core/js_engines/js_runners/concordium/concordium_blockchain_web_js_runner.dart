import 'dart:js_interop';

import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_runners/concordium/concordium_blockchain_js_runner_interface.dart';

ConcordiumBlockchainJsRunner getConcordiumJsRunner() =>
    ConcordiumBlockchainWebJsRunner();

class ConcordiumBlockchainWebJsRunner implements ConcordiumBlockchainJsRunner {
  @override
  Future<String> createIdentityRequestParams({
    required String mnemonic,
    required String network,
    required String selectedIdentityProvider,
    required String cryptographicParameters,
    required int identityIndex,
  }) async {
    final res = await _createIdentityRequestParams(mnemonic, network,
            selectedIdentityProvider, cryptographicParameters, identityIndex)
        .toDart;
    return res.toDart;
  }

  @override
  Future<String> createIdentityRecoveryParams({
    required String seedPhrase,
    required String network,
    required String selectedIdentityProvider,
    required int identityIndex,
    required String cryptographicParameters,
  }) async {
    final res = await _createIdentityRecoveryParams(seedPhrase, network,
            selectedIdentityProvider, identityIndex, cryptographicParameters)
        .toDart;
    return res.toDart;
  }

  @override
  Future<String> createCredentialDeploymentTransaction({
    required String seedPhrase,
    required String network,
    required int identityIndex,
    required int credNumber,
    required String identity,
    required String selectedIdentityProvider,
    required String global,
  }) async {
    final res = await _createCredentialDeploymentTransaction(
      seedPhrase,
      network,
      identityIndex,
      credNumber,
      identity,
      selectedIdentityProvider,
      global,
    ).toDart;
    return res.toDart;
  }

  @override
  Future<String> getAccountAddressFromMnemonic({
    required String seedPhrase,
    required String network,
    required int identityProviderIndex,
    required int identityIndex,
    required int credNumber,
    required String cryptographicParameters,
  }) async =>
      _getAccountAddressFromMnemonic(
        seedPhrase,
        network,
        identityProviderIndex,
        identityIndex,
        credNumber,
        cryptographicParameters,
      );

  @override
  Future<String> getAccountSigningKey({
    required String seedPhrase,
    required String network,
    required int identityProviderIndex,
    required int identityIndex,
    required int credNumber,
  }) async =>
      _getAccountSigningKey(
        seedPhrase,
        network,
        identityProviderIndex,
        identityIndex,
        credNumber,
      );

  @override
  Future<String> getAccountPublicKey({
    required String seedPhrase,
    required String network,
    required int identityProviderIndex,
    required int identityIndex,
    required int credNumber,
  }) async =>
      _getAccountPublicKey(
        seedPhrase,
        network,
        identityProviderIndex,
        identityIndex,
        credNumber,
      );

  @override
  Future<String> createTransferTransactionParams({
    required String senderAddress,
    required String toAddress,
    required int amount,
    required String signingKey,
    required int nonce,
  }) async {
    final res = await _createTransferTransactionParams(
      senderAddress,
      toAddress,
      amount,
      signingKey,
      nonce,
    ).toDart;
    return res.toDart;
  }

  @override
  Future<String> createDelegationTransactionParams({
    required String senderAddress,
    required String amount,
    required String signingKey,
    required int nonce,
    required String restakeEarnings,
    required String delegationTarget,
  }) async {
    final res = await _createDelegationTransactionParams(
      senderAddress,
      amount,
      signingKey,
      nonce,
      restakeEarnings,
      delegationTarget,
    ).toDart;
    return res.toDart;
  }

  @override
  Future<String> createBakerTransactionParams({
    required String senderAddress,
    required String signingKey,
    required int nonce,
    required String amount,
    required String restakeEarnings,
    required String bakerSettigs,
    required String bakerKeys,
  }) async {
    final res = await _createBakerTransactionParams(
      senderAddress,
      signingKey,
      nonce,
      amount,
      restakeEarnings,
      bakerSettigs,
      bakerKeys,
    ).toDart;
    return res.toDart;
  }

  @override
  Future<String> accountInfoFromProtoFormat(String accountInfo) async =>
      _accountInfoFromProtoFormat(accountInfo);

  @override
  Future<String> cryptographicParametersFromProtoFormat(
          String cryptographicParameters) async =>
      _cryptographicParametersFromProtoFormat(
        cryptographicParameters,
      );

  @override
  Future<String> transactionHashFromProtoFormat(String txHash) async =>
      _transactionHashFromProtoFormat(txHash);
}

@JS('ConcordiumBlockchain.createIdentityRequestParams')
external JSPromise<JSString> _createIdentityRequestParams(
  String mnemonic,
  String network,
  String selectedIdentityProvider,
  String cryptographicParameters,
  int identityIndex,
);

@JS('ConcordiumBlockchain.createIdentityRecoveryParams')
external JSPromise<JSString> _createIdentityRecoveryParams(
  String seedPhrase,
  String network,
  String selectedIdentityProvider,
  int identityIndex,
  String cryptographicParameters,
);

@JS('ConcordiumBlockchain.createCredentialDeploymentTransaction')
external JSPromise<JSString> _createCredentialDeploymentTransaction(
  String seedPhrase,
  String network,
  int identityIndex,
  int credNumber,
  String identity,
  String selectedIdentityProvider,
  String global,
);

@JS('ConcordiumBlockchain.getAccountAddressFromMnemonic')
external String _getAccountAddressFromMnemonic(
    String seedPhrase,
    String network,
    int identityProviderIndex,
    int identityIndex,
    int credNumber,
    String cryptographicParameters);

@JS('ConcordiumBlockchain.getAccountSigningKey')
external String _getAccountSigningKey(
  String seedPhrase,
  String network,
  int identityProviderIndex,
  int identityIndex,
  int credNumber,
);

@JS('ConcordiumBlockchain.getAccountPublicKey')
external String _getAccountPublicKey(
  String seedPhrase,
  String network,
  int identityProviderIndex,
  int identityIndex,
  int credNumber,
);

@JS('ConcordiumBlockchain.createTransferTransactionParams')
external JSPromise<JSString> _createTransferTransactionParams(
  String senderAddress,
  String toAddress,
  int amount,
  String signingKey,
  int nonce,
);

@JS('ConcordiumBlockchain.createDelegationTransactionParams')
external JSPromise<JSString> _createDelegationTransactionParams(
  String senderAddress,
  String amount,
  String signingKey,
  int nonce,
  String restakeEarnings,
  String delegationTarget,
);

@JS('ConcordiumBlockchain.createBakerTransactionParams')
external JSPromise<JSString> _createBakerTransactionParams(
  String senderAddress,
  String signingKey,
  int nonce,
  String amount,
  String restakeEarnings,
  String bakerSettigs,
  String bakerKeys,
);

@JS('ConcordiumBlockchain.accountInfoFromProtoFormat')
external String _accountInfoFromProtoFormat(String accountInfo);

@JS('ConcordiumBlockchain.cryptographicParametersFromProtoFormat')
external String _cryptographicParametersFromProtoFormat(String cp);

@JS('ConcordiumBlockchain.transactionHashFromProtoFormat')
external String _transactionHashFromProtoFormat(String txHashRaw);
