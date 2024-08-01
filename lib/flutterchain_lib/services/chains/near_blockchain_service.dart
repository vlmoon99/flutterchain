import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/blockchains_gas.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/near_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/webview_constants.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_smart_contract_arguments.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_mpc_account_info.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_mpc_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain/flutterchain_lib/network/chains/near_rpc_client.dart';
import 'package:flutterchain/flutterchain_lib/services/core/blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/js_vm.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/js_engine_stub.dart'
    if (dart.library.io) 'package:flutterchain/flutterchain_lib/services/core/js_engines/platforms_implementations/webview_js_engine.dart'
    if (dart.library.js) 'package:flutterchain/flutterchain_lib/services/core/js_engines/platforms_implementations/web_js_engine.dart';

class NearBlockChainService implements BlockChainService {
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

  //Send Near tokens thought near blockchain
  @override
  Future<BlockchainResponse> sendTransferNativeCoin(
      TransferRequest transferRequest) async {
    NearTransferRequest nearTransferRequest =
        transferRequest as NearTransferRequest;
    final transactionInfo = await getTransactionInfo(
      accountId: nearTransferRequest.publicKey!,
      publicKey: nearTransferRequest.publicKey!,
    );
    final gas = BlockchainGas.gas[BlockChains.near];
    if (gas == null) {
      throw Exception('Incorrect Blockchain Gas');
    }
    final actions = [
      {
        "type": "transfer",
        "data": {"amount": nearTransferRequest.transferAmount}
      }
    ];

    final signedAction = await signNearActions(
      fromAddress: nearTransferRequest.publicKey!,
      toAddress: nearTransferRequest.toAddress!,
      transferAmount: nearTransferRequest.transferAmount!,
      privateKey: nearTransferRequest.privateKey!,
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
    TransferRequest transferRequest,
  ) async {
    NearTransferRequest nearTransferRequest =
        transferRequest as NearTransferRequest;
    if (nearTransferRequest.arguments
        is! NearBlockChainSmartContractArguments) {
      throw Exception('Incorrect Blockchain Smart Contract Arguments');
    }
    final transactionInfo = await getTransactionInfo(
      accountId: nearTransferRequest.fromAddress!,
      publicKey: nearTransferRequest.publicKey!,
    );
    final gas = transferRequest.gas ?? BlockchainGas.gas[BlockChains.near];
    if (gas == null) {
      throw Exception('Incorrect Blockchain Gas');
    }
    final arg =
        nearTransferRequest.arguments as NearBlockChainSmartContractArguments;
    if (arg == null) {
      throw Exception('Incorrect Blockchain Arg');
    }
    final List<Map<String, dynamic>> actions = [
      {
        "type": "functionCall",
        "data": {
          "methodName": arg.method,
          "args": arg.args,
        },
      },
    ];

    final signedAction = await signNearActions(
      fromAddress: transferRequest.fromAddress!,
      toAddress: transferRequest.toAddress!,
      transferAmount: arg.transferAmount,
      privateKey: transferRequest.privateKey!,
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
  Future<String> getWalletBalance(TransferRequest transferRequest) async {
    final nearTransferRequest = transferRequest as NearTransferRequest;
    final res =
        await nearRpcClient.getAccountBalance(nearTransferRequest.accountID!);
    return res;
  }

  //Setting new blockchain network environment on another url

  @override
  Future<void> setBlockchainNetworkEnvironment({required String newUrl}) async {
    nearRpcClient.networkClient.setUrl(newUrl);
  }

  //Getting official blockchain's urls
  @override
  Set<String> getBlockchainsUrlsByBlockchainType() {
    return NearBlockChainNetworkUrls.listOfUrls;
  }

  //Getting private , public key and other information from mnemonic passphrase, and derivation path
  @override
  Future<NearBlockChainData> getBlockChainDataByDerivationPath({
    required String mnemonic,
    required String? passphrase,
    required DerivationPath derivationPath,
  }) async {
    final res = await jsVMService.callJS(
        """window.NearBlockchain.getBlockChainDataFromMnemonic('$mnemonic','$passphrase', "${derivationPath.accountNumber}","${derivationPath.change}","${derivationPath.address}")""");
    final blockChainData = NearBlockChainData.fromJson(jsonDecode(res));
    return blockChainData;
  }

  //Getting private , public key and other information from mnemonic and passphrase
  //this method will give you first standard wallet generated from this mnemonic and passphrase
  @override
  Future<NearBlockChainData> getBlockChainDataFromMnemonic(
      String mnemonic, String passphrase) async {
    final res = await jsVMService.callJS(
        "window.NearBlockchain.getBlockChainDataFromMnemonic('$mnemonic','$passphrase')");
    final decodedRes = jsonDecode(res);
    final blockChainData = NearBlockChainData.fromJson(decodedRes);
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

    final decodedRes = jsonDecode(res);
    final signedTx = decodedRes['signedTransaction'].toString();
    return signedTx;
  }

  //This method will delete any type of key from your account

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
  Future<String> getBlockchainNetworkEnvironment() async {
    return nearRpcClient.networkClient.dio.options.baseUrl;
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
              url: WebUri(WebViewConstants.nearLoginThroughtWebView),
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
      adress: mpcAccountInfo["address"],
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
  /// - [senderAdress]: The address of the sender provided by the MPC.
  /// - [path]: The path used for the MPC signing.
  /// - [mpcContract]: The contract address of the MPC.
  ///
  /// Returns the signed transaction as a string.
  Future<String> signEVMTransationWithMPC({
    required String accountId,
    required String publicKey,
    required String privateKey,
    required MpcTransactionInfo mpcTransactionInfo,
    required String senderAdress,
    String path = "flutterchain",
    String mpcContract = 'v2.multichain-mpc.testnet',
  }) async {
    final unsignedTransaction = mpcTransactionInfo.transactionInfo;
    final payload = Uint8List.fromList(
        List<int>.from(unsignedTransaction["payload"].values));
    final reversedPayload = payload.reversed.toList();
    final nearSignRequest = await callSmartContractFunction(
      NearTransferRequest(
        fromAddress: accountId,
        publicKey: publicKey,
        toAddress: mpcContract,
        privateKey: privateKey,
        gas: "300000000000000",
        arguments: NearBlockChainSmartContractArguments(
          method: "sign",
          args: {
            "payload": reversedPayload,
            "path": path,
            "key_version": 0,
          },
          transferAmount: '0',
        ),
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
      "window.EVMUtils.signTransactionWithMPCSignature('$signatureData', '${jsonEncode(serializedUnsignedTransaction)}', '$senderAdress', '${unsignedTransaction["typeOfTransaction"]}', '${jsonEncode(unsignedTransaction['chainInfo'])}')",
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
        NearTransferRequest(
          fromAddress: accountId,
          publicKey: publicKey,
          toAddress: mpcContract,
          privateKey: privateKey,
          gas: "300000000000000",
          arguments: NearBlockChainSmartContractArguments(
            method: "sign",
            args: {
              "payload": payload,
              "path": path,
              "key_version": 0,
            },
            transferAmount: '0',
          ),
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
      NearTransferRequest(
        fromAddress: accountId,
        publicKey: publicKey,
        toAddress: mpcContract,
        privateKey: privateKey,
        gas: "300000000000000",
        arguments: NearBlockChainSmartContractArguments(
          method: "sign",
          args: {
            "payload": reversedPayload,
            "path": path,
            "key_version": 0,
          },
          transferAmount: '0',
        ),
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
    String? icon,
    String? baseUri,
    String? reference,
    String? referenceHash,
    String factoryContract = 'mintspace2.testnet',
  }) async {
    final Map<String, dynamic> args = {
      "owner_id": ownerId,
      "metadata": {
        "name": name,
        "spec": "nft-1.0.0",
        "symbol": symbol,
        "icon": icon,
        "baseUri": baseUri,
        "reference": reference,
        "referenceHash": referenceHash
      }
    };
    final nearSignRequest = await callSmartContractFunction(
      NearTransferRequest(
        fromAddress: accountId,
        publicKey: publicKey,
        toAddress: factoryContract,
        privateKey: privateKey,
        gas: "300000000000000",
        arguments: NearBlockChainSmartContractArguments(
          method: "create_store",
          args: args,
          transferAmount: '3700000000000000000000000',
        ),
      ),
    );

    if (nearSignRequest.data["error"] != null) {
      throw Exception(nearSignRequest.data["error"]);
    }

    return true;
  }

  Future<List<dynamic>> checkCollection(
      {required String owner_id, required bool testnet}) async {
    final response =
        await nearRpcClient.getCollection(owner_id: owner_id, testnet: testnet);

    List<dynamic> contracts = response.data["data"]["nft_contracts"];
    if (contracts.isEmpty) {
      final names = [];
      return names;
    }

    List<String> names =
        contracts.map((contacts) => contacts["name"] as String).toList();

    return names;
  }

  Future<List<dynamic>> checkNFTInfo(
      {required String owner_id, required bool testnet}) async {
    final response =
        await nearRpcClient.getNFTInfo(owner_id: owner_id, testnet: testnet);

    List<dynamic> contracts =
        response.data["data"]["mb_views_nft_owned_tokens"];
    if (contracts.isEmpty) {
      final contractsNull = [];
      return contractsNull;
    }

    return contracts;
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
      NearTransferRequest(
        fromAddress: accountId,
        publicKey: publicKey,
        toAddress: nftCollectionContract,
        privateKey: privateKey,
        gas: "300000000000000",
        arguments: NearBlockChainSmartContractArguments(
          method: "transfer_store_ownership",
          args: args,
          transferAmount: '1',
        ),
      ),
    );

    if (nearSignRequest.data["error"] != null) {
      throw Exception(nearSignRequest.data["error"]);
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
      NearTransferRequest(
        fromAddress: accountId,
        publicKey: publicKey,
        toAddress: nftCollectionContract,
        privateKey: privateKey,
        gas: "300000000000000",
        arguments: NearBlockChainSmartContractArguments(
          method: "batch_change_minters",
          args: args,
          transferAmount: '1',
        ),
      ),
    );

    if (nearSignRequest.data["error"] != null) {
      throw Exception(nearSignRequest.data["error"]);
    }

    return true;
  }

  Future<List<dynamic>> getMinters({
    required String accountId,
    required String publicKey,
    required String privateKey,
    required String nftCollectionContract,
  }) async {
    final Map<String, dynamic> args = {};

    final nearSignRequest = await callSmartContractFunction(
      NearTransferRequest(
        fromAddress: accountId,
        publicKey: publicKey,
        toAddress: nftCollectionContract,
        privateKey: privateKey,
        gas: "300000000000000",
        arguments: NearBlockChainSmartContractArguments(
          method: "list_minters",
          args: args,
          transferAmount: '1',
        ),
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
    required String? media,
    int num_to_mint = 1,
    Map<String, int>? split_between,
    Map<String, int>? split_owners,
    List<String>? tags,
    List<dynamic>? extra,
    String? category,
    String? document,
  }) async {
    int? splitBetweenSum;
    Map<String, dynamic>? royalty_args;
    if (split_owners != null) {
      int sum = split_owners.values.reduce((a, b) => a + b);
      if (sum * 100 > 10000) {
        throw Exception("To mach percentage, limit exhausted");
      }
      split_owners.values.map((value) => value * 100);
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
    final referenceJSON = jsonEncode({
      "title": title,
      "description": description,
      "tags": tags,
      "media": media,
      "document": document,
      "extra": extra,
      "type": "NEP171",
      "category": category
    });

    final Map<String, dynamic> args = {
      "owner_id": owner_id,
      "metadata": {
        "title": title,
        "description": description,
        "copies": num_to_mint,
        "media": "data:image/png;base64," + media!,
        "reference":
            "https://arweave.net/wL2t0_F4eAGtsXTKeb9SpR7sxn9JDZuidSWzvXUe6Ks",
      },
      "num_to_mint": num_to_mint,
      "royalty_args": royalty_args,
      "split_owners": split_owners,
    };

    final nearSignRequest = await callSmartContractFunction(
      NearTransferRequest(
        fromAddress: accountId,
        publicKey: publicKey,
        toAddress: nftCollectionContract,
        privateKey: privateKey,
        gas: "300000000000000",
        arguments: NearBlockChainSmartContractArguments(
          method: "nft_batch_mint",
          args: args,
          transferAmount: '1',
        ),
      ),
    );

    if (nearSignRequest.data["error"] != null) {
      throw Exception(nearSignRequest.data["error"]);
    }

    return true;
  }

  Map<String, int> calculateRoyalty(
      {required Map<String, int> noCompletelyRoyalty, required int totalSum}) {
    final updatedRoyalty = {
      for (var entry in noCompletelyRoyalty.entries)
        entry.key: (((entry.value * 100) / totalSum) * 10000).round()
    };
    return updatedRoyalty;
  }
}
