import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/modules/wallet/components/wallet_page_tabs.dart';
import 'package:flutterchain_example/theme/app_theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

//this is a Wallet page,it's the main page of UI.

class DesktopWalletScaffold extends StatefulWidget {
  const DesktopWalletScaffold({super.key});

  @override
  State<DesktopWalletScaffold> createState() => _DesktopWalletScaffoldState();
}

class _DesktopWalletScaffoldState extends State<DesktopWalletScaffold> {
  final PageController _pageController = PageController();

  int _currentPageIndex = 0;
  final List<Widget> _pages = const [
    WalletPageTab(),
    StackingTab(),
    ProfileTab(),
    HistoryTab()
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;

    return Scaffold(
        backgroundColor: nearColors.nearWhite,
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentPageIndex,
            selectedItemColor: nearColors.nearBlack,
            unselectedItemColor: nearColors.nearGray,
            onTap: _onPageSelected,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet), label: 'Wallet2'),
              BottomNavigationBarItem(
                  icon: Icon(FluentIcons.stack_24_regular), label: 'Stacking'),
              BottomNavigationBarItem(
                  icon: Icon(FluentIcons.person_24_regular), label: 'Profile'),
              BottomNavigationBarItem(
                icon: Icon(FluentIcons.history_24_regular),
                label: ('History'),
              )
            ]));
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  void _onPageSelected(int index) {
    setState(() {
      _currentPageIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    });
  }
}
