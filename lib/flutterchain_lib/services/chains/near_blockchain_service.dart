import 'dart:convert';

import 'package:flutterchain/flutterchain_lib/constants/blockchains_gas.dart';
import 'package:flutterchain/flutterchain_lib/constants/blockchains_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/constants/supported_blockchains.dart';
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
      nearRpcClient.sendAsyncTx([tx]);

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
    required String fromAddress,
    required String mnemonic,
    String passphrase = '',
    required DerivationPath derivationPathOfNewGeneratedAccount,
    required String permission,
    required String allowance,
    required String smartContractId,
    required List<String> methodNames,
    required String privateKey,
  }) async {
    final transactionInfo =
        await getNonceAndBlockHashInfo(fromAddress, fromAddress);
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

  @override
  Future<String> getWalletBalance(String accountId) async {
    final res = await nearRpcClient.getAccountBalance(accountId);
    return res;
  }

  @override
  Future<BlockchainResponse> callSmartContractFunction(
    String toAdress,
    String fromAdress,
    String privateKey,
    BlockChainSmartContractArguments arguments,
  ) async {
    if (arguments is! NearBlockChainSmartContractArguments) {
      throw Exception('Incorrect Blockchain Smart Contract Arguments');
    }
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
  Future<NearBlockChainData> getBlockChainDataFromMnemonic(
      String mnemonic, String passphrase) async {
    final res = await jsVMService.callJS(
        "window.NearBlockchain.getBlockChainDataFromMnemonic('$mnemonic','$passphrase')");
    final decodedRes = jsonDecode(res);
    final blockChainData = NearBlockChainData.fromJson(decodedRes);
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
}
