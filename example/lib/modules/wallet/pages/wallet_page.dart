import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterchain_example/modules/wallet/pages/core/components/scaffolds/desktop_wallet_scaffold.dart';
import 'package:flutterchain_example/modules/wallet/pages/core/components/scaffolds/mobile_wallet_scaffold.dart';
import 'package:flutterchain_example/modules/wallet/pages/core/components/scaffolds/tablet_wallet_scaffold.dart';

class ResponsiveWalletUi extends StatelessWidget {
  final mobileWalletScaffold;
  final tabletWalletScaffold;
  final desktopWalletScaffold;

  const ResponsiveWalletUi(
      {super.key,
      this.mobileWalletScaffold,
      this.tabletWalletScaffold,
      this.desktopWalletScaffold});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 500) {
        return mobileWalletScaffold;
      } else if (constraints.maxWidth < 1100) {
        return tabletWalletScaffold;
      } else {
        return desktopWalletScaffold;
      }
    });
  }
}

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResponsiveWalletUi(
        mobileWalletScaffold: MobileWalletScaffold(),
        tabletWalletScaffold: TabletWalletScaffold(),
        desktopWalletScaffold: DesktopWalletScaffold(),
      ),
    );
  }
}
