// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:flutterchain/flutterchain_lib.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/near_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/bitcoin_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/network/chains/concordium_grpc/concordium_rpc_client.dart';
import 'package:flutterchain/flutterchain_lib/network/chains/near_rpc_client.dart';
import 'package:flutterchain/flutterchain_lib/network/chains/bitcoin_rpc_client.dart';
import 'package:flutterchain/flutterchain_lib/repositories/wallet_repository.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/bitcoin_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/concordium_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/services/core/crypto_service.dart';
import 'package:flutterchain_example/modules/home/home_module.dart';
import 'package:flutterchain_example/modules/home/services/helper_service.dart';
import 'package:flutterchain_example/network/helper_network_client.dart';
import 'package:flutterchain_example/routes/routes.dart';
import 'package:flutterchain_example/theme/app_theme.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton(
      (i) => AppTheme(),
    ),
    Bind.singleton(
      (i) => const FlutterSecureStorage(),
    ),

    //Inject Blockchain Code

    //1. Near Blockchain
    Bind.singleton(
      (i) => NearNetworkClient(
        baseUrl: NearBlockChainNetworkUrls.listOfUrls.first,
        dio: Dio(),
      ),
    ),
    Bind.singleton(
      (i) => NearRpcClient(
        networkClient: i(),
      ),
    ),
    Bind.singleton(
      (i) => NearBlockChainService(
        nearRpcClient: i(),
      ),
    ),
    Bind.singleton(
      (i) => NearHelperNetworkClient(
        baseUrl: 'https://stark-everglades-95819.herokuapp.com',
        dio: Dio(),
      ),
    ),
    Bind.singleton(
      (i) => NearHelperService(
        i(),
      ),
    ),

    //1. Bitcoin Blockchain
    Bind.singleton(
      (i) => BitcoinNetworkClient(
        baseUrl: BitcoinBlockChainNetworkUrls.listOfUrls.first,
        dio: Dio(),
      ),
    ),
    Bind.singleton(
      (i) => BitcoinRpcClient(
        networkClient: i(),
      ),
    ),
    Bind.singleton(
      (i) => BitcoinBlockChainService(
        bitcoinRpcClient: i(),
      ),
    ),
    Bind.singleton(
      (i) => ConcordiumBlockChainService(
        concordiumRpcClient: ConcordiumRpcClient.defaultInstance(),
      ),
    ),

    //Inject Main Services for Main File of Crypto Library
    Bind.singleton(
      (i) => FlutterChainService(
        nearBlockchainService: i(),
        bitcoinBlockchainService: i(),
      ),
    ),
    Bind.singleton(
      (i) => WalletRepository(
        secureStorage: i(),
      ),
    ),
    //
    //Inject CryptoLibrary
    Bind.singleton(
      (i) => FlutterChainLibrary(
        i(),
        i(),
      ),
    ),
    //
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(
      Routes.home.module,
      module: HomeModule(),
    ),
  ];
}
