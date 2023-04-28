import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/modules/home/pages/crypto_actions_page.dart';
import 'package:flutterchain_example/modules/home/pages/home_page.dart';
import 'package:flutterchain_example/modules/home/pages/login_page.dart';
import 'package:flutterchain_example/modules/home/vm/home_vm.dart';
import 'package:flutterchain_example/modules/home/vm/near_vm.dart';
import 'package:flutterchain_example/routes/routes.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    //Inject VMS
    Bind.singleton((i) => HomeVM(i())),
    Bind.singleton((i) => NearVM(i())),
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
