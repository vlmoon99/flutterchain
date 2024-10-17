import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/modules/wallet/components/core/wallet_page_tabs.dart';
import 'package:flutterchain_example/theme/app_theme.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabletWalletScaffold extends StatefulWidget {
  const TabletWalletScaffold({super.key});

  @override
  State<TabletWalletScaffold> createState() => _TabletWalletScaffoldState();
}

class _TabletWalletScaffoldState extends State<TabletWalletScaffold> {
  final PageController _pageController = PageController();
  int _currentPageIndex = 0;

  final List<Widget> _pages = const [
    WalletPageTab(),
    StackingTab(),
    ProfileTab(),
    HistoryTab(),
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
        showUnselectedLabels: true,
        onTap: _onPageSelected,
        items: [
          BottomNavigationBarItem(
            icon: _buildSvgIcon(
              'lib/assets/icon_svg/icon_wallet.svg',
              _currentPageIndex == 0,
              nearColors.nearBlack,
              nearColors.nearGray,
            ),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgIcon(
              'lib/assets/icon_svg/icon_stacking.svg',
              _currentPageIndex == 1,
              nearColors.nearBlack,
              nearColors.nearGray,
            ),
            label: 'Stacking',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgIcon(
              'lib/assets/icon_svg/icon_profile.svg',
              _currentPageIndex == 2,
              nearColors.nearBlack,
              nearColors.nearGray,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: _buildSvgIcon(
              'lib/assets/icon_svg/icon_history.svg',
              _currentPageIndex == 3,
              nearColors.nearBlack,
              nearColors.nearGray,
            ),
            label: 'History',
          ),
        ],
      ),
    );
  }

  Widget _buildSvgIcon(String assetName, bool isSelected, Color selectedColor,
      Color unselectedColor) {
    return SvgPicture.asset(
      assetName,
      color: isSelected ? selectedColor : unselectedColor,
      width: 24,
      height: 24,
    );
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
        curve: Curves.easeIn,
      );
    });
  }
}
