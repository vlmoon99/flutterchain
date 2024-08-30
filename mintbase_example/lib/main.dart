import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterchain/flutterchain_lib/services/core/lib_initialization_service.dart';
import 'package:mintbase_example/modules/app_module.dart';
import 'package:mintbase_example/routes/routes.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initFlutterChainLib();
    final isAuthorized = await checkIfUserAuthorized();

    //Catch Errors caught by Flutter
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      //TODO add catcher
    };

    runApp(ModularApp(module: AppModule(), child: AppWidget(isAuthorized)));
  }, (error, stack) {
    print(error.toString());
    //Catch Errors not caught by Flutter
    //TODO add catcher
  });
}

class AppWidget extends StatelessWidget {
  final bool isAuthorized;
  // ignore: use_key_in_widget_constructors
  const AppWidget(this.isAuthorized);

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(CoreRoutes.init);
    ScreenUtil.init(context);
    ScreenUtil.configure(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
    );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Mintbase Flutterchain Example',
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
