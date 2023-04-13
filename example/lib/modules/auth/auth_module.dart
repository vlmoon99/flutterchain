import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/modules/auth/pages/intro_page.dart';
import 'package:flutterchain_example/modules/auth/pages/login_page.dart';
import 'package:flutterchain_example/modules/auth/vm/auth_vm.dart';
import 'package:flutterchain_example/routes/routes.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    // Bind.singleton(
    //   (i) => AuthVM(
    //     i(),
    //   ),
    // ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Routes.auth.intro,
      child: (_, args) => const IntroPage(),
    ),
    ChildRoute(
      Routes.auth.login,
      child: (_, args) => const LoginPage(),
    ),
  ];
}
