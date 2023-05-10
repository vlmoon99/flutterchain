import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutterchain/flutterchain_lib/services/core/lib_initialization_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/assets/localizations/localizations_strings.dart';
import 'package:flutterchain_example/modules/app_module.dart';
import 'package:flutterchain_example/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runZonedGuarded(() async {
    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle.loadString('OFL.txt');
      yield LicenseEntryWithLineBreaks(['assets/fonts/manrope'], license);
    });
    WidgetsFlutterBinding.ensureInitialized();
    await initFlutterChainLib();
    await EasyLocalization.ensureInitialized();
    final isAuthorized = await checkIfUserAuthorized();

    //Catch Errors caught by Flutter
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      //TODO add catcher
    };
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]).then((value) => runApp(EasyLocalization(
          supportedLocales: const [
            Locale('en'),
          ],
          path: LocalizationsStrings.localizationPath,
          fallbackLocale: const Locale('en'),
          saveLocale: false,
          child: ModularApp(
            module: AppModule(),
            child: AppWidget(isAuthorized),
          ),
        )));
  }, (error, stack) {
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
    Modular.setInitialRoute(Routes.home.getModule());

    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Flutterchain Wallet',
            routeInformationParser: Modular.routeInformationParser,
            routerDelegate: Modular.routerDelegate,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          );
        });
    // !isAuthorized
    //     ? Modular.setInitialRoute(Routes.auth.getModule())
    //     : Modular.setInitialRoute(Routes.home.getModule());
    // Modular.setInitialRoute(Routes.home.getModule());
    // return MaterialApp.router(
    //   debugShowCheckedModeBanner: false,
    //   title: 'Flutterchain Wallet',
    //   routeInformationParser: Modular.routeInformationParser,
    //   routerDelegate: Modular.routerDelegate,
    //   localizationsDelegates: context.localizationDelegates,
    //   supportedLocales: context.supportedLocales,
    //   locale: context.locale,
    // );
  }
}
