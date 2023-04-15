import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/modules/home/pages/call_smart_contract_function.dart';
import 'package:flutterchain_example/modules/home/pages/crypto_actions_page.dart';
import 'package:flutterchain_example/modules/home/pages/home_page.dart';
import 'package:flutterchain_example/modules/home/pages/send_transaction.dart';
import 'package:flutterchain_example/routes/routes.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Routes.home.startPage, child: (_, args) => const HomePage()),
    ChildRoute(Routes.home.sendTransaction,
        child: (_, args) => const SendTransactionPage()),
    ChildRoute(
      Routes.home.callSmartContractFunction,
      child: (_, args) => const CallSmartContractFunction(),
    ),
    ChildRoute(
      Routes.home.actions,
      child: (_, args) => CryptoActionsPage(),
    ),
  ];
}
