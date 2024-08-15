import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/modules/pages/auth/auth_page.dart';
import 'package:mintbase_example/modules/pages/init/init_page.dart';
import 'package:mintbase_example/routes/routes.dart';
import 'package:mintbase_example/modules/controllers/auth_controller.dart';

class AppModule extends Module {
  @override
  void binds(i) {
    i.addSingleton(NearBlockChainService.defaultInstance);
    i.addSingleton<FlutterSecureStorage>(() => const FlutterSecureStorage(
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
          ),
        ));
    i.addSingleton<AuthController>(AuthController.new, key: "AuthController");
  }

  @override
  void routes(r) {
    r.child(CoreRoutes.home, child: (context) => const InitPage());
    r.child(CoreRoutes.auth, child: (context) => const AuthPage());
  }
}
