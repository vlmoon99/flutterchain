import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/modules/pages/auth/auth_module.dart';
import 'package:mintbase_example/modules/pages/init/page/init_page.dart';
import 'package:mintbase_example/routes/routes.dart';
import 'package:mintbase_example/modules/controllers/auth_controller.dart';

class InitModule extends Module {
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
    r.module(CoreRoutes.auth, module: AuthModule());
  }
}
