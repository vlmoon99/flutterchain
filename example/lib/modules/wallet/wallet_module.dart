import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/modules/wallet/pages/core/wallet_page.dart';
import 'package:flutterchain_example/routes/routes.dart';

class WalletModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Routes.wallet.home, child: (_, args) => const WalletPage()),
  ];
}
