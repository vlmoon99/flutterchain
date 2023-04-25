import 'dart:convert';
import 'dart:developer';

import 'package:flutterchain/flutterchain_lib/constants/blockchains_gas.dart';
import 'package:flutterchain/flutterchain_lib/constants/blockchains_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/constants/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_specific_arguments_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_transaction_info.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain/flutterchain_lib/network/chains/near_rpc_client.dart';
import 'package:flutterchain/flutterchain_lib/services/core/blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_vm.dart';

class NearBlockChainService implements BlockChainService {
  final JsVMService jsVMService;
  final NearRpcClient nearRpcClient;
  NearBlockChainService({
    required this.jsVMService,
    required this.nearRpcClient,
  });

  @override
  Future<String> getWalletBalance(String accountId) async {
    final res = await nearRpcClient.getAccountBalance(accountId);
    return res;
  }

  Future<NearTransactionInfoModel> getNonceAndBlockHashInfo(
      String accountId, publicKey) async {
    final res =
        await nearRpcClient.getNonceAndBlockHashInfo(accountId, publicKey);

    return res;
  }

  Future<BlockchainResponse> sendTransactionNearSync({
    required String tx,
  }) =>
      nearRpcClient.sendSyncTx([tx]);

  Future<BlockchainResponse> sendTransactionNearAsync({
    required String tx,
  }) =>
      nearRpcClient.sendSyncTx([tx]);

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
    log("decodedRes ${decodedRes.toString()}");
    return decodedRes['signedTransaction'].toString();
  }

  Future<BlockchainResponse> stake({
    required String fromAdress,
    required String privateKey,
    required String validatorId,
    required String amount,
  }) async {
    final transactionInfo =
        await getNonceAndBlockHashInfo(fromAdress, fromAdress);
    final gas = BlockchainGas.gas[BlockChains.near];
    if (gas == null) {
      throw Exception('Incorrect Blockchain Gas');
    }

    final List<Map<String, dynamic>> actions = [
      {
        "type": "stake",
        "data": {
          "publicKey": validatorId,
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
      toAddress: validatorId,
      transferAmount: amount,
      privateKey: blockChainSpecificArgumentsData.privateKey,
      gas: blockChainSpecificArgumentsData.gas,
      nonce: blockChainSpecificArgumentsData.nonce,
      blockHash: blockChainSpecificArgumentsData.blockHash,
      actions: blockChainSpecificArgumentsData.actions,
    );
    final res = await nearRpcClient.sendSyncTx([signedAction]);
    return res;
  }

  Future<BlockchainResponse> deleteKey({
    required String fromAdress,
    required String privateKey,
    required String publicKey,
  }) async {
    final transactionInfo =
        await getNonceAndBlockHashInfo(fromAdress, fromAdress);
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

  Future<BlockchainResponse> addKey({
    required String fromAdress,
    required String mnemonic,
    String passphrase = '',
    required String indexOfTheDerivationPath,
    required String permission,
    required String allowance,
    required String smartContractId,
    required List<String> methodNames,
    required String privateKey,
  }) async {
    final transactionInfo =
        await getNonceAndBlockHashInfo(fromAdress, fromAdress);
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
          "indexOfTheDerivationPath": indexOfTheDerivationPath,
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
      fromAddress: fromAdress,
      toAddress: fromAdress,
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

  @override
  Future<BlockchainResponse> callSmartContractFunction(
    String toAdress,
    String fromAdress,
    String transferAmount,
    String privateKey,
    String methodName,
    Map<String, dynamic> arguments,
  ) async {
    final transactionInfo =
        await getNonceAndBlockHashInfo(fromAdress, fromAdress);
    final gas = BlockchainGas.gas[BlockChains.near];
    if (gas == null) {
      throw Exception('Incorrect Blockchain Gas');
    }
    final List<Map<String, dynamic>> actions = [
      {
        "type": "functionCall",
        "data": {
          "methodName": methodName,
          "args": arguments,
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

  @override
  Future<BlockchainResponse> sendTransferNativeCoin(
    String toAdress,
    String fromAdress,
    String transferAmount,
    String privateKey,
  ) async {
    final transactionInfo =
        await getNonceAndBlockHashInfo(fromAdress, fromAdress);
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
      fromAddress: fromAdress,
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

  @override
  Future<BlockChainData> getBlockChainDataFromMnemonic(
      String mnemonic, String passphrase) async {
    final res = await jsVMService.callJS(
        "window.NearBlockchain.createNearWalletFromMnemonic('$mnemonic','$passphrase')");
    final blockChainData = NearBlockChainData.fromJson(jsonDecode(res));
    return blockChainData;
  }

  @override
  Future<void> setBlockchainNetworkEnvironment({required String newUrl}) async {
    nearRpcClient.networkClient.setUrl(newUrl);
  }

  @override
  Set<String> getBlockchainsUrlsByBlockchainType() {
    return NearBlockChainNetworkUrls.listOfUrls;
  }
}
