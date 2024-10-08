import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/concordium_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_account_info.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_account_info_request.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_derivation_path.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/create_identity_request_params.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/identity_info.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/identity_provider.dart';
import 'package:flutterchain/flutterchain_lib/models/core/account_info_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain/flutterchain_lib/network/chains/concordium_grpc/concordium_rpc_client.dart';
import 'package:flutterchain/flutterchain_lib/services/core/blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/js_engine_stub.dart'
    if (dart.library.io) 'package:flutterchain/flutterchain_lib/services/core/js_engines/platforms_implementations/webview_js_engine.dart'
    if (dart.library.js) 'package:flutterchain/flutterchain_lib/services/core/js_engines/platforms_implementations/web_js_engine.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/js_vm.dart';
import 'package:flutterchain/flutterchain_lib/services/core/mnemonic_generator.dart';

class ConcordiumBlockChainService implements BlockChainService {
  final JsVMService jsVMService;
  ConcordiumRpcClient concordiumRpcClient;

  ConcordiumBlockChainService({
    JsVMService? jsVMService,
    required this.concordiumRpcClient,
  }) : jsVMService = jsVMService ?? getJsVM();

  factory ConcordiumBlockChainService.defaultInstance() {
    return ConcordiumBlockChainService(
      concordiumRpcClient: ConcordiumRpcClient.defaultInstance(),
      jsVMService: getJsVM(),
    );
  }

  /// Sets the client settings for the Concordium RPC client.
  ///
  /// Parameters:
  ///  - `baseUrl`: The base URL of the Concordium node.
  ///  - `port`: The port number of the Concordium node.
  ///  - `typeOfNetwork`: The type of network for the Concordium node.
  ///  - `networkClient` (Optional): The network client for the Concordium node.
  @override
  Future<void> setBlockchainNetworkEnvironment(
    BlockChainNetworkEnvironmentSettings blockChainNetworkEnvironmentSettings,
  ) async {
    if (blockChainNetworkEnvironmentSettings
        is! ConcordiumNetworkEnvironmentSettings) {
      throw ArgumentError(
        "Invalid blockChainNetworkEnvironmentSettings type. Expected: `ConcordiumNetworkEnvironmentSettings`",
      );
    }
    concordiumRpcClient = ConcordiumRpcClient(
      concordiumGrpcConnectionClient: ConcordiumGrpcConnectionClient(
        baseUrl: blockChainNetworkEnvironmentSettings.baseUrl,
        port: blockChainNetworkEnvironmentSettings.port,
      ),
      concordiumNetworkClient:
          blockChainNetworkEnvironmentSettings.networkClient ??
              ConcordiumNetworkClient.defaultInstance(),
      typeOfNetwork: blockChainNetworkEnvironmentSettings.typeOfNetwork,
    );
  }

  /// Returns the current client settings for the Concordium RPC client.
  ///
  /// Returns an object of type [ConcordiumNetworkEnvironmentSettings] containing
  /// the base URL, port number, type of network and network client used by the
  /// Concordium RPC client.
  @override
  Future<BlockChainNetworkEnvironmentSettings>
      getBlockchainNetworkEnvironment() async {
    return ConcordiumNetworkEnvironmentSettings(
      baseUrl: concordiumRpcClient.concordiumGrpcConnectionClient.baseUrl,
      port: concordiumRpcClient.concordiumGrpcConnectionClient.port,
      typeOfNetwork: concordiumRpcClient.typeOfNetwork,
      networkClient: concordiumRpcClient.concordiumNetworkClient,
    );
  }

  /// Returns a set of URLs of RPC endpoints for the Concordium blockchain.
  ///
  @override
  Set<String> getBlockchainsUrlsByBlockchainType() {
    return ConcordiumBlockchainNetworkUrls.listOfUrls;
  }

  /// Generates a mnemonic for the Concordium blockchain.
  ///
  /// Parameters:
  /// - `strength`: The strength of the mnemonic in bits (128-256).
  ///
  Future<String> generateMnemonic({
    int strength = 128,
  }) async {
    return MnemonicGenerator(jsVMService: jsVMService)
        .generateMnemonic(strength: strength);
  }

