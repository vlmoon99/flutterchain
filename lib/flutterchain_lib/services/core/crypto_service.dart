import 'dart:convert';
import 'dart:developer';

import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_derivation_path.dart';
import 'package:flutterchain/flutterchain_lib/models/core/account_info_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_smart_contract_arguments.dart';
import 'package:flutterchain/flutterchain_lib/models/core/transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/concordium_blockchain_service.dart';
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

  FlutterChainService({
    required this.jsVMService,
    NearBlockChainService? nearBlockchainService,
    BitcoinBlockChainService? bitcoinBlockchainService,
    ConcordiumBlockChainService? concordiumBlockchainService,
  }) {
    //Add blockChainServices
    if (nearBlockchainService != null) {
      blockchainServices.putIfAbsent(
        BlockChains.near,
        () => nearBlockchainService,
      );
    }
    if (bitcoinBlockchainService != null) {
      blockchainServices.putIfAbsent(
        BlockChains.bitcoin,
        () => bitcoinBlockchainService,
      );
    }
    if (concordiumBlockchainService != null) {
      blockchainServices.putIfAbsent(
        BlockChains.concordium,
        () => concordiumBlockchainService,
      );
    }
  }

  factory FlutterChainService.defaultInstance() {
    return FlutterChainService(
      jsVMService: getJsVM(),
      nearBlockchainService: NearBlockChainService.defaultInstance(),
      bitcoinBlockchainService: BitcoinBlockChainService.defaultInstance(),
      concordiumBlockchainService:
          ConcordiumBlockChainService.defaultInstance(),
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

  Future<String> getWalletBalance({
    required AccountInfoRequest accountInfoRequest,
    required String blockchainType,
  }) async {
    final res = await blockchainServices[blockchainType]
        ?.getWalletBalance(accountInfoRequest);
    return res ?? 'Error : no balance result';
  }

  Future<BlockchainResponse> sendTransferNativeCoin({
    required String blockchainType,
    required TransferRequest transferRequest,
  }) async {
    if (blockchainServices[blockchainType] == null) {
      throw Exception('Incorrect Blockchain');
    }

    final blockchainService = blockchainServices[blockchainType];
    final res = blockchainService?.sendTransferNativeCoin(transferRequest);

    if (res == null) {
      throw Exception('Incorrect Transfer');
    }
    return res;
  }

  Future<BlockchainResponse> callSmartContractFunction({
    required BlockChainSmartContractArguments smartContractArguments,
    required String blockchainType,
  }) async {
    if (!BlockChains.supportedBlockChainsForSmartContractCall
        .contains(blockchainType)) {
      throw Exception('Blockchain does not support smart contract call');
    }

    final res = await (blockchainServices[blockchainType]
            as BlockchainServiceWithSmartContractCallSupport?)
        ?.callSmartContractFunction(smartContractArguments);

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
        log("$chain is not provided. Skipping...");
        return;
      }

      late final BlockChainData blockChainData;

      if (chain == BlockChains.concordium) {
        final int identityProviderIndex =
            (await (chainService as ConcordiumBlockChainService)
                    .getIdentityProviders())
                .first
                .ipInfo["ipIdentity"];

        blockChainData = await chainService.getBlockChainData(
          mnemonic: mnemonic,
          derivationPath: ConcordiumDerivationPath(
            identityProviderIndex: identityProviderIndex,
          ),
        );
      } else {
        blockChainData = await chainService.getBlockChainData(
            mnemonic: mnemonic, passphrase: passphrase);
      }

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
