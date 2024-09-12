import 'package:flutter_modular/flutter_modular.dart';
import 'package:mintbase_example/modules/pages/auth/page/auth_page.dart';
import 'package:mintbase_example/routes/routes.dart';

class AuthModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(CoreRoutes.init, child: (context) => AuthPage());
  }
}
