import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/modules/home/pages/chains/concordium/concordium_blockchain_creation_page.dart';
import 'package:flutterchain_example/modules/home/pages/chains/concordium/concordium_blockchain_page.dart';
import 'package:flutterchain_example/modules/home/pages/core/crypto_actions_page.dart';
import 'package:flutterchain_example/modules/home/pages/core/home_page.dart';
import 'package:flutterchain_example/modules/home/pages/core/create_wallet_page.dart';
import 'package:flutterchain_example/modules/home/pages/chains/concordium/redirect_page.dart';
import 'package:flutterchain_example/modules/home/stores/chains/bitcoin_blockchain_store.dart';
import 'package:flutterchain_example/modules/home/stores/chains/near_blockchain_store.dart';
import 'package:flutterchain_example/modules/home/stores/core/user_store.dart';
import 'package:flutterchain_example/modules/home/vms/chains/bitcoin/bitcoin_vm.dart';
import 'package:flutterchain_example/modules/home/vms/chains/concordium_vm.dart';
import 'package:flutterchain_example/modules/home/vms/core/home_vm.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/near_vm.dart';
import 'package:flutterchain_example/routes/routes.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    //Inject Stores
    Bind.singleton((i) => UserStore()),
    Bind.singleton((i) => NearBlockchainStore()),
    Bind.singleton((i) => BitcoinBlockchainStore()),

    Bind.singleton(
      (i) => ConcordiumVm(
        i(),
      ),
    ),

    //Inject VMS
    Bind.singleton(
      (i) => HomeVM(
        i(),
        i(),
      ),
    ),
    Bind.singleton(
      (i) => NearVM(
        i(),
        i(),
        i(),
        i(),
      ),
    ),
    Bind.singleton(
      (i) => BitcoinVM(
        i(),
        i(),
        i(),
        i(),
      ),
    ),
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
      child: (_, args) => const CreateWalletPage(),
    ),
    ChildRoute(
      Routes.home.redirect,
      child: (_, args) => RedirectPage(args: args.data),
    ),
    ChildRoute(
      Routes.home.concordiumCreateAccount,
      child: (_, args) => ConcordiumBlockchainCreationPage(
        identityCaught: args.data ?? false,
      ),
    ),
    ChildRoute(
      Routes.home.concordiumActions,
      child: (context, args) => const ConcordiumBlockchainPage(),
    ),
  ];
}
