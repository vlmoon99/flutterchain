import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/modules/wallet/pages/settings_page.dart';
import 'package:flutterchain_example/modules/wallet/pages/wallet_page.dart';

import 'package:flutterchain_example/routes/routes.dart';

class WalletModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute(Routes.wallet.home, child: (_, args) => const WalletPage()),
    ChildRoute(Routes.wallet.send, child: (_, args) => const SettingsPage()),
  ];
}