  /// Returns a list of identity providers for the Concordium blockchain.
  ///
  Future<List<IdentityProvider>> getIdentityProviders() async {
    final rawListOfIdentityProviders =
        await concordiumRpcClient.getIdentityProviders();
    return rawListOfIdentityProviders
        .map((identityProvInfo) => IdentityProvider.fromJson(identityProvInfo))
        .toList();
  }

  /// Retrieves parameters for the creating an identity for the Concordium blockchain.
  ///
  /// Parameters:
  /// - `mnemonic`: The mnemonic phrase generated by the [generateMnemonic] method.
  /// - `identityProvider`: The identity provider chosen from the [getIdentityProviders] method.
  /// - `identityIndex`: The index of the identity to use for generating the identity request parameters. Defaults to 0.
  ///
  Future<CreateIdentityRequestParams> getCreateIdentityRequestParams({
    required String mnemonic,
    required IdentityProvider identityProvider,
    int identityIndex = 0,
  }) async {
    final cryptographicParameters =
        await concordiumRpcClient.getCryptographicParameters();
    final String network = concordiumRpcClient.typeOfNetwork;

    final requestJson = await jsVMService.callJSAsync(
        """window.ConcordiumBlockchain.createIdentityRequestParams('$mnemonic', '$network', '${jsonEncode(identityProvider)}', '${jsonEncode(cryptographicParameters)}', $identityIndex ) """);

    return CreateIdentityRequestParams.fromJson(jsonDecode(requestJson));
  }

  /// Retrieves the URL to form for registering an identity.
  ///
  /// Parameters:
  /// - `identityProvider`: The identity provider chosen from the [getIdentityProviders] method.
  /// - `createIdentityRequestParams`: The parameters required for creating the identity request using the [getCreateIdentityRequestParams] method.
  /// - `redirectUrlToReturnForWeb`: The optional redirect URL for web platforms.
  ///
  Future<String> getIdentityCreateRequestUrl({
    required IdentityProvider identityProvider,
    required CreateIdentityRequestParams createIdentityRequestParams,
    String? redirectUrlToReturnForWeb,
  }) async {
    final String providerUrl = identityProvider.metadata["issuanceStart"];
    final Map<String, dynamic> params = {
      'scope': 'identity',
      'response_type': 'code',
      'redirect_uri': kIsWeb
          ? redirectUrlToReturnForWeb ?? Uri.base.toString()
          : "https://flutterchain.dev",
      'state': jsonEncode({'idObjectRequest': createIdentityRequestParams}),
    };
    final searchParams = Uri(queryParameters: params).query;

    final identityCreateRequestUrl = '$providerUrl?&$searchParams';

    return identityCreateRequestUrl;
  }

  /// Creates a dialog for creating an identity on a non-web platform. Returns url to get identity info.
  ///
  /// Parameters:
  /// - `context`: The [BuildContext] in which the dialog will be shown.
  /// - `creationUrl`: The URL to be used for creating the identity generated by the [getIdentityCreateRequestUrl] method.
  ///
  Future<String?> createIdentityDialog(
      {required BuildContext context, required String creationUrl}) async {
    if (!kIsWeb) {
      return showDialog<String?>(
        context: context,
        builder: (context) => Dialog.fullscreen(
          child: _WebView(initUrl: creationUrl),
        ),
      );
    } else {
      return null;
    }
  }

  /// Returns the identity information from the Concordium blockchain.
  ///
  /// Parameters:
  /// - `url`: The URL of the identity to retrieve information for.
  ///
  Future<IdentityInfo> getIdentityInfo(String url) async {
    final rawIdentityInfo = await concordiumRpcClient.getIdentityInfo(url);
    return IdentityInfo.fromJson(rawIdentityInfo);
  }

  /// Returns an existing identity information on the Concordium blockchain. Used for recovering an identity information to get rid of storing link to it.
  ///
  /// Parameters:
  /// - `mnemonic`: The mnemonic phrase generated by the [generateMnemonic] method.
  /// - `identityProvider`: The identity provider chosen from the [getIdentityProviders] method.
  /// - `identityIndex`: The index of the identity to return. Defaults to 0.
  ///
  Future<IdentityInfo> recoverExistingIdentity({
    required String mnemonic,
    required IdentityProvider identityProvider,
    int identityIndex = 0,
  }) async {
    final cryptographicParameters =
        await concordiumRpcClient.getCryptographicParameters();
    final String network = concordiumRpcClient.typeOfNetwork;

    final requestInfo = jsonDecode(await jsVMService.callJSAsync(
        "window.ConcordiumBlockchain.createIdentityRecoveryParams('$mnemonic', '$network', '${jsonEncode(identityProvider)}', '$identityIndex', '${jsonEncode(cryptographicParameters)}' ) "));

    final baseUrl = requestInfo['baseUrl'];
    final searchParams =
        Uri(queryParameters: requestInfo['searchParams']).query;

    final recoverRequestUrl = '$baseUrl?$searchParams';

    final recoverRequestUrlResponse = (await concordiumRpcClient
            .concordiumNetworkClient.dio
            .get(recoverRequestUrl))
        .data;

    return IdentityInfo.fromJson(recoverRequestUrlResponse["value"]);
  }

