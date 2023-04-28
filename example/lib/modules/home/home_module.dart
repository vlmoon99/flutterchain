import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/modules/home/pages/crypto_actions_page.dart';
import 'package:flutterchain_example/modules/home/pages/home_page.dart';
import 'package:flutterchain_example/modules/home/pages/login_page.dart';
import 'package:flutterchain_example/modules/home/stores/chains/near_blockchain_store.dart';
import 'package:flutterchain_example/modules/home/stores/core/user_store.dart';
import 'package:flutterchain_example/modules/home/vms/core/home_vm.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near_vm.dart';
import 'package:flutterchain_example/routes/routes.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    //Inject Stores
    Bind.singleton((i) => UserStore()),
    Bind.singleton((i) => NearBlockchainStore()),

    //Inject VMS
    Bind.singleton(
      (i) => HomeVM(
        i(),
        i(),
      ),
    ),
    Bind.singleton(
      (i) => NearVM(
        i(),
        i(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Routes.home.startPage, child: (_, args) => const HomePage()),
    ChildRoute(
      Routes.home.actions,
      child: (_, args) => const CryptoActionsPage(),
    ),
    ChildRoute(
      Routes.home.login,
      child: (_, args) => const LoginPage(),
    ),
  ];
}
