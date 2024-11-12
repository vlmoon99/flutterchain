import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/webview_js_engine.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_runners/concordium/concordium_blockchain_js_runner_interface.dart';

ConcordiumBlockchainJsRunner getConcordiumJsRunner() =>
    ConcordiumBlockchainWebviewRunner();

class ConcordiumBlockchainWebviewRunner extends ConcordiumBlockchainJsRunner {
  final WebviewJsVMService jsVMService = WebviewJsVMService();

  @override
  Future<String> createIdentityRequestParams({
    required String mnemonic,
    required String network,
    required String selectedIdentityProvider,
    required String cryptographicParameters,
    required int identityIndex,
  }) async {
    final res = await jsVMService.callJSAsync(
        """window.ConcordiumBlockchain.createIdentityRequestParams('$mnemonic', '$network', '$selectedIdentityProvider', '$cryptographicParameters', $identityIndex ) """);
    return res.toString();
  }

  @override
  Future<String> createIdentityRecoveryParams({
    required String seedPhrase,
    required String network,
    required String selectedIdentityProvider,
    required int identityIndex,
    required String cryptographicParameters,
  }) async {
    final res = await jsVMService.callJSAsync(
        "window.ConcordiumBlockchain.createIdentityRecoveryParams('$seedPhrase', '$network', '$selectedIdentityProvider', $identityIndex, '$cryptographicParameters' ) ");
    return res.toString();
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
    final res = await jsVMService.callJSAsync(
        "window.ConcordiumBlockchain.createCredentialDeploymentTransaction('$seedPhrase', '$network', $identityIndex, $credNumber, '$identity', '$selectedIdentityProvider', '$global'  )");
    return res.toString();
  }

  @override
  Future<String> getAccountAddressFromMnemonic({
    required String seedPhrase,
    required String network,
    required int identityProviderIndex,
    required int identityIndex,
    required int credNumber,
    required String cryptographicParameters,
  }) async {
    final res = await jsVMService.callJS(
        "window.ConcordiumBlockchain.getAccountAddressFromMnemonic('$seedPhrase', '$network', $identityProviderIndex, $identityIndex, $credNumber, '$cryptographicParameters' )");
    return res.toString();
  }

  @override
  Future<String> getAccountSigningKey({
    required String seedPhrase,
    required String network,
    required int identityProviderIndex,
    required int identityIndex,
    required int credNumber,
  }) async {
    final res = await jsVMService.callJS(
        "window.ConcordiumBlockchain.getAccountSigningKey('$seedPhrase', '$network', $identityProviderIndex, $identityIndex, $credNumber )");
    return res.toString();
  }

  @override
  Future<String> getAccountPublicKey({
    required String seedPhrase,
    required String network,
    required int identityProviderIndex,
    required int identityIndex,
    required int credNumber,
  }) async {
    final res = await jsVMService.callJS(
        "window.ConcordiumBlockchain.getAccountPublicKey('$seedPhrase', '$network', $identityProviderIndex, $identityIndex, $credNumber )");
    return res.toString();
  }

  @override
  Future<String> createTransferTransactionParams({
    required String senderAddress,
    required String toAddress,
    required int amount,
    required String signingKey,
    required int nonce,
  }) async {
    final res = await jsVMService.callJSAsync(
        "window.ConcordiumBlockchain.createTransferTransactionParams('$senderAddress', '$toAddress', $amount, '$signingKey', $nonce )");
    return res.toString();
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
    final res = await jsVMService.callJSAsync(
        "window.ConcordiumBlockchain.createDelegationTransactionParams('$senderAddress', '$amount', '$signingKey', $nonce, '$restakeEarnings', '$delegationTarget' )");
    return res.toString();
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
    final res = await jsVMService.callJSAsync(
        "window.ConcordiumBlockchain.createBakerTransactionParams('$senderAddress', '$signingKey', $nonce, '$amount', '$restakeEarnings', '$bakerSettigs', '$bakerKeys' )");
    return res.toString();
  }

  @override
  Future<String> accountInfoFromProtoFormat(String accountInfo) async {
    final res = await jsVMService.callJS(
        '''window.ConcordiumBlockchain.accountInfoFromProtoFormat('$accountInfo')''');
    return res.toString();
  }

  @override
  Future<String> cryptographicParametersFromProtoFormat(
      String cryptographicParameters) async {
    final res = await jsVMService.callJS(
        '''window.ConcordiumBlockchain.cryptographicParametersFromProtoFormat('$cryptographicParameters')''');
    return res.toString();
  }

  @override
  Future<String> transactionHashFromProtoFormat(String txHash) async {
    final res = await jsVMService.callJS(
        "window.ConcordiumBlockchain.transactionHashFromProtoFormat('$txHash')");
    return res.toString();
  }
}
