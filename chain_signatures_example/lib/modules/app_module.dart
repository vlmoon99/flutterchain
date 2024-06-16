import 'package:chain_signatures_example/constants/routs.dart';
import 'package:chain_signatures_example/exceptions/exceptions.dart';
import 'package:chain_signatures_example/modules/core_module.dart';
import 'package:chain_signatures_example/modules/guards/auth_guard.dart';
import 'package:chain_signatures_example/modules/pages/home/home_page.dart';
import 'package:chain_signatures_example/modules/pages/init/init_page.dart';
import 'package:chain_signatures_example/modules/vms/auth_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        CoreModule(),
      ];

  @override
  void binds(Injector i) {
    i.addSingleton(Catcher.new);
    i.addSingleton(AuthController.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      MainRoutes.auth,
      child: (_) => const InitPage(),
    );
    r.child(
      MainRoutes.home,
      child: (_) => const HomePage(),
      guards: [AuthGuard()],
    );
  }
}