  /// Creates a new account on the Concordium blockchain.
  ///
  /// Parameters:
  /// - `mnemonic`: The mnemonic phrase generated by the [generateMnemonic] method.
  /// - `derivationPath`: The derivation path to figure out identity provider index, identity index and credential index(account index).
  /// - `identityInfo`: The identity information got from [getIdentityInfo] or [recoverExistingIdentity].
  /// - `identityProviderInfo`: The identity provider chosen from the [getIdentityProviders] method.
  ///
  /// Returns [BlockchainResponse] with the transaction hash data["txHash"] and account address data["accountAddress"].
  Future<BlockchainResponse> createAccount({
    required String mnemonic,
    required ConcordiumDerivationPath derivationPath,
    required IdentityInfo identityInfo,
    required IdentityProvider identityProviderInfo,
  }) async {
    final cryptographicParameters =
        await concordiumRpcClient.getCryptographicParameters();
    final String network = concordiumRpcClient.typeOfNetwork;

    final createCredentialDeploymentTransaction = await jsVMService.callJSAsync(
        "window.ConcordiumBlockchain.createCredentialDeploymentTransaction('$mnemonic', '$network', '${derivationPath.identityIndex}', '${derivationPath.credentialIndex}', '${jsonEncode(identityInfo)}', '${jsonEncode(identityProviderInfo)}', '${jsonEncode(cryptographicParameters)}'  )");

    final txInfo = Map<String, dynamic>.from(
        jsonDecode(createCredentialDeploymentTransaction));

    final txHash =
        await concordiumRpcClient.sendCredentialDeploymentTransaction(
      payload: List<int>.from(txInfo['payload']),
      expiryEpochSeconds: txInfo['expiry']['expiryEpochSeconds'],
    );

    return BlockchainResponse(
      status: (await getTransactionStatus(transactionHash: txHash)).status,
      data: {
        'txHash': txHash,
        'accountAddress': txInfo['accountAddress'],
      },
    );
  }

  /// Retrieves information about a Concordium account.
  ///
  /// Parameters:
  /// - `accountAddress`: The address of the account to retrieve information about.
  /// - `blockHash`: The hash of the block to retrieve the account information from. If null, the latest block will be used.
  ///
  /// Returns a [ConcordiumAccountInfo] object containing information about the account.
  Future<ConcordiumAccountInfo> getAccountInfo(
      AccountInfoRequest accountInfoRequest) async {
    if (accountInfoRequest is! ConcordiumAccountInfoRequest) {
      throw ArgumentError(
          "Invalid accountInfoRequest type. Expected: `ConcordiumAccountInfoRequest`");
    }
    final rawAccountInfo = await concordiumRpcClient.getAccountInfo(
      accountInfoRequest.accountAddress,
      accountInfoRequest.blockHash,
    );

    return ConcordiumAccountInfo.fromJson(rawAccountInfo);
  }

  @override
  Future<String> getWalletBalance(AccountInfoRequest accountInfoRequest) async {
    if (accountInfoRequest is! ConcordiumAccountInfoRequest) {
      throw ArgumentError(
          "Invalid accountInfoRequest type. Expected: `ConcordiumAccountInfoRequest`");
    }
    final rawAccountInfo = await concordiumRpcClient.getAccountInfo(
      accountInfoRequest.accountAddress,
      accountInfoRequest.blockHash,
    );

    return ConcordiumAccountInfo.fromJson(rawAccountInfo).accountAmount;
  }

