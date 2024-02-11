import 'dart:convert';

import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_smart_contract_arguments.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/core/blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/js_vm.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/js_engine_stub.dart'
    if (dart.library.io) 'package:flutterchain/flutterchain_lib/services/core/js_engines/platforms_implementations/webview_js_engine.dart'
    if (dart.library.js) 'package:flutterchain/flutterchain_lib/services/core/js_engines/platforms_implementations/web_js_engine.dart';

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
  factory FlutterChainService.defaultInstance() {
    return FlutterChainService(
      jsVMService: getJsVM(),
      nearBlockchainService: NearBlockChainService.defaultInstance(),
    );
  }

  Future<void> setBlockchainNetworkEnvironment(
      {required String blockchainType, required String newUrl}) async {
    await blockchainServices[blockchainType]
        ?.setBlockchainNetworkEnvironment(newUrl: newUrl);
  }

  Future<String> getBlockchainNetworkEnvironment({
    required String blockchainType,
  }) async {
    return await blockchainServices[blockchainType]
            ?.getBlockchainNetworkEnvironment() ??
        "no link";
  }

  Future<String> getWalletBalance(
      {required String accountId, required String blockchainType}) async {
    final res =
        await blockchainServices[blockchainType]?.getWalletBalance(accountId);
    return res ?? 'Error : no balance result';
  }

  Future<BlockchainResponse> sendTransferNativeCoin({
    required String toAddress,
    required String fromAddress,
    required String transferAmount,
    required String typeOfBlockchain,
    required String privateKey,
    required String publicKey,
  }) async {
    if (blockchainServices[typeOfBlockchain] == null) {
      throw Exception('Incorrect Blockchain');
    }

    final blockchainService = blockchainServices[typeOfBlockchain];
    final res = blockchainService?.sendTransferNativeCoin(
        toAddress, fromAddress, transferAmount, privateKey, publicKey);

    if (res == null) {
      throw Exception('Incorrect Transfer');
    }
    return res;
  }

  Future<BlockchainResponse> callSmartContractFunction({
    required String fromAddress,
    required String typeOfBlockchain,
    required String privateKey,
    required String publicKey,
    required String toAddress,
    required BlockChainSmartContractArguments arguments,
  }) async {
    if (blockchainServices[typeOfBlockchain] == null) {
      throw Exception('Incorrect Blockchain');
    }

    final res =
        await blockchainServices[typeOfBlockchain]?.callSmartContractFunction(
      toAddress,
      fromAddress,
      privateKey,
      publicKey,
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
