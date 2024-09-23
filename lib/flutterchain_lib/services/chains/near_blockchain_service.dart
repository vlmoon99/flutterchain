import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:decimal/decimal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/blockchains_gas.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/near_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/webview_constants.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/mintbase_category_nft.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_account_info_request.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_smart_contract_arguments.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_mpc_account_info.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_mpc_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/account_info_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_smart_contract_arguments.dart';
import 'package:flutterchain/flutterchain_lib/models/core/transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain/flutterchain_lib/network/chains/near_rpc_client.dart';
import 'package:flutterchain/flutterchain_lib/services/core/blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/js_vm.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/js_engine_stub.dart'
    if (dart.library.io) 'package:flutterchain/flutterchain_lib/services/core/js_engines/platforms_implementations/webview_js_engine.dart'
    if (dart.library.js) 'package:flutterchain/flutterchain_lib/services/core/js_engines/platforms_implementations/web_js_engine.dart';
import 'package:flutterchain/flutterchain_lib/services/core/mnemonic_generator.dart';

class NearBlockChainService
    implements BlockchainServiceWithSmartContractCallSupport {
  final JsVMService jsVMService;
  final NearRpcClient nearRpcClient;

  NearBlockChainService({
    required this.jsVMService,
    required this.nearRpcClient,
  });

  factory NearBlockChainService.defaultInstance() {
    return NearBlockChainService(
      jsVMService: getJsVM(),
      nearRpcClient: NearRpcClient.defaultInstance(),
    );
  }

  //Core

  //Generate mnemonic
  Future<String> generateMnemonic({
    int strength = 128,
  }) async {
    return MnemonicGenerator(jsVMService: jsVMService)
        .generateMnemonic(strength: strength);
  }

  //Send Near tokens thought near blockchain
  @override
  Future<BlockchainResponse> sendTransferNativeCoin(
      TransferRequest transferRequest) async {
    if (transferRequest is! NearTransferRequest) {
      throw ArgumentError(
          'Incorrect TransferRequest type. Expected: `NearTransferRequest`');
    }

    final transactionInfo = await getTransactionInfo(
      accountId: transferRequest.accountId ?? transferRequest.publicKey,
      publicKey: transferRequest.publicKey,
    );

    final gas = transferRequest.gas ?? BlockchainGas.gas[BlockChains.near]!;

    final actions = [
      {
        "type": "transfer",
        "data": {"amount": transferRequest.transferAmount}
      }
    ];

    final signedAction = await signNearActions(
      fromAddress: transferRequest.accountId ?? transferRequest.publicKey,
      toAddress: transferRequest.toAddress,
      transferAmount: transferRequest.transferAmount,
      privateKey: transferRequest.privateKey,
      gas: gas,
      nonce: transactionInfo.nonce,
      blockHash: transactionInfo.blockHash,
      actions: actions,
    );

    final res = await nearRpcClient.sendSyncTx([signedAction]);
    return res;
  }

  //Call smart contract function
  @override
  Future<BlockchainResponse> callSmartContractFunction(
    BlockChainSmartContractArguments smartContractArguments,
  ) async {
    if (smartContractArguments is! NearBlockChainSmartContractArguments) {
      throw ArgumentError(
          "Incorrect smartContractArguments type. Expected: `NearBlockChainSmartContractArguments`");
    }

    final transactionInfo = await getTransactionInfo(
      accountId:
          smartContractArguments.accountId ?? smartContractArguments.publicKey,
      publicKey: smartContractArguments.publicKey,
    );

    final gas =
        smartContractArguments.gas ?? BlockchainGas.gas[BlockChains.near]!;

    final List<Map<String, dynamic>> actions = [
      {
        "type": "functionCall",
        "data": {
          "methodName": smartContractArguments.method,
          "args": smartContractArguments.args,
        },
      },
    ];

    final signedAction = await signNearActions(
      fromAddress:
          smartContractArguments.accountId ?? smartContractArguments.publicKey,
      toAddress: smartContractArguments.toAddress,
      transferAmount: smartContractArguments.transferAmount,
      privateKey: smartContractArguments.privateKey,
      gas: gas,
      nonce: transactionInfo.nonce,
      blockHash: transactionInfo.blockHash,
      actions: actions,
    );
    final res = await nearRpcClient.sendSyncTx([signedAction]);
    return res;
  }

  Future<BlockchainResponse> callViewMethod({
    required String contractId,
    required String method,
    Map<String, dynamic> args = const {},
  }) async {
    final res = await nearRpcClient.callViewMethod(
      contractId: contractId,
      method: method,
      args: args,
    );

    return res;
  }

  //Get wallet balance by account ID (hex representation of near account)
  @override
  Future<String> getWalletBalance(AccountInfoRequest accountInfoRequest) async {
    if (accountInfoRequest is! NearAccountInfoRequest) {
      throw ArgumentError(
          "Invalid accountInfoRequest type. Expected: `NearAccountInfoRequest`");
    }
    final res =
        await nearRpcClient.getAccountBalance(accountInfoRequest.accountId);
    return res;
  }

  //Setting new blockchain network environment on another url

  @override
  Future<void> setBlockchainNetworkEnvironment(
      BlockChainNetworkEnvironmentSettings
          blockChainNetworkEnvironmentSettings) async {
    if (blockChainNetworkEnvironmentSettings
        is! NearNetworkEnvironmentSettings) {
      throw ArgumentError(
          "Invalid blockChainNetworkEnvironmentSettings type. Expected: `NearNetworkEnvironmentSettings`");
    }
    nearRpcClient.networkClient
        .setUrl(blockChainNetworkEnvironmentSettings.chainUrl);
  }

  //Getting official blockchain's urls
  @override
  Set<String> getBlockchainsUrlsByBlockchainType() {
    return NearBlockChainNetworkUrls.listOfUrls;
  }

  ///Getting private , public key and other information from mnemonic and passphrase
  ///this method will give you first standard wallet generated from this mnemonic and passphrase if derivation path is not provided
  @override
  Future<BlockChainData> getBlockChainData({
    required String mnemonic,
    String? passphrase,
    DerivationPathData? derivationPath,
  }) async {
    final rawFunction = derivationPath == null
        ? "window.NearBlockchain.getBlockChainDataFromMnemonic('$mnemonic','$passphrase')"
        : """window.NearBlockchain.getBlockChainDataFromMnemonic('$mnemonic','$passphrase', "${(derivationPath as DerivationPath).accountNumber}","${derivationPath.change}","${derivationPath.address}")""";
    final res = await jsVMService.callJS(rawFunction);
    final blockChainData = NearBlockChainData.fromJson(jsonDecode(res));
    return blockChainData;
  }

  //Platform specifics methods

  //When you wanna make any transaction -
  //first of all you will need to get nonce and block hash from the Near blockchain
  //this method will give you nonce and block hash
  //from accountId and publicKey
  Future<NearTransactionInfoModel> getTransactionInfo(
      {required String accountId, required String publicKey}) async {
    final res = await nearRpcClient.getTransactionInfo(accountId, publicKey);

    return res;
  }

  //This method helps sending transactions in sync way
  Future<BlockchainResponse> sendTransactionNearSync({
    required List<String> params,
  }) =>
      nearRpcClient.sendSyncTx(params);

  //This method helps sending transactions in async way
  Future<BlockchainResponse> sendTransactionNearAsync({
    required List<String> params,
  }) =>
      nearRpcClient.sendAsyncTx(params);

  //This method helps sign near actions , you can find this actions description here -> https://nomicon.io/RuntimeSpec/Actions
  //This is a core method to got signed transaction from your list of actions

  Future<String> signNearActions({
    required String fromAddress,
    required String toAddress,
    required String transferAmount,
    required String privateKey,
    required String gas,
    required int nonce,
    required String blockHash,
    required List<Map<String, dynamic>> actions,
  }) async {
    nonce++;
    final res = await jsVMService.callJS(
        "window.NearBlockchain.signNearActions('$fromAddress','$toAddress','$transferAmount', '$gas' , '$privateKey','$nonce','$blockHash','${jsonEncode(actions)}')");

    Map<String, dynamic> decodedRes = jsonDecode(res);
    if (decodedRes.containsKey("error")) {
      throw Exception("Error: ${decodedRes["error"]}");
    }

    final signedTx = decodedRes['signedTransaction'].toString();
    return signedTx;
  }

  Future<BlockchainResponse> deleteKey({
    required String accountId,
    required String deletedPublicKey,
    required String privateKey,
    required String publicKey,
  }) async {
    final transactionInfo = await getTransactionInfo(
      accountId: accountId,
      publicKey: publicKey,
    );
    final gas = BlockchainGas.gas[BlockChains.near];
    if (gas == null) {
      throw Exception('Incorrect Blockchain Gas');
    }

    final List<Map<String, dynamic>> actions = [
      {
        "type": "deleteKey",
        "data": {
          "publicKey": deletedPublicKey,
        },
      },
    ];

    final signedAction = await signNearActions(
      fromAddress: accountId,
      toAddress: accountId,
      transferAmount: "0",
      privateKey: privateKey,
      gas: gas,
      nonce: transactionInfo.nonce,
      blockHash: transactionInfo.blockHash,
      actions: actions,
    );
    final res = await nearRpcClient.sendSyncTx([signedAction]);
    return res;
  }

  //This method add key to the account
  //This method also need mnemonic and derivationPath for generating a new key
  Future<BlockchainResponse> addKey({
    required String fromAddress,
    required String mnemonic,
    String passphrase = '',
    required DerivationPath derivationPathOfNewGeneratedAccount,
    required String permission,
    required String allowance,
    required String smartContractId,
    required List<String> methodNames,
    required String privateKey,
    required String publicKey,
  }) async {
    final transactionInfo = await getTransactionInfo(
      accountId: fromAddress,
      publicKey: publicKey,
    );
    final gas = BlockchainGas.gas[BlockChains.near];
    if (gas == null) {
      throw Exception('Incorrect Blockchain Gas');
    }

    final List<Map<String, dynamic>> actions = [
      {
        "type": "addKey",
        "data": {
          "mnemonic": mnemonic,
          "passphrase": passphrase,
          "indexOfTheDerivationAccount": derivationPathOfNewGeneratedAccount
              .accountNumber
              .replaceAll("'", ""),
          "permission": permission,
          "receiverId": smartContractId,
          "methodNames": methodNames,
        },
      },
    ];

    final signedAction = await signNearActions(
      fromAddress: fromAddress,
      toAddress: fromAddress,
      transferAmount: allowance,
      privateKey: privateKey,
      gas: gas,
      nonce: transactionInfo.nonce,
      blockHash: transactionInfo.blockHash,
      actions: actions,
    );
    final res = await nearRpcClient.sendSyncTx([signedAction]);
    return res;
  }

  //This method export private key from Flutterchain to the near-api-js format
  Future<String> exportPrivateKeyToTheNearApiJsFormat(
      {BlockChainData? currentBlockchainData}) async {
    if (currentBlockchainData == null) {
      throw Exception('currentBlockchainData is incorrect');
    }
    final res = await jsVMService.callJS(
        "window.NearBlockchain.exportSecretKeyToNearApiJSFormat('${currentBlockchainData.privateKey}','${currentBlockchainData.publicKey}')");
    return res.toString();
  }

  //This method will transform Near public key (which in hex format) to Base58 format with "ed25519:" prefix
  Future<String> getBase58PubKeyFromHexValue(
      {required String? hexEncodedPubKey}) async {
    if (hexEncodedPubKey == null) {
      throw Exception('hexEncodedPubKey is incorrect');
    }
    final res = await jsVMService.callJS(
        "window.NearBlockchain.getBase58PubKeyFromHexValue('$hexEncodedPubKey')");
    return res.toString();
  }

  //This method getting Public Key in hex format from Secret key (which was generated on near-api-js)
  Future<String> getPublicKeyFromSecretKeyFromNearApiJSFormat(
      String base58PrivateKey) async {
    final res = await jsVMService.callJS(
        "window.NearBlockchain.getPublicKeyFromSecretKeyFromNearApiJSFormat('$base58PrivateKey')");
    return res.toString();
  }

  //This method getting Private Key in base64 format from Secret key (which was generated on near-api-js)
  Future<String> getPrivateKeyFromSecretKeyFromNearApiJSFormat(
      String base58PrivateKey) async {
    final res = await jsVMService.callJS(
        "window.NearBlockchain.getPrivateKeyFromSecretKeyFromNearApiJSFormat('$base58PrivateKey')");
    return res.toString();
  }

  @override
  Future<BlockChainNetworkEnvironmentSettings>
      getBlockchainNetworkEnvironment() async {
    return NearNetworkEnvironmentSettings(
      chainUrl: nearRpcClient.networkClient.dio.options.baseUrl,
    );
  }

  //Login with Near Wallets

  Future<void> authWithNearWalletsWeb(String privateNearAPIjsFormat,
      [String? successUrlCallBackWeb, String? failureUrlCallBackWeb]) async {
    final currentUrl = await jsVMService.callJS("window.location.href");
    await jsVMService.callJS('''
    // Create a script element
    var script = document.createElement('script');

    // Set the script source, integrity, and crossorigin attributes
    script.src = 'https://cdn.jsdelivr.net/npm/near-api-js@0.44.2/dist/near-api-js.min.js';
    script.integrity = 'sha256-W5o4c5DRZZXMKjuL41jsaoBpE/UHMkrGvIxN9HcjNSY=';
    script.crossOrigin = 'anonymous';

    // Add an event listener to execute code when the script has loaded
    script.onload = function() {
        // Your code to run after the script has loaded
        console.log('Near API JS has loaded!');
        const addNewFullAccessKeyToTheNearBlockchain = async (key) => {
            const { keyStores, KeyPair, connect, WalletConnection } = nearApi;
            const myKeyStore = new keyStores.BrowserLocalStorageKeyStore();
            const connectionConfig = {
                networkId: "mainnet",
                keyStore: myKeyStore,
                nodeUrl: "https://rpc.mainnet.near.org",
                walletUrl: "https://app.mynearwallet.com",
                helperUrl: "https://helper.mainnet.near.org",
                explorerUrl: "https://explorer.mainnet.near.org",
            };
            const nearConnection = await connect(connectionConfig);
            const wallet = new WalletConnection(nearConnection);

            const PENDING_ACCESS_KEY_PREFIX = "pending_key";

            const loginFullAccess = async (options) => {
                const currentUrl = new URL(window.location.href);
                const newUrl = new URL(wallet._walletBaseUrl + "/login/");
                newUrl.searchParams.set("success_url", "${successUrlCallBackWeb ?? currentUrl}");
                newUrl.searchParams.set("failure_url", "${failureUrlCallBackWeb ?? currentUrl}");

                const accessKey = KeyPair.fromString(key);
                newUrl.searchParams.set("public_key", accessKey.getPublicKey().toString());
                await wallet._keyStore.setKey(
                    wallet._networkId,
                    PENDING_ACCESS_KEY_PREFIX + accessKey.getPublicKey(),
                    accessKey
                );

                window.location.assign(newUrl.toString());
            };


            loginFullAccess();


        };

        window.addNewFullAccessKeyToTheNearBlockchain = addNewFullAccessKeyToTheNearBlockchain;
       addNewFullAccessKeyToTheNearBlockchain('$privateNearAPIjsFormat');
    };

    // Append the script element to the head of the document
    document.head.appendChild(script);

   // window.addNewFullAccessKeyToTheNearBlockchain('$privateNearAPIjsFormat');

''');
  }

  String? getAccountIdFromWalletRedirectOnTheWeb() {
    if (!kIsWeb) {
      return 'no_web_env';
    }
    String? accountId = Uri.base.queryParameters["account_id"];
    return accountId;
  }

  Future<String> authWithNearWallets(
    BuildContext context,
    String privateNearAPIjsFormat,
  ) async {
    InAppWebViewSettings settings = InAppWebViewSettings(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      iframeAllowFullscreen: true,
    );

    final accountID = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(),
          child: InAppWebView(
            initialUrlRequest: URLRequest(
              url: WebUri(WebViewConstants.nearLoginThroughWebView),
            ),
            initialSettings: settings,
            onWebViewCreated: (controller) {},
            onLoadStart: (controller, url) {},
            onPermissionRequest: (controller, request) async {
              return PermissionResponse(
                  resources: request.resources,
                  action: PermissionResponseAction.GRANT);
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              return NavigationActionPolicy.ALLOW;
            },
            onLoadStop: (controller, url) async {
              controller.evaluateJavascript(source: '''
          window.addNewFullAcseesKeyToTheNearBlockchain("$privateNearAPIjsFormat").then((res) => {
                console.log('Key was added suscessfuly');
              });
        ''');
            },
            onReceivedError: (controller, request, error) {},
            onProgressChanged: (controller, progress) {},
            onUpdateVisitedHistory: (controller, url, androidIsReload) async {
              if (url?.rawValue ==
                  'https://app.mynearwallet.com/authorized-apps') {
                final accountId = (await controller.webStorage.localStorage
                        .getItems())
                    .where(
                        (element) => element.value.toString().contains('.near'))
                    .toList()
                    .firstWhere(
                        (element) => !element.value.toString().startsWith("{"))
                    .value;

                // ignore: use_build_context_synchronously
                Navigator.pop(context, accountId);
              }
            },
            onConsoleMessage: (controller, consoleMessage) {
              // log(consoleMessage.toString());
            },
          ),
        );
      },
    );
    return accountID ?? 'no_account_id';
  }

  //MPC implementation

  Future<MPCAccountInfo> getMPCAccount({
    required String accountId,
    String path = "flutterchain",
    String chain = BlockChains.ethereum,
    String typeOfNetwork = "testnet",
    String? mpcPublicKey,
  }) async {
    final mpcAccountInfoData = await jsVMService.callJSAsync(
      "window.generateAddressForNearMPC('$accountId', '$path', '$chain', ${mpcPublicKey != null ? "'$mpcPublicKey'" : 'undefined'}, '$typeOfNetwork')",
    );
    final mpcAccountInfo =
        json.decode(mpcAccountInfoData) as Map<String, dynamic>;
    return MPCAccountInfo(
      address: mpcAccountInfo["address"],
      publicKey: mpcAccountInfo["publicKey"],
    );
  }

  /// Signs an EVM transaction with the Near MPC.
  ///
  /// Parameters:
  /// - [accountId]: The account ID of the Near sender.
  /// - [publicKey]: The public key of the Near sender.
  /// - [privateKey]: The private key of the Near sender.
  /// - [mpcTransactionInfo]: The transaction information obtained from the MPC.
  /// - [senderAddress]: The address of the sender provided by the MPC.
  /// - [path]: The path used for the MPC signing.
  /// - [mpcContract]: The contract address of the MPC.
  ///
  /// Returns the signed transaction as a string.
  Future<String> signEVMTransactionWithMPC({
    required String accountId,
    required String publicKey,
    required String privateKey,
    required MpcTransactionInfo mpcTransactionInfo,
    required String senderAddress,
    String path = "flutterchain",
    String mpcContract = 'v2.multichain-mpc.testnet',
  }) async {
    final unsignedTransaction = mpcTransactionInfo.transactionInfo;
    final payload = Uint8List.fromList(
        List<int>.from(unsignedTransaction["payload"].values));
    final reversedPayload = payload.reversed.toList();
    final nearSignRequest = await callSmartContractFunction(
      NearBlockChainSmartContractArguments(
        accountId: accountId,
        publicKey: publicKey,
        toAddress: mpcContract,
        privateKey: privateKey,
        gas: "300000000000000",
        method: "sign",
        args: {
          "payload": reversedPayload,
          "path": path,
          "key_version": 0,
        },
        transferAmount: '0',
      ),
    );

    if (nearSignRequest.data["error"] != null) {
      throw Exception(nearSignRequest.data["error"]);
    }

    final signatureValList =
        List<String>.from(jsonDecode(nearSignRequest.data["success"]));

    final signatureData = jsonEncode({
      "big_r": signatureValList[0],
      "big_s": signatureValList[1],
    });

    final serializedUnsignedTransaction = Uint8List.fromList(
        List<int>.from(unsignedTransaction["transaction"].values));

    final signedTransaction = await jsVMService.callJS(
      "window.EVMUtils.signTransactionWithMPCSignature('$signatureData', '${jsonEncode(serializedUnsignedTransaction)}', '$senderAddress', '${unsignedTransaction["typeOfTransaction"]}', '${jsonEncode(unsignedTransaction['chainInfo'])}')",
    );

    return signedTransaction;
  }

  /// Signs a Bitcoin transaction with the Near MPC.
  ///
  /// Parameters:
  /// - [accountId]: The account ID of the Near sender.
  /// - [publicKey]: The public key of the Near sender.
  /// - [privateKey]: The private key of the Near sender.
  /// - [transactionInfo]: The transaction information obtained from the MPC.
  /// - [mpcSenderPublicKey]: The public key of the sender provided by the MPC.
  /// - [path]: The path used for the MPC signing.
  /// - [mpcContract]: The contract address of the MPC.
  ///
  /// Returns the signed transaction as a string.
  Future<String> signBTCTransactionWithMPC({
    required String accountId,
    required String publicKey,
    required String privateKey,
    required MpcTransactionInfo transactionInfo,
    required String mpcSenderPublicKey,
    String path = "flutterchain",
    String mpcContract = 'v2.multichain-mpc.testnet',
  }) async {
    final unsignedTransaction = transactionInfo.transactionInfo;

    //Get payloads of all utxos
    final payloadsListEncoded = await jsVMService.callJS(
        "window.BitcoinUtils.getReversedPayloadsToSignForMPC('${unsignedTransaction['psbt']}', '${jsonEncode(unsignedTransaction['utxos'])}', '$mpcSenderPublicKey')");
    final payloadsList = jsonDecode(payloadsListEncoded) as List<dynamic>;

    final List<Map<String, dynamic>> signatures = [];

    //Get signatures for each payload
    for (var i = 0; i < payloadsList.length; i++) {
      final payload = Uint8List.fromList(List<int>.from(payloadsList[i]));

      final nearSignRequest = await callSmartContractFunction(
        NearBlockChainSmartContractArguments(
          accountId: accountId,
          publicKey: publicKey,
          toAddress: mpcContract,
          privateKey: privateKey,
          gas: "300000000000000",
          method: "sign",
          args: {
            "payload": payload,
            "path": path,
            "key_version": 0,
          },
          transferAmount: '0',
        ),
      );

      if (nearSignRequest.data["error"] != null) {
        throw Exception(nearSignRequest.data["error"]);
      }

      final signatureValList =
          List<String>.from(jsonDecode(nearSignRequest.data["success"]));

      final signatureData = {
        "big_r": signatureValList[0],
        "big_s": signatureValList[1],
      };

      signatures.add(signatureData);
    }

    //Sign transaction
    final signedTransactionEncoded = await jsVMService.callJS(
        "window.BitcoinUtils.signTransactionWithMPCSignature('${unsignedTransaction['psbt']}', '${jsonEncode(signatures)}', '$mpcSenderPublicKey')");

    final signedTransaction = jsonDecode(signedTransactionEncoded) as String;

    return signedTransaction;
  }

  Future<String> signXRPTransactionWithMPC({
    required String accountId,
    required String publicKey,
    required String privateKey,
    required MpcTransactionInfo mpcTransactionInfo,
    String path = "flutterchain",
    String mpcContract = 'v2.multichain-mpc.testnet',
  }) async {
    final unsignedTransaction = mpcTransactionInfo.transactionInfo;
    final payload = Uint8List.fromList(
        List<int>.from(unsignedTransaction["payload"].values));
    final reversedPayload = payload.reversed.toList();

    final nearSignRequest = await callSmartContractFunction(
      NearBlockChainSmartContractArguments(
        accountId: accountId,
        publicKey: publicKey,
        toAddress: mpcContract,
        privateKey: privateKey,
        gas: "300000000000000",
        method: "sign",
        args: {
          "payload": reversedPayload,
          "path": path,
          "key_version": 0,
        },
        transferAmount: '0',
      ),
    );

    if (nearSignRequest.data["error"] != null) {
      throw Exception(nearSignRequest.data["error"]);
    }

    final signatureValList =
        List<String>.from(jsonDecode(nearSignRequest.data["success"]));

    final signatureData = jsonEncode({
      "big_r": signatureValList[0],
      "big_s": signatureValList[1],
    });

    final signedTransaction = await jsVMService.callJS(
      "window.XRPUtils.signTransactionWithMPCSignature( '${jsonEncode(unsignedTransaction['unsignedTx'])}', '$signatureData')",
    );
    return signedTransaction;
  }

  Future<bool> deployNFTCollection({
    required String accountId,
    required String publicKey,
    required String privateKey,
    required String symbol,
    required String name,
    required String ownerId,
    String? spec = "nft-1.0.0",
    String? icon =
        "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAEXUlEQVRYR8VXW4hVVRj+vrX3OYbFNBl2eSsoa8pkxMJmzpGGoIwMY0wwImuCXmKKkiikKayHQIpAwbdAswskBYqJSlANek7TUOPURGKCWdmFkJnsoZnhzNn/F2vcZ9gez2UfEVoP+2Gv///Xt771X4mUq6enpz2Kogck3S2pk+R1ki736iT/kfQzyW/N7PNsNrtvcHDwTBrTbCbU1dV1cxiGGyWtA3BJM/l4f1rSLjPbPDQ0dKyRTl0AS5YsubStre11AP0AwiYHi+SJmJGFCdmypG3T09MDIyMjk7Vs1ASQy+VuIrkbQEezG3vqJfXGTzHhnFtlZttIuoTuUQC9hULheLW98wDkcrnbARwkeWWzw+P9ewCsB/AYgBkz6yW5lmRfUl/SOMmVhUJhJPn/HAD+5gCKLRzubS0AMO59MTa828z2Oud2VF8gBtGdZGIOQPzmX6ehPWk4iqKOIAg+BnCr/y/pJUmnnHPv1WHw6NTU1B0Vn5gDkM/ntwB4NiXtc2KS9kdR1B+G4aMA/pD0kaQHGwDwILcUi8UNs37jPz7UgiD4PoW318Qn6QSA/STbJc2T9EkjAAB8dCwuFos/zgLI5/M7YydqlYBa8vvMbFcTAJ6FncVisY/5fP4KT10LSaYZyFQAAEyHYXitB+BD6N1mVlvYTwsAZraeuVxuR3XMNjpM0mFJW0n+VUfub0mnSS6S5JxznQBeBpDMkBXV7R7AKEkv1HRJGiLpvX0rgHYzGyB5S5yuZ/VJHioUCv25XO4Vn/0AHDCzD51z35DMViWnUf8EEwC8H6RZj5O8Py5M3pF+D4JghZn9lFDeB+AtAF9U/vmw9CBJ3lt1yIQHYIks1gzEapJPSlodJ53xcrncmclkTiUOOwRgM8n9iX8Pk/S+tqqKAWsZgJmddM6971kzs+f9W5P0VbOyZmZmZjyo5yStcc4djKJoE8kxkvNrAWjlCVZLugHAYefcpJmtIzkAIKii7ldJL5jZkTAMF0t6A8CNNeidaMkJAXjqNwLobvZWafYljbYahhcVAIDtrSaiiwpgNhGlSMVjAI5J8m3Xm3FILapD8UKSd9XwiVriZ1Ox36lXjCRtMLPPwjC8s1QqHRgeHv6tu7v7IefcNYkQG8tkMqPlcnmNrylm9q9z7lMAlzXyg7li5IXqlOOvADwN4EsAPoOdLpVKHdlsdm/SCUku8/UdwIo4NzxF8noALzYAcG45jlmobkjelnTc014xRPI+Sa8BWJ4w7lsyH8qVtUfSHpLv1ANwXkPiBWu0ZEeiKOoLgsAzMd+nXTNb7pz7geTsQBLfuIvkqwBWnu3I9ASAZSSfqQOgdkvmhaubUpKboij6IAiCpSSH/aAB4JEqw9+VSqXeTCZzm6Q/nXNXA/A94rxqAA2b0opwjbb8JADfzy8FcFWdW01K8kwtqFdZU7XlCRCpB5M0GQ9A+sGkYrDF0awejgsbzZLW/rfhtPpKTcbzM5J+uZDx/D8+0FUx/4DhyAAAAABJRU5ErkJggg==",
    String? baseUri = "https://arweave.net",
    String? reference,
    String? referenceHash,
    String? factoryContract,
  }) async {
    if (nearRpcClient.networkClient.dio.options.baseUrl ==
        NearBlockChainNetworkUrls.listOfUrls.first) {
      factoryContract ??= "mintspace2.testnet";
    } else {
      factoryContract ??= "mintbase1.near";
    }

    icon = (icon != null && icon.isNotEmpty)
        ? icon
        : "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAEXUlEQVRYR8VXW4hVVRj+vrX3OYbFNBl2eSsoa8pkxMJmzpGGoIwMY0wwImuCXmKKkiikKayHQIpAwbdAswskBYqJSlANek7TUOPURGKCWdmFkJnsoZnhzNn/F2vcZ9gez2UfEVoP+2Gv///Xt771X4mUq6enpz2Kogck3S2pk+R1ki736iT/kfQzyW/N7PNsNrtvcHDwTBrTbCbU1dV1cxiGGyWtA3BJM/l4f1rSLjPbPDQ0dKyRTl0AS5YsubStre11AP0AwiYHi+SJmJGFCdmypG3T09MDIyMjk7Vs1ASQy+VuIrkbQEezG3vqJfXGTzHhnFtlZttIuoTuUQC9hULheLW98wDkcrnbARwkeWWzw+P9ewCsB/AYgBkz6yW5lmRfUl/SOMmVhUJhJPn/HAD+5gCKLRzubS0AMO59MTa828z2Oud2VF8gBtGdZGIOQPzmX6ehPWk4iqKOIAg+BnCr/y/pJUmnnHPv1WHw6NTU1B0Vn5gDkM/ntwB4NiXtc2KS9kdR1B+G4aMA/pD0kaQHGwDwILcUi8UNs37jPz7UgiD4PoW318Qn6QSA/STbJc2T9EkjAAB8dCwuFos/zgLI5/M7YydqlYBa8vvMbFcTAJ6FncVisY/5fP4KT10LSaYZyFQAAEyHYXitB+BD6N1mVlvYTwsAZraeuVxuR3XMNjpM0mFJW0n+VUfub0mnSS6S5JxznQBeBpDMkBXV7R7AKEkv1HRJGiLpvX0rgHYzGyB5S5yuZ/VJHioUCv25XO4Vn/0AHDCzD51z35DMViWnUf8EEwC8H6RZj5O8Py5M3pF+D4JghZn9lFDeB+AtAF9U/vmw9CBJ3lt1yIQHYIks1gzEapJPSlodJ53xcrncmclkTiUOOwRgM8n9iX8Pk/S+tqqKAWsZgJmddM6971kzs+f9W5P0VbOyZmZmZjyo5yStcc4djKJoE8kxkvNrAWjlCVZLugHAYefcpJmtIzkAIKii7ldJL5jZkTAMF0t6A8CNNeidaMkJAXjqNwLobvZWafYljbYahhcVAIDtrSaiiwpgNhGlSMVjAI5J8m3Xm3FILapD8UKSd9XwiVriZ1Ox36lXjCRtMLPPwjC8s1QqHRgeHv6tu7v7IefcNYkQG8tkMqPlcnmNrylm9q9z7lMAlzXyg7li5IXqlOOvADwN4EsAPoOdLpVKHdlsdm/SCUku8/UdwIo4NzxF8noALzYAcG45jlmobkjelnTc014xRPI+Sa8BWJ4w7lsyH8qVtUfSHpLv1ANwXkPiBWu0ZEeiKOoLgsAzMd+nXTNb7pz7geTsQBLfuIvkqwBWnu3I9ASAZSSfqQOgdkvmhaubUpKboij6IAiCpSSH/aAB4JEqw9+VSqXeTCZzm6Q/nXNXA/A94rxqAA2b0opwjbb8JADfzy8FcFWdW01K8kwtqFdZU7XlCRCpB5M0GQ9A+sGkYrDF0awejgsbzZLW/rfhtPpKTcbzM5J+uZDx/D8+0FUx/4DhyAAAAABJRU5ErkJggg==";

    baseUri = (baseUri != null && baseUri.isNotEmpty)
        ? baseUri
        : "https://arweave.net";

    final Map<String, dynamic> args = {
      "owner_id": ownerId,
      "metadata": {
        "name": name.toLowerCase(),
        "spec": spec,
        "symbol": symbol,
        "icon": icon,
        "baseUri": baseUri,
        "reference": reference,
        "referenceHash": referenceHash
      }
    };
    final nearSignRequest = await callSmartContractFunction(
      NearBlockChainSmartContractArguments(
        accountId: accountId,
        publicKey: publicKey,
        toAddress: factoryContract,
        privateKey: privateKey,
        gas: "300000000000000",
        method: "create_store",
        args: args,
        transferAmount: '3700000000000000000000000',
      ),
    );

    if (nearSignRequest.data["error"] != null) {
      throw Exception(nearSignRequest.data["error"]);
    }

    if (nearSignRequest.data["success"] == null) {
      throw Exception("Operation invalid, try again");
    }

    return true;
  }

  Future<List<dynamic>> checkOwnerCollection({required String owner_id}) async {
    final query = """query MyQuery {
                      nft_contracts(where: {owner_id: {_eq: "$owner_id"}}) {
                        id
                      }
                    }""";

    final response = await nearRpcClient.mintBaseRPCInteractions(query: query);

    List<dynamic> contracts = response.data["data"]["nft_contracts"];
    if (contracts.isEmpty) {
      final names = [];
      return names;
    }

    List<String> names =
        contracts.map((contacts) => contacts["id"] as String).toList();

    return names;
  }

  Future<List<dynamic>> checkMinterCollection(
      {required String owner_id}) async {
    final query = """query MyQuery {
                      mb_store_minters(where: {minter_id: {_eq: "$owner_id"}}) {
                        nft_contract_id
                      }
                    }""";

    final response = await nearRpcClient.mintBaseRPCInteractions(query: query);

    List<dynamic> contracts = response.data["data"]["mb_store_minters"];
    if (contracts.isEmpty) {
      final names = [];
      return names;
    }

    List<String> names = contracts
        .map((contacts) => contacts["nft_contract_id"] as String)
        .toList();

    return names;
  }

  Future<List<dynamic>> checkNFTInfo({required String owner_id}) async {
    final query = """query MyQuery {
                      mb_views_nft_tokens(where: {owner: {_eq: "$owner_id"}}) {
                        title
                        token_id
                        nft_contract_id
                        burned_timestamp
                      }
                    }""";

    final response = await nearRpcClient.mintBaseRPCInteractions(query: query);

    List<dynamic> contracts = response.data["data"]["mb_views_nft_tokens"];
    if (contracts.isEmpty) {
      final contractsNull = [];
      return contractsNull;
    }

    return contracts;
  }

  Future<List<dynamic>> checkListingNFT({required String ownerId}) async {
    final query = """query MyQuery {
                      mb_views_active_listings(where: {listed_by: {_eq: "$ownerId"}}) {
                        title
                        token_id
                        nft_contract_id
                      }
                    }""";

    final response = await nearRpcClient.mintBaseRPCInteractions(query: query);

    List<dynamic> contracts = response.data["data"]["mb_views_active_listings"];
    if (contracts.isEmpty) {
      final contractsNull = [];
      return contractsNull;
    }

    return contracts;
  }

  Future<Map<String, String>> checkMaxPriceBidNFT(
      {required String nftContractId, required int tokenId}) async {
    String resPriceBid;

    final query = """query MyQuery {
                      nft_offers_aggregate(
                        where: {nft_contract_id: {_eq: "$nftContractId"}, token_id: {_eq: "$tokenId"}}
                      ) {
                        aggregate {
                          max {
                            offer_price
                          }
                        }
                      }
                    }""";

    final response = await nearRpcClient.mintBaseRPCInteractions(query: query);

    Map<String, dynamic> pricesResponse =
        response.data["data"]["nft_offers_aggregate"];
    if (pricesResponse["aggregate"]["max"]["offer_price"] != null) {
      resPriceBid = Decimal.parse(
              pricesResponse["aggregate"]["max"]["offer_price"].toString())
          .toString();
    } else {
      resPriceBid = "There have been no interactions with this offerer yet.";
    }
    final priceBid = await getPriceForBuySimpleListNFT(
        nftContractId: nftContractId, tokenId: tokenId);

    Map<String, String> responseBid = {
      "maxbid": resPriceBid,
      "minbid": priceBid.toString()
    };

    return responseBid;
  }

  Future<dynamic> transferNFTCollection({
    required String accountId,
    required String publicKey,
    required String privateKey,
    required String nftCollectionContract,
    required String new_owner,
    required bool keep_old_minters,
  }) async {
    final Map<String, dynamic> args = {
      "new_owner": new_owner,
      "keep_old_minters": keep_old_minters
    };

    final nearSignRequest = await callSmartContractFunction(
      NearBlockChainSmartContractArguments(
        accountId: accountId,
        publicKey: publicKey,
        toAddress: nftCollectionContract,
        privateKey: privateKey,
        gas: "300000000000000",
        method: "transfer_store_ownership",
        args: args,
        transferAmount: '1',
      ),
    );

    if (nearSignRequest.data["error"] != null) {
      throw Exception(nearSignRequest.data["error"]);
    }

    if (nearSignRequest.data["success"] == null) {
      throw Exception("Operation invalid, try again");
    }

    return true;
  }

  Future<dynamic> addDeleteMinters({
    required String accountId,
    required String publicKey,
    required String privateKey,
    required String nftCollectionContract,
    required String name,
    required bool isAdd,
  }) async {
    late Map<String, dynamic> args;

    if (isAdd == true) {
      args = {
        "grant": [name]
      };
    } else {
      args = {
        "revoke": [name]
      };
    }

    final nearSignRequest = await callSmartContractFunction(
      NearBlockChainSmartContractArguments(
        accountId: accountId,
        publicKey: publicKey,
        toAddress: nftCollectionContract,
        privateKey: privateKey,
        gas: "300000000000000",
        method: "batch_change_minters",
        args: args,
        transferAmount: '1',
      ),
    );

    if (nearSignRequest.data["error"] != null) {
      throw Exception(nearSignRequest.data["error"]);
    } else if (nearSignRequest.data["success"] != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<dynamic>> getMinters({
    required String accountId,
    required String publicKey,
    required String privateKey,
    required String nftCollectionContract,
  }) async {
    final Map<String, dynamic> args = {};

    final nearSignRequest = await callSmartContractFunction(
      NearBlockChainSmartContractArguments(
        accountId: accountId,
        publicKey: publicKey,
        toAddress: nftCollectionContract,
        privateKey: privateKey,
        gas: "300000000000000",
        method: "list_minters",
        args: args,
        transferAmount: '1',
      ),
    );

    if (nearSignRequest.data["error"] != null) {
      throw Exception(nearSignRequest.data["error"]);
    }

    final names = nearSignRequest.data["success"] as String;

    return jsonDecode(names);
  }

  Future<bool> mintNFT({
    required String accountId,
    required String publicKey,
    required String privateKey,
    required String nftCollectionContract,
    required String owner_id,
    required String description,
    required String title,
    required String media,
    String? media_type,
    String? animation,
    int num_to_mint = 1,
    Map<String, int>? split_between,
    Map<String, int>? split_owners,
    List<String>? tags,
    List<dynamic>? extra,
    CategoryNFT? category,
    String? document,
    String? baseURL = "https://arweave.net/",
  }) async {
    int? splitBetweenSum;
    Map<String, dynamic>? royalty_args;
    String? animationUpload;
    String? documentUpload;
    String mediaUploadURL;
    Map<String, int>? finalSplitOwners;
    if (split_owners != null) {
      int sum = split_owners.values.reduce((a, b) => a + b);
      if (sum * 100 > 10000) {
        throw Exception("To mach percentage, limit exhausted");
      }
      finalSplitOwners = split_owners.map((key, value) {
        return MapEntry(key, value * 100);
      });
    }

    if (split_between != null) {
      splitBetweenSum = split_between.values.reduce((a, b) => a + b);
      if (splitBetweenSum * 100 > 5000) {
        throw Exception("To mach percentage, limit exhausted");
      }

      final splitBetweenUpdate = calculateRoyalty(
          noCompletelyRoyalty: split_between, totalSum: splitBetweenSum * 100);
      royalty_args = {
        "split_between": splitBetweenUpdate,
        "percentage": splitBetweenSum * 100
      };
    }
    final mediaFile = File(media);
    if (!mediaFile.existsSync()) {
      throw Exception("Media file does not exist");
    }
    String mediaUpload = await uploadFileToArweave(file: mediaFile);
    mediaUploadURL = baseURL! + mediaUpload;

    if (animation != null && animation.length > 0) {
      final animationFile = File(animation);
      animationUpload = await uploadFileToArweave(file: animationFile);
      animationUpload = baseURL + animationUpload;
    }

    if (document != null && document.length > 0) {
      final documentFile = File(document);
      documentUpload = await uploadFileToArweave(file: documentFile);
      documentUpload = baseURL + documentUpload;
    }

    final reference = {
      "title": title,
      "description": description,
      "media": mediaUploadURL,
      "media_type": media_type,
      "animation_url": animationUpload,
      "document": documentUpload,
      "tags": tags,
      "extra": extra,
      "store": nftCollectionContract,
      "type": "NEP171",
      "category": category?.name
    };

    final referenceUpload =
        await uploadReferenceToArweave(reference: reference);

    Map<String, dynamic> metadata = {
      "reference": referenceUpload["id"],
      "media": referenceUpload["media_hash"],
      "title": title,
    };

    final Map<String, dynamic> args = {
      "owner_id": owner_id,
      "metadata": metadata,
      "num_to_mint": num_to_mint,
      "royalty_args": royalty_args,
      "split_owners": finalSplitOwners,
    };

    final transferAmount = mintingDeposit(
        nSplits: finalSplitOwners?.length ?? 0,
        nTokens: num_to_mint,
        nRoyalties: split_between?.length ?? 0,
        metadata: metadata);

    final nearSignRequest = await callSmartContractFunction(
      NearBlockChainSmartContractArguments(
        accountId: accountId,
        publicKey: publicKey,
        toAddress: nftCollectionContract,
        privateKey: privateKey,
        gas: "300000000000000",
        method: "nft_batch_mint",
        args: args,
        transferAmount: transferAmount,
      ),
    );

    if (nearSignRequest.data["error"] != null) {
      throw Exception(nearSignRequest.data["error"]);
    }

    if (nearSignRequest.data["success"] == null) {
      throw Exception("Operation invalid, try again");
    }

    return true;
  }

  String mintingDeposit({
    required int nSplits,
    required int nTokens,
    required int nRoyalties,
    required Map<String, dynamic> metadata,
  }) {
    const int STORAGE_BYTES_TOKEN_BASE = 440;
    const int STORAGE_BYTES_COMMON = 80;
    const int STORAGE_BYTES_MINTING_BASE = 92;
    const int STORAGE_BYTES_MINTING_FEE = 100;
    const int STORAGE_PRICE_PER_BYTE_EXPONENT = 19;
    int nSplitsAdj = nSplits < 1 ? 0 : nSplits - 1;
    int bytesPerToken = STORAGE_BYTES_TOKEN_BASE +
        nSplitsAdj * STORAGE_BYTES_COMMON +
        STORAGE_BYTES_COMMON;
    int metadataBytesEstimate = jsonEncode(metadata).length;

    int totalBytes = STORAGE_BYTES_MINTING_BASE +
        STORAGE_BYTES_MINTING_FEE +
        metadataBytesEstimate +
        bytesPerToken * nTokens +
        STORAGE_BYTES_COMMON * nRoyalties;

    return "${(totalBytes).ceil()}${'0' * STORAGE_PRICE_PER_BYTE_EXPONENT}";
  }

  Future<String> uploadFileToArweave({required File file}) async {
    final response = await nearRpcClient.uploadFileToArweave(file: file);
    if (response.status == "error") {
      throw Exception("${response.data}");
    }
    return response.data["id"];
  }

  Future<Map<String, dynamic>> uploadReferenceToArweave(
      {required Map<String, dynamic> reference}) async {
    final response =
        await nearRpcClient.uploadReferenceToArweave(reference: reference);
    if (response.status == "error") {
      throw Exception("${response.data}");
    }
    return response.data;
  }

  Map<String, int> calculateRoyalty(
      {required Map<String, int> noCompletelyRoyalty, required int totalSum}) {
    final updatedRoyalty = {
      for (var entry in noCompletelyRoyalty.entries)
        entry.key: (((entry.value * 100) / totalSum) * 10000).round()
    };
    return updatedRoyalty;
  }

  Future<bool> transferNFT(
      {required String accountId,
      required String publicKey,
      required String privateKey,
      required String nftCollectionContract,
      required List<List<String>> tokenIds}) async {
    final Map<String, dynamic> args = {"token_ids": tokenIds};

    for (var i = 0; i < tokenIds.length; i++) {
      final havePermission = await NFTInteractionPermission(
          nameNFTCollection: nftCollectionContract,
          tokenId: tokenIds[i][0],
          ownerId: accountId);
      if (havePermission.data["data"]["mb_views_nft_tokens"].length == 0) {
        throw Exception(
            "You don`t have permission or your data incorrect, try again");
      }
    }

    final nearSignRequest = await callSmartContractFunction(
      NearBlockChainSmartContractArguments(
        accountId: accountId,
        publicKey: publicKey,
        toAddress: nftCollectionContract,
        privateKey: privateKey,
        gas: "300000000000000",
        method: "nft_batch_transfer",
        args: args,
        transferAmount: '1',
      ),
    );

    if (nearSignRequest.data["error"] != null) {
      throw Exception(nearSignRequest.data["error"]);
    }

    if (nearSignRequest.data["success"] == null) {
      throw Exception("Operation invalid, try again");
    }

    return true;
  }

  Future<BlockchainResponse> NFTInteractionPermission(
      {required String nameNFTCollection,
      required String tokenId,
      required String ownerId}) async {
    final query = """query MyQuery {
                      mb_views_nft_tokens(
                        where: {nft_contract_id: {_eq: "$nameNFTCollection"}, burned_timestamp: {_is_null: true}, token_id: {_eq: "$tokenId"}, owner: {_eq: "$ownerId"}}
                        distinct_on: title
                      ) {
                        title
                        token_id
                      }
                    }""";
    return await nearRpcClient.mintBaseRPCInteractions(query: query);
  }

  Future<bool> multiplyNFT({
    required String nameNFTCollection,
    required String nameNFT,
    required String accountId,
    required String publicKey,
    required String privateKey,
    required int numToMint,
    String? media,
    String? reference,
  }) async {
    Map<String, dynamic>? royalty_args;

    final data = await getInfoForMultiply(
        nameNFTCollection: nameNFTCollection,
        ownerId: accountId,
        nameNFT: nameNFT);

    if (data.data["data"]["mb_views_nft_tokens"].first.length == 0) {
      throw Exception("Operation failed, check info and try again");
    }

    Map<String, dynamic> nftInfo =
        data.data["data"]["mb_views_nft_tokens"].first;

    media ??= nftInfo["media"].replaceFirst("https://arweave.net/", "");
    reference ??= nftInfo["reference"];

    if (nftInfo["royalties"] != null) {
      royalty_args = {
        "split_between": nftInfo["royalties"],
        "percentage": nftInfo["royalties_percent"],
      };
    }

    Map<String, dynamic> metadata = {
      "reference": nftInfo["reference"],
      "media": media,
      "title": nftInfo["title"],
    };

    final Map<String, dynamic> args = {
      "owner_id": accountId,
      "metadata": metadata,
      "num_to_mint": numToMint,
      "royalty_args": royalty_args,
      "split_owners": nftInfo["splits"],
    };

    final transferAmount = mintingDeposit(
        nSplits: nftInfo["splits"]?.length ?? 0,
        nTokens: numToMint,
        nRoyalties: nftInfo["royalties"]?.length ?? 0,
        metadata: metadata);

    final nearSignRequest = await callSmartContractFunction(
      NearBlockChainSmartContractArguments(
        accountId: accountId,
        publicKey: publicKey,
        toAddress: nameNFTCollection,
        privateKey: privateKey,
        gas: "300000000000000",
        method: "nft_batch_mint",
        args: args,
        transferAmount: transferAmount,
      ),
    );
    if (nearSignRequest.data["error"] != null) {
      throw Exception(nearSignRequest.data["error"]);
    }

    if (nearSignRequest.data["success"] == null) {
      throw Exception("Operation invalid, try again");
    }

    return true;
  }

  Future<BlockchainResponse> getInfoForMultiply(
      {required String nameNFTCollection,
      required String ownerId,
      required String nameNFT}) async {
    final query = """query MyQuery {
                            mb_views_nft_tokens(
                              where: {nft_contract_id: {_eq: "$nameNFTCollection"}, title: {_eq: "$nameNFT"}, burned_timestamp: {_is_null: true}, owner: {_eq: "$ownerId"}}
                              distinct_on: title
                            ) {
                              splits
                              title
                              royalties_percent
                              reference
                              nft_contract_name
                              media
                              royalties
                            }
                          }""";
    return await nearRpcClient.mintBaseRPCInteractions(query: query);
  }

  Future<bool> simpleListNFT({
    required String nameNFTCollection,
    required String tokenId,
    required String price,
    required String accountId,
    required String publicKey,
    required String privateKey,
    String? market_account_id,
  }) async {
    if (nearRpcClient.networkClient.dio.options.baseUrl ==
        NearBlockChainNetworkUrls.listOfUrls.first) {
      market_account_id ??=
          NearBlockChainNetworkUrls.listOfMarketAccountId.first;
    } else {
      market_account_id ??=
          NearBlockChainNetworkUrls.listOfMarketAccountId.last;
    }

    Decimal iputPrice = Decimal.parse(price);

    Decimal constValue = Decimal.parse('1000000000000000000000000');

    Decimal resultPrice = iputPrice * constValue;

    final msg = """{\\"price\\":\\"${resultPrice.toString()}\\"}""";

    final Map<String, dynamic> args = {
      "token_id": tokenId,
      "account_id": market_account_id,
      "msg": msg,
    };

    final nearSignRequest = await callSmartContractFunction(
      NearBlockChainSmartContractArguments(
        accountId: accountId,
        publicKey: publicKey,
        toAddress: nameNFTCollection,
        privateKey: privateKey,
        gas: "300000000000000",
        method: "nft_approve",
        args: args,
        transferAmount: "1000000000000000000000",
      ),
    );

    if (nearSignRequest.data["error"] != null) {
      throw Exception(nearSignRequest.data["error"]);
    }

    if (nearSignRequest.data["success"] == null) {
      throw Exception("Operation invalid, try again");
    }

    return true;
  }

  Future<bool> listingActivate({
    required String accountId,
    required String publicKey,
    required String privateKey,
    String? market_account_id,
  }) async {
    if (nearRpcClient.networkClient.dio.options.baseUrl ==
        NearBlockChainNetworkUrls.listOfUrls.first) {
      market_account_id ??=
          NearBlockChainNetworkUrls.listOfMarketAccountId.first;
    } else {
      market_account_id ??=
          NearBlockChainNetworkUrls.listOfMarketAccountId.last;
    }

    final Map<String, dynamic> args = {"autotransfer": true};

    final nearSignRequest = await callSmartContractFunction(
      NearBlockChainSmartContractArguments(
        accountId: accountId,
        publicKey: publicKey,
        toAddress: market_account_id,
        privateKey: privateKey,
        gas: "300000000000000",
        method: "deposit_storage",
        args: args,
        transferAmount: "10000000000000000000000",
      ),
    );

    if (nearSignRequest.data["error"] != null) {
      throw Exception(nearSignRequest.data["error"]);
    }

    if (nearSignRequest.data["success"] == null) {
      throw Exception("Operation invalid, try again");
    }

    return true;
  }

  Future<bool> unlistNFT(
      {required String accountId,
      required String publicKey,
      required String nameNFTCollection,
      required String privateKey,
      required int tokenId,
      String? market_account_id}) async {
    final Map<String, dynamic> args = {
      "token_ids": ["$tokenId"],
      "nft_contract_id": nameNFTCollection
    };

    if (nearRpcClient.networkClient.dio.options.baseUrl ==
        NearBlockChainNetworkUrls.listOfUrls.first) {
      market_account_id ??=
          NearBlockChainNetworkUrls.listOfMarketAccountId.first;
    } else {
      market_account_id ??=
          NearBlockChainNetworkUrls.listOfMarketAccountId.last;
    }

    final nearSignRequest = await callSmartContractFunction(
      NearBlockChainSmartContractArguments(
        accountId: accountId,
        publicKey: publicKey,
        toAddress: market_account_id,
        privateKey: privateKey,
        gas: "300000000000000",
        method: "unlist",
        args: args,
        transferAmount: "1",
      ),
    );

    if (nearSignRequest.data["error"] != null) {
      throw Exception(nearSignRequest.data["error"]);
    }

    if (nearSignRequest.data["success"] == null) {
      throw Exception("Operation invalid, try again");
    }

    return true;
  }

  Future<bool> delistNFT(
      {required String accountId,
      required String publicKey,
      required String nameNFTCollection,
      required String privateKey,
      required int tokenId,
      String? market_account_id}) async {
    final Map<String, dynamic> args = {
      "token_ids": ["$tokenId"],
      "nft_contract_id": nameNFTCollection,
    };

    if (nearRpcClient.networkClient.dio.options.baseUrl ==
        NearBlockChainNetworkUrls.listOfUrls.first) {
      market_account_id ??=
          NearBlockChainNetworkUrls.listOfMarketAccountId.first;
    } else {
      market_account_id ??=
          NearBlockChainNetworkUrls.listOfMarketAccountId.last;
    }

    final nearSignRequest = await callSmartContractFunction(
      NearBlockChainSmartContractArguments(
        accountId: accountId,
        publicKey: publicKey,
        toAddress: market_account_id,
        privateKey: privateKey,
        gas: "300000000000000",
        method: "delist",
        args: args,
        transferAmount: "1",
      ),
    );

    if (nearSignRequest.data["error"] != null) {
      throw Exception(nearSignRequest.data["error"]);
    }

    if (nearSignRequest.data["success"] == null) {
      throw Exception("Operation invalid, try again");
    }

    return true;
  }

  Future<bool> buySimpleListNFT({
    required String accountId,
    required String publicKey,
    required String nameNFTCollection,
    required String privateKey,
    required int tokenId,
    String? referrer_id,
    String? market_account_id,
  }) async {
    final price = await getPriceForBuySimpleListNFT(
        nftContractId: nameNFTCollection, tokenId: tokenId);

    if (nearRpcClient.networkClient.dio.options.baseUrl ==
        NearBlockChainNetworkUrls.listOfUrls.first) {
      market_account_id ??=
          NearBlockChainNetworkUrls.listOfMarketAccountId.first;
    } else {
      market_account_id ??=
          NearBlockChainNetworkUrls.listOfMarketAccountId.last;
    }

    final Map<String, dynamic> args = {
      "nft_contract_id": nameNFTCollection,
      "token_id": "$tokenId",
      "referrer_id": referrer_id?.length == 0 ? null : referrer_id,
    };

    Decimal formatPrice = Decimal.parse(price);

    final nearSignRequest = await callSmartContractFunction(
      NearBlockChainSmartContractArguments(
        accountId: accountId,
        publicKey: publicKey,
        toAddress: market_account_id,
        privateKey: privateKey,
        gas: "300000000000000",
        method: "buy",
        args: args,
        transferAmount: formatPrice.toString(),
      ),
    );

    if (nearSignRequest.data["error"] != null) {
      throw Exception(nearSignRequest.data["error"]);
    }

    if (nearSignRequest.data["success"] == null) {
      throw Exception("Operation invalid, try again");
    }

    return true;
  }

  Future<String> getPriceForBuySimpleListNFT(
      {required String nftContractId, required int tokenId}) async {
    final query = """query MyQuery {
                      mb_views_active_listings(
                        where: {nft_contract_id: {_eq: "$nftContractId"}, token_id: {_eq: "$tokenId"}}
                      ) {
                        price
                      }
                    }""";

    final request = await nearRpcClient.mintBaseRPCInteractions(query: query);

    List<dynamic> requestInfo =
        request.data["data"]["mb_views_active_listings"];
    if (requestInfo.length == 0) {
      throw Exception("This NFT not in active listings");
    }

    Decimal price = Decimal.parse(requestInfo.first["price"].toString());

    return price.toString();
  }

  Future<bool> rollingAuctionNft(
      {required String accountId,
      required String publicKey,
      required String nameNFTCollection,
      required String privateKey,
      required int tokenId,
      required String price,
      String? market_account_id}) async {
    if (nearRpcClient.networkClient.dio.options.baseUrl ==
        NearBlockChainNetworkUrls.listOfUrls.first) {
      market_account_id ??= "market.mintspace2.testnet";
    } else {
      market_account_id ??= "market.mintbase1.near";
    }

    Decimal iputPrice = Decimal.parse(price);

    Decimal constValue = Decimal.parse('1000000000000000000000000');

    Decimal resultPrice = iputPrice * constValue;

    final Map<String, dynamic> args = {
      "token_id": "$tokenId",
      "account_id": market_account_id,
      "msg":
          """{\\"price\\":\\"${resultPrice.toString()}\\",\\"autotransfer\\":false}"""
    };

    final nearSignRequest = await callSmartContractFunction(
      NearBlockChainSmartContractArguments(
        accountId: accountId,
        publicKey: publicKey,
        toAddress: nameNFTCollection,
        privateKey: privateKey,
        gas: "300000000000000",
        method: "nft_approve",
        args: args,
        transferAmount: "1000000000000000000000",
      ),
    );

    if (nearSignRequest.data["error"] != null) {
      throw Exception(nearSignRequest.data["error"]);
    }

    if (nearSignRequest.data["success"] == null) {
      throw Exception("Operation invalid, try again");
    }

    return true;
  }

  Future<bool> offersToRollingAuction({
    required String accountId,
    required String publicKey,
    required String nameNFTCollection,
    required String privateKey,
    required int tokenId,
    required String priceBid,
    int? timeoutInHours,
    String? market_account_id,
  }) async {
    timeoutInHours ??= 24;

    if (nearRpcClient.networkClient.dio.options.baseUrl ==
        NearBlockChainNetworkUrls.listOfUrls.first) {
      market_account_id ??= "market.mintspace2.testnet";
    } else {
      market_account_id ??= "market.mintbase1.near";
    }

    Decimal iputPrice = Decimal.parse(priceBid);

    Decimal constValue = Decimal.parse('1000000000000000000000000');

    Decimal resultPrice = iputPrice * constValue;

    final Map<String, dynamic> args = {
      "token_key": ["$tokenId:$nameNFTCollection"],
      "price": [resultPrice.toString()],
      "timeout": [
        {"Hours": timeoutInHours}
      ]
    };

    final nearSignRequest = await callSmartContractFunction(
      NearBlockChainSmartContractArguments(
        accountId: accountId,
        publicKey: publicKey,
        toAddress: market_account_id,
        privateKey: privateKey,
        gas: "300000000000000",
        method: "make_offer",
        args: args,
        transferAmount: resultPrice.toString(),
      ),
    );

    if (nearSignRequest.data["error"] != null) {
      throw Exception(nearSignRequest.data["error"]);
    }

    if (nearSignRequest.data["success"] == null) {
      throw Exception("Operation invalid, try again");
    }

    return true;
  }
}