  /// Returns the account address derived from the given mnemonic and derivation path.
  ///
  /// - `mnemonic`: The mnemonic phrase generated by the [generateMnemonic] method.
  /// - `derivationPath`: The derivation path to figure out identity provider index, identity index and credential index(account index).
  ///
  Future<String> getAccountAddressFromMnemonic({
    required String mnemonic,
    required ConcordiumDerivationPath derivationPath,
  }) async {
    final Map<String, dynamic> cryptographicParameters =
        await concordiumRpcClient.getCryptographicParameters();
    final String network = concordiumRpcClient.typeOfNetwork;

    return await jsVMService.callJS(
        "window.ConcordiumBlockchain.getAccountAddressFromMnemonic('$mnemonic', '$network', '${derivationPath.identityProviderIndex}', '${derivationPath.identityIndex}', '${derivationPath.credentialIndex}', '${jsonEncode(cryptographicParameters)}' )");
  }

  /// Retrieves the account signing key derived from the given mnemonic and derivation path.
  ///
  /// Parameters:
  /// - `mnemonic`: The mnemonic phrase generated by the [generateMnemonic] method.
  /// - `derivationPath`: The derivation path to figure out identity provider index, identity index and credential index(account index).
  ///
  Future<String> getAccountPrivateKey({
    required String mnemonic,
    required ConcordiumDerivationPath derivationPath,
  }) async {
    final String network = concordiumRpcClient.typeOfNetwork;

    return await jsVMService.callJS(
        "window.ConcordiumBlockchain.getAccountSigningKey('$mnemonic', '$network', '${derivationPath.identityProviderIndex}', '${derivationPath.identityIndex}', '${derivationPath.credentialIndex}' )");
  }

  /// Retrieves the account public key derived from the given mnemonic and derivation path.
  ///
  /// Parameters:
  /// - `mnemonic`: The mnemonic phrase generated by the [generateMnemonic] method.
  /// - `derivationPath`: The derivation path to figure out identity provider index, identity index and credential index(account index).
  ///
  Future<String> getAccountPublicKey({
    required String mnemonic,
    required ConcordiumDerivationPath derivationPath,
  }) async {
    final String network = concordiumRpcClient.typeOfNetwork;
    return await jsVMService.callJS(
        "window.ConcordiumBlockchain.getAccountPublicKey('$mnemonic', '$network', '${derivationPath.identityProviderIndex}', '${derivationPath.identityIndex}', '${derivationPath.credentialIndex}' )");
  }

  /// Retrieves the status of a transaction on the Concordium blockchain.
  ///
  /// Parameters:
  /// - `transactionHash`: The hash of the transaction to retrieve the status for.
  ///
  /// Returns a [BlockchainResponse] object containing the status and information data of the transaction.
  Future<BlockchainResponse> getTransactionStatus(
      {required String transactionHash}) async {
    final rawStatus = await concordiumRpcClient.getTransactionStatus(
      transactionHash: transactionHash,
    );
    return BlockchainResponse(
      status: rawStatus['status'],
      data: rawStatus['data'],
    );
  }

  /// Retrieves the Concordium blockchain data derived from the given mnemonic and derivation path.
  ///
  /// Parameters:
  /// - `mnemonic`: The mnemonic phrase generated by the [generateMnemonic] method.
  /// - `derivationPath`: The derivation path to figure out identity provider index, identity index and credential index(account index).
  ///
  /// Returns a [ConcordiumBlockChainData] object containing the derived account address, public key, signing key, mnemonic, and derivation path.
  @override
  Future<BlockChainData> getBlockChainData({
    required String mnemonic,
    String? passphrase,
    DerivationPathData? derivationPath,
  }) async {
    if (derivationPath == null) {
      throw ArgumentError("Missing derivation path data");
    } else if (derivationPath is! ConcordiumDerivationPath) {
      throw ArgumentError(
          "Invalid derivationPath type. Expected: `ConcordiumDerivationPath`");
    }

    final String accountAddress = await getAccountAddressFromMnemonic(
      mnemonic: mnemonic,
      derivationPath: derivationPath,
    );
    final privateKeyRaw = await getAccountPrivateKey(
      mnemonic: mnemonic,
      derivationPath: derivationPath,
    );
    final publicKeyRaw = await getAccountPublicKey(
      mnemonic: mnemonic,
      derivationPath: derivationPath,
    );

    return ConcordiumBlockChainData(
      accountAddress: accountAddress,
      publicKey: publicKeyRaw,
      privateKey: privateKeyRaw,
      derivationPath: derivationPath,
    );
  }

