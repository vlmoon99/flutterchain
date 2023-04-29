import 'dart:convert';
import 'dart:developer';

import 'package:flutterchain/flutterchain_lib/constants/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/core/blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/js_vm.dart';

class FlutterChainService {
  final JsVMService jsVMService;
  final Map<String, BlockChainService> blockchainServices = {};

  FlutterChainService(
      {required this.jsVMService,
      required final NearBlockChainService nearBlockchainService}) {
    //Add blockChainServices
    blockchainServices.putIfAbsent(
        BlockChains.near, () => nearBlockchainService);
  }

  Future<void> setBlockchainNetworkEnvironment(
      {required String blockchainType, required String newUrl}) async {
    await blockchainServices[blockchainType]
        ?.setBlockchainNetworkEnvironment(newUrl: newUrl);
  }

  Future<dynamic> getWalletBalance(
      {required String accountId, required String blockchainType}) async {
    log("accountId $accountId");
    final res =
        await blockchainServices[blockchainType]?.getWalletBalance(accountId);
    return res;
  }

  Future<dynamic> sendTransferNativeCoin({
    required String toAdress,
    required String fromAdress,
    required String transferAmount,
    required String typeOfBlockchain,
    required String privateKey,
  }) async {
    if (blockchainServices[typeOfBlockchain] == null) {
      throw Exception('Incorrect Blockchain');
    }

    final blockchainService = blockchainServices[typeOfBlockchain];
    return blockchainService?.sendTransferNativeCoin(
        toAdress, fromAdress, transferAmount, privateKey);
  }

  Future<BlockchainResponse> callSmartContractFunction({
    required String toAdress,
    required String fromAdress,
    required String transferAmount,
    required String typeOfBlockchain,
    required String privateKey,
    required String methodName,
    required Map<String, dynamic> arguments,
  }) async {
    if (blockchainServices[typeOfBlockchain] == null) {
      throw Exception('Incorrect Blockchain');
    }

    final res =
        await blockchainServices[typeOfBlockchain]?.callSmartContractFunction(
      toAdress,
      fromAdress,
      transferAmount,
      privateKey,
      methodName,
      arguments,
    );

    if (res == null) {
      throw Exception('Incorrect Smart Contract Call');
    }

    return res;
  }

  Future<Map<String, Set<BlockChainData>>>
      createBlockchainsDataFromTheMnemonic({
    required String mnemonic,
    required String passphrase,
  }) async {
    final Map<String, Set<BlockChainData>> blockchainsData = {};
    await Future.forEach(BlockChains.supportedBlockChains, (chain) async {
      final chainService = blockchainServices[chain];
      if (chainService == null) {
        throw Exception('Incorrect Blockchain');
      }
      final blockChainData = await blockchainServices[chain]!
          .getBlockChainDataFromMnemonic(mnemonic, passphrase);

      blockchainsData.putIfAbsent(chain, () => {blockChainData});
    });

    return blockchainsData;
  }

  Future<Wallet> generateNewWallet(
      {String passphrase = '', required String walletName}) async {
    final res =
        await jsVMService.callJS("window.generateMnemonic('$passphrase')");
    final data = jsonDecode(res);

    return Wallet(
      id: '',
      mnemonic: data['mnemonic'],
      passphrase: passphrase,
      blockchainsData: {},
      name: walletName,
    );
  }

  Set<String> getBlockchainsUrlsByBlockchainType(String blockchainType) {
    return blockchainServices[blockchainType]!
        .getBlockchainsUrlsByBlockchainType();
  }
}
