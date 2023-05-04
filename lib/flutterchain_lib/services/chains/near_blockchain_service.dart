import 'dart:convert';

import 'package:flutterchain/flutterchain_lib/constants/core/blockchains_gas.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/blockchains_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_smart_contract_arguments.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_specific_arguments_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_smart_contract_arguments.dart';
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
    String toAdress,
    String fromAddress,
    String transferAmount,
    String privateKey,
    String publicKey,
  ) async {
    final transactionInfo = await getNonceAndBlockHashInfo(
      accountId: fromAddress,
      publicKey: publicKey,
    );
    final gas = BlockchainGas.gas[BlockChains.near];
    if (gas == null) {
      throw Exception('Incorrect Blockchain Gas');
    }
    final actions = [
      {
        "type": "transfer",
        "data": {"amount": transferAmount}
      }
    ];
    final blockChainSpecificArgumentsData = NearBlockChainSpecificArgumentsData(
      actions: actions,
      blockHash: transactionInfo.blockHash,
      gas: gas,
      nonce: transactionInfo.nonce,
      privateKey: privateKey,
    );

    final signedAction = await signNearActions(
      fromAddress: fromAddress,
      toAddress: toAdress,
      transferAmount: transferAmount,
      privateKey: blockChainSpecificArgumentsData.privateKey,
      gas: blockChainSpecificArgumentsData.gas,
      nonce: blockChainSpecificArgumentsData.nonce,
      blockHash: blockChainSpecificArgumentsData.blockHash,
      actions: blockChainSpecificArgumentsData.actions,
    );
    final res = await nearRpcClient.sendSyncTx([signedAction]);
    return res;
  }

  //Call smart contract function
  @override
  Future<BlockchainResponse> callSmartContractFunction(
    String toAdress,
    String fromAdress,
    String privateKey,
    String publicKey,
    BlockChainSmartContractArguments arguments,
  ) async {
    if (arguments is! NearBlockChainSmartContractArguments) {
      throw Exception('Incorrect Blockchain Smart Contract Arguments');
    }
    final transactionInfo = await getNonceAndBlockHashInfo(
      accountId: fromAdress,
      publicKey: publicKey,
    );
    final gas = BlockchainGas.gas[BlockChains.near];
    if (gas == null) {
      throw Exception('Incorrect Blockchain Gas');
    }
    final List<Map<String, dynamic>> actions = [
      {
        "type": "functionCall",
        "data": {
          "methodName": arguments.method,
          "args": arguments.args,
        },
      },
    ];
    final blockChainSpecificArgumentsData = NearBlockChainSpecificArgumentsData(
      actions: actions,
      blockHash: transactionInfo.blockHash,
      gas: gas,
      nonce: transactionInfo.nonce,
      privateKey: privateKey,
    );

    final signedAction = await signNearActions(
      fromAddress: fromAdress,
      toAddress: toAdress,
      transferAmount: arguments.transferAmount,
      privateKey: blockChainSpecificArgumentsData.privateKey,
      gas: blockChainSpecificArgumentsData.gas,
      nonce: blockChainSpecificArgumentsData.nonce,
      blockHash: blockChainSpecificArgumentsData.blockHash,
      actions: blockChainSpecificArgumentsData.actions,
    );
    final res = await nearRpcClient.sendSyncTx([signedAction]);
    return res;
  }

  //Get wallet balance by account ID (hex representation of near account)
  @override
  Future<String> getWalletBalance(String accountId) async {
    final res = await nearRpcClient.getAccountBalance(accountId);
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
        "window.NearBlockchain.getBlockChainDataFromMnemonic('$mnemonic','$passphrase','${derivationPath.accountNumber}','${derivationPath.change}','${derivationPath.address}')");
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
  Future<NearTransactionInfoModel> getNonceAndBlockHashInfo(
      {required String accountId, required String publicKey}) async {
    final res =
        await nearRpcClient.getNonceAndBlockHashInfo(accountId, publicKey);

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
    required String fromAdress,
    required String privateKey,
    required String publicKey,
  }) async {
    final transactionInfo = await getNonceAndBlockHashInfo(
      accountId: fromAdress,
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
          "publicKey": publicKey,
        },
      },
    ];
    final blockChainSpecificArgumentsData = NearBlockChainSpecificArgumentsData(
      actions: actions,
      blockHash: transactionInfo.blockHash,
      gas: gas,
      nonce: transactionInfo.nonce,
      privateKey: privateKey,
    );

    final signedAction = await signNearActions(
      fromAddress: fromAdress,
      toAddress: fromAdress,
      transferAmount: "0",
      privateKey: blockChainSpecificArgumentsData.privateKey,
      gas: blockChainSpecificArgumentsData.gas,
      nonce: blockChainSpecificArgumentsData.nonce,
      blockHash: blockChainSpecificArgumentsData.blockHash,
      actions: blockChainSpecificArgumentsData.actions,
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
    final transactionInfo = await getNonceAndBlockHashInfo(
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
          "indexOfTheDerivationAccount":
              derivationPathOfNewGeneratedAccount.accountNumber,
          "permission": permission,
          "receiverId": smartContractId,
          "methodNames": methodNames,
        },
      },
    ];
    final blockChainSpecificArgumentsData = NearBlockChainSpecificArgumentsData(
      actions: actions,
      blockHash: transactionInfo.blockHash,
      gas: gas,
      nonce: transactionInfo.nonce,
      privateKey: privateKey,
    );

    final signedAction = await signNearActions(
      fromAddress: fromAddress,
      toAddress: fromAddress,
      transferAmount: allowance,
      privateKey: blockChainSpecificArgumentsData.privateKey,
      gas: blockChainSpecificArgumentsData.gas,
      nonce: blockChainSpecificArgumentsData.nonce,
      blockHash: blockChainSpecificArgumentsData.blockHash,
      actions: blockChainSpecificArgumentsData.actions,
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
        "window.NearBlockchain.getBase58PubKeyFromHexValue('${hexEncodedPubKey}')");
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
}
