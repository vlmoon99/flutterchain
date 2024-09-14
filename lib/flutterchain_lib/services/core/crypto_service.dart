import 'dart:convert';

import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/bitcoin_blockchain_service.dart';
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
      required final NearBlockChainService nearBlockchainService,
      required final BitcoinBlockChainService bitcoinBlockchainService}) {
    //Add blockChainServices
    blockchainServices.putIfAbsent(
        BlockChains.near, () => nearBlockchainService);
    blockchainServices.putIfAbsent(
        BlockChains.bitcoin, () => bitcoinBlockchainService);
  }

  factory FlutterChainService.defaultInstance() {
    return FlutterChainService(
      jsVMService: getJsVM(),
      nearBlockchainService: NearBlockChainService.defaultInstance(),
      bitcoinBlockchainService: BitcoinBlockChainService.defaultInstance(),
    );
  }

  Future<void> setBlockchainNetworkEnvironment(
      {required String blockchainType,
      required BlockChainNetworkEnvironmentSettings
          blockChainNetworkEnvironmentSettings}) async {
    await blockchainServices[blockchainType]
        ?.setBlockchainNetworkEnvironment(blockChainNetworkEnvironmentSettings);
  }

  Future<BlockChainNetworkEnvironmentSettings?>
      getBlockchainNetworkEnvironment({
    required String blockchainType,
  }) async {
    return await blockchainServices[blockchainType]
        ?.getBlockchainNetworkEnvironment();
  }

  Future<String> getWalletBalance(
      {required TransferRequest transferRequest}) async {
    final res = await blockchainServices[transferRequest.blockchainType]
        ?.getWalletBalance(transferRequest);
    return res ?? 'Error : no balance result';
  }

  Future<BlockchainResponse> sendTransferNativeCoin(
      {required TransferRequest transferRequest}) async {
    if (blockchainServices[transferRequest.blockchainType] == null) {
      throw Exception('Incorrect Blockchain');
    }

    final blockchainService =
        blockchainServices[transferRequest.blockchainType];
    final res = blockchainService?.sendTransferNativeCoin(transferRequest);

    if (res == null) {
      throw Exception('Incorrect Transfer');
    }
    return res;
  }

  Future<BlockchainResponse> callSmartContractFunction({
    required TransferRequest transferRequest,
  }) async {
    if (blockchainServices[transferRequest.blockchainType] == null) {
      throw Exception('Incorrect Blockchain');
    }

    final res = await blockchainServices[transferRequest.blockchainType]
        ?.callSmartContractFunction(transferRequest);

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
          .getBlockChainData(mnemonic: mnemonic, passphrase: passphrase);

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
