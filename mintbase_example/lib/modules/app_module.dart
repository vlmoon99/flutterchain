import 'package:flutter_modular/flutter_modular.dart';
import 'package:mintbase_example/modules/pages/init/init_module.dart';
import 'package:mintbase_example/routes/routes.dart';

class AppModule extends Module {
  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.module(CoreRoutes.init + CoreRoutes.init, module: InitModule());
  }
}