  /// Sends a transfer transaction on the Concordium blockchain.
  ///
  /// Parameters:
  /// - `senderAddress`: The address of the sender's account.
  /// - `toAddress`: The address of the recipient's account.
  /// - `transferAmountInMicroCcd`: The amount to transfer in micro CCD.
  /// - `privateKey`: The signing key of the sender's account.
  ///
  /// Returns a [BlockchainResponse] object containing the status and information data of the transaction.
  @override
  Future<BlockchainResponse> sendTransferNativeCoin(
      TransferRequest transferRequest) async {
    if (transferRequest is! ConcordiumTransferRequest) {
      throw ArgumentError(
          "Invalid transferRequest type. Expected: `ConcordiumTransferRequest`");
    }
    final nonce = await concordiumRpcClient
        .getNextAccountNonce(transferRequest.senderAddress);
    final txParams = jsonDecode(await jsVMService.callJSAsync(
        "window.ConcordiumBlockchain.createTransferTransactionParams('${transferRequest.senderAddress}', '${transferRequest.toAddress}', '${transferRequest.transferAmountInMicroCcd}', '${transferRequest.privateKey}', '$nonce' )"));
    final txHash = await concordiumRpcClient.sendTransaction(
      accountTransactionParams: txParams,
    );

    return BlockchainResponse(
      status: (await getTransactionStatus(transactionHash: txHash)).status,
      data: {
        'txHash': txHash,
      },
    );
  }

  /// Sends a delegation transaction on the Concordium blockchain.
  ///
  /// Parameters:
  /// - `senderAddress`: The address of the sender's account.
  /// - `privateKey`: The signing key of the sender's account.
  ///
  /// Optional parameters:
  /// - `amountInMicroCcd`: The amount to delegate in micro CCD.
  /// - `restakeEarnings`: Whether or not to restake earnings. Defaults to [true].
  /// - `delegationType`: The type of delegation. Can be 'Passive' or 'Baker'. Check [ConcordiumDelegationType] to see all possible values.
  /// - `bakerId`: The ID of the baker. Required if `delegationType` is 'Baker'.
  ///
  /// For initial delegation all optional parameters are required.
  ///
  /// Returns a [BlockchainResponse] object containing the status and information data of the transaction.
  Future<BlockchainResponse> sendDelegationTransaction({
    required String senderAddress,
    required String privateKey,
    int? amountInMicroCcd,
    bool? restakeEarnings,
    String? delegationType,
    String? bakerId,
  }) async {
    final nonce = await concordiumRpcClient.getNextAccountNonce(senderAddress);
    late final Map<String, dynamic>? delegationTarget;
    if (delegationType == 'Passive') {
      delegationTarget = {
        "delegateType": "Passive",
      };
    } else if (delegationType == 'Baker') {
      delegationTarget = {
        "delegateType": "Baker",
        "bakerId": bakerId,
      };
    } else {
      delegationTarget =
          {}; // if [delegationType] is null we don't change delegation target
    }
    final txParams = jsonDecode(await jsVMService.callJSAsync(
        "window.ConcordiumBlockchain.createDelegationTransactionParams('$senderAddress', '$amountInMicroCcd', '$privateKey', '$nonce', '$restakeEarnings', '${jsonEncode(delegationTarget)}' )"));
    final txHash = await concordiumRpcClient.sendTransaction(
      accountTransactionParams: Map<String, dynamic>.from(txParams),
    );
    return BlockchainResponse(
      status: (await getTransactionStatus(transactionHash: txHash)).status,
      data: {
        'txHash': txHash,
      },
    );
  }

