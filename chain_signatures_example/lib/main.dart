import 'dart:async';

import 'package:chain_signatures_example/constants/routs.dart';
import 'package:chain_signatures_example/constants/theme.dart';
import 'package:chain_signatures_example/exceptions/exceptions.dart';
import 'package:chain_signatures_example/modules/app_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterchain/flutterchain_lib/services/core/lib_initialization_service.dart';

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    initFlutterChainLib();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]).then((_) {
      runApp(
        ModularApp(
          module: AppModule(),
          child: const AppWidget(),
        ),
      );
    });
  }, (error, stack) {
    final catcher = Modular.get<Catcher>();
    final appException = AppExceptions(
      messageForUser: error.toString(),
      messageForDev: error.toString(),
    );
    catcher.exceptionsHandler.add(
      appException,
    );
  });
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute(MainRoutes.home);
    ScreenUtil.init(context);
    ScreenUtil.configure(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
    );
    return MaterialApp.router(
      title: 'Near Chain Signatures',
      debugShowCheckedModeBanner: false,
      routerConfig: Modular.routerConfig,
      theme: appTheme,
    );
  }
}
