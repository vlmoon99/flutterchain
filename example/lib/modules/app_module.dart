// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:flutterchain/flutterchain_lib/constants/blockchains_network_urls.dart';
import 'package:flutterchain/flutterchain_lib.dart';
import 'package:flutterchain/flutterchain_lib/network/chains/near_rpc_client.dart';
import 'package:flutterchain/flutterchain_lib/repositories/wallet_repository.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/crypto_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/modules/auth/auth_module.dart';
import 'package:flutterchain_example/modules/home/home_module.dart';
import 'package:flutterchain_example/routes/routes.dart';
import 'package:flutterchain_example/theme/app_theme.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/js_engine_stub.dart'
    if (dart.library.io) 'package:flutterchain/flutterchain_lib/services/core/js_engines/platforms_implementations/webview_js_engine.dart'
    if (dart.library.js) 'package:flutterchain/flutterchain_lib/services/core/js_engines/platforms_implementations/web_js_engine.dart';
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

    Bind.singleton(
      (i) => Dio(),
    ),

    //Inject JS Engine
    Bind.singleton(
      (i) => getJsVM(),
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

    //Inject Main Services for Main File of Crypto Library
    Bind.singleton(
      (i) => FlutterChainService(
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
      Routes.auth.module,
      module: AuthModule(),
    ),
    ModuleRoute(
      Routes.home.module,
      module: HomeModule(),
    ),
  ];
}
