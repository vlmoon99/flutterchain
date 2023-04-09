import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/modules/home/pages/call_smart_contract_function.dart';
import 'package:flutterchain_example/modules/home/pages/home_page.dart';
import 'package:flutterchain_example/modules/home/pages/send_transaction.dart';
import 'package:flutterchain_example/modules/home/vm/home_vm.dart';
import 'package:flutterchain_example/routes/routes.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => HomeVM(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Routes.home.startPage, child: (_, args) => HomePage()),
    ChildRoute(Routes.home.sendTransaction,
        child: (_, args) => const SendTransactionPage()),
    ChildRoute(Routes.home.callSmartContractFunction,
        child: (_, args) => const CallSmartContractFunction()),
  ];
}
