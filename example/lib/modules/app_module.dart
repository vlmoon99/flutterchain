import 'package:dio/dio.dart';
import 'package:flutterchain/flutterchain_lib/constants/blockchains_network_urls.dart';
import 'package:flutterchain/flutterchain_lib.dart';
import 'package:flutterchain/flutterchain_lib/network/chains/near_rpc_client.dart';
import 'package:flutterchain/flutterchain_lib/repositories/wallet_repository.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_vm.dart';
import 'package:flutterchain/flutterchain_lib/services/crypto_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterchain_example/modules/auth/auth_module.dart';
import 'package:flutterchain_example/modules/home/home_module.dart';
import 'package:flutterchain_example/modules/home/vm/home_vm.dart';
import 'package:flutterchain_example/routes/routes.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton(
      (i) => AppTheme(),
    ),
    Bind.singleton(
      (i) => const FlutterSecureStorage(),
    ),
    Bind.singleton(
      (i) => JsVMService(),
    ),
    Bind.singleton(
      (i) => Dio(),
    ),
    //Inject Blockchain Code

    //1. Near Blockchain
    Bind.singleton(
      (i) => NearNetworkClient(
        baseUrl: NearBlockChainNetworkUrls.listOfUrls.first,
        dio: i(),
      ),
    ),
    Bind.singleton(
      (i) => NearRpcClient(
        networkClient: i(),
      ),
    ),
    Bind.singleton(
      (i) => NearBlockChainService(
        jsVMService: i(),
        nearRpcClient: i(),
      ),
    ),
    //

    //

    //Inject Main Services for Main File of Crypto Libary
    Bind.singleton(
      (i) => CryptoService(
        jsVMService: i(),
        nearBlockchainService: i(),
      ),
    ),
    Bind.singleton(
      (i) => WalletRepository(
        secureStorage: i(),
      ),
    ),
    //
    //Inject CryptoLibary
    Bind.singleton(
      (i) => FlutterChainCryptoLibrary(
        i(),
        i(),
      ),
    ),
    //
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(
      Routes.auth.module,
      module: AuthModule(),
    ),
    ModuleRoute(
      Routes.home.module,
      module: HomeModule(),
    ),
  ];
}