  /// Sends a baker transaction on the Concordium blockchain.
  ///
  /// Parameters:
  /// - `senderAddress`: The address of the sender's account.
  /// - `privateKey`: The signing key of the sender's account.
  ///
  /// Optional parameters:
  /// - `stakeAmountInMicroCcd`: The stake amount in micro CCD. Minimum stake amount is 14000000000. If set to 0, restakes earnings.
  /// - `restakeEarnings`: Whether or not to restake earnings. Defaults to true.
  /// - `openStatus`: The open status of the baker. Check the [DelegationOpenStatus] enum for available options.
  /// - `metadataUrl`: The metadata URL of the baker.
  /// - `transactionFeeCommissionInPercentage`: The transaction fee commission in percentage. Range: 0-100%.
  /// - `bakingRewardCommissionInPercentage`: The baking reward commission in percentage. Range: 0-100%.
  /// - `finalizationRewardCommissionInPercentage`: The finalization reward commission in percentage. Range: 0-100%.
  /// - `bakerKeys`: The baker keys in JSON format. If empty, the keys will be recreated.
  ///
  /// For initial baker all optional parameters are required (except `bakerKeys`).
  ///
  /// Returns a [BlockchainResponse] object containing the status and information data of the transaction.
  Future<BlockchainResponse> sendBakerTransaction({
    required String senderAddress,
    required String privateKey,
    int? stakeAmountInMicroCcd,
    bool? restakeEarnings,
    DelegationOpenStatus? openStatus,
    String? metadataUrl,
    double? transactionFeeCommissionInPercentage, // 0-100%
    double? bakingRewardCommissionInPercentage, // 0-100%
    double? finalizationRewardCommissionInPercentage, // 0-100%
    Map<String, dynamic> bakerKeys =
        const {}, // here we put baker keys in json format or leave it empty to recreate them. keys could be obtain after initial call baker tx in response
  }) async {
    final nonce = await concordiumRpcClient.getNextAccountNonce(senderAddress);
    final bakerSettings = {
      if (openStatus != null) "openForDelegation": openStatus.index,
      if (metadataUrl != null) "metadataUrl": metadataUrl,
      if (transactionFeeCommissionInPercentage != null)
        "transactionFeeCommission": transactionFeeCommissionInPercentage * 1000,
      if (bakingRewardCommissionInPercentage != null)
        "bakingRewardCommission": bakingRewardCommissionInPercentage * 1000,
      if (finalizationRewardCommissionInPercentage != null)
        "finalizationRewardCommission":
            finalizationRewardCommissionInPercentage * 1000,
    };
    final txParams = jsonDecode(await jsVMService.callJSAsync(
        "window.ConcordiumBlockchain.createBakerTransactionParams('$senderAddress', '$privateKey', '$nonce', '$stakeAmountInMicroCcd', '$restakeEarnings', '${jsonEncode(bakerSettings)}', '${jsonEncode(bakerKeys)}' )"));
    final txHash = await concordiumRpcClient.sendTransaction(
      accountTransactionParams: Map<String, dynamic>.from(txParams),
    );
    return BlockchainResponse(
      status: (await getTransactionStatus(transactionHash: txHash)).status,
      data: {
        'txHash': txHash,
        'bakerKeys': Map<String, dynamic>.from(txParams)['bakerKeys'],
      },
    );
  }
}

// ignore: constant_identifier_names
enum DelegationOpenStatus { OpenForAll, ClosedForNew, ClosedForAll }

class ConcordiumDelegationType {
  static const String passive = "Passive";
  static const String baker = "Baker";
}

class _WebView extends StatefulWidget {
  const _WebView({super.key, required this.initUrl});

  final String initUrl;

  @override
  State<_WebView> createState() => _WebViewState();
}

class _WebViewState extends State<_WebView> {
  final InAppWebViewSettings settings = InAppWebViewSettings(
    mediaPlaybackRequiresUserGesture: false,
    allowsInlineMediaPlayback: true,
    iframeAllowFullscreen: true,
  );

  late InAppWebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialUrlRequest: URLRequest(
        url: WebUri(widget.initUrl.toString()),
      ),
      initialSettings: settings,
      onWebViewCreated: (controller) {},
      onLoadStart: (controller, url) {
        log(url.toString());
      },
      onPermissionRequest: (controller, request) async {
        return PermissionResponse(
          resources: request.resources,
          action: PermissionResponseAction.GRANT,
        );
      },
      shouldOverrideUrlLoading: (controller, navigationAction) async {
        return NavigationActionPolicy.ALLOW;
      },
      onLoadStop: (controller, url) {},
      onUpdateVisitedHistory: (controller, url, isReload) {
        final urlStr = url.toString();
        if (urlStr.contains("flutterchain.dev")) {
          controller.stopLoading();
          final urlToGetIdentityInfo =
              RegExp(r'code_uri=([^&]+)').firstMatch(urlStr)?.group(1);
          Navigator.of(context).pop(urlToGetIdentityInfo);
        }
      },
    );
  }
}
