import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain_example/modules/home/pages/login_page.dart';
import 'package:flutterchain_example/modules/home/vm/home_vm.dart';
import 'package:flutterchain_example/routes/routes.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class CryptoListPage extends StatefulWidget {
  const CryptoListPage({Key? key}) : super(key: key);

  @override
  _CryptoListPageState createState() => _CryptoListPageState();
}

class _CryptoListPageState extends State<CryptoListPage> {
  String? selectedWallet =
      Modular.get<HomeVM>().cryptoLibary.walletsStream.valueOrNull?[0].name ??
          "No wallet founded"; // Default value

  @override
  Widget build(BuildContext context) {
    final homeVM = Modular.get<HomeVM>();
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;

    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          'Total Amount: \$" Not getTotalAmount() yet"',
          style: nearTextStyles.headline!.copyWith(
            fontWeight: FontWeight.bold,
            color: nearColors.nearPurple,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 20),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'Selected wallet: ${selectedWallet!.length > 30 ? '${selectedWallet!.substring(0, 30)}...' : selectedWallet!}',
              style: nearTextStyles.subhead!.copyWith(
                color: nearColors.nearPurple,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return ListView.builder(
                      itemCount: homeVM.cryptoLibary.walletsStream.value.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            homeVM.cryptoLibary.walletsStream.value[index].name,
                          ),
                          onTap: () {
                            setState(() {
                              final choosenWallet = homeVM
                                  .cryptoLibary.walletsStream.value[index];
                              selectedWallet = choosenWallet.name;
                              homeVM.walletIdStream.add(
                                choosenWallet.id,
                              );
                              log("Current Wallet ID ${homeVM.walletIdStream.value}");
                            });
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                primary: nearColors.nearPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Switch Wallet',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return LoginPage(
                      onLoginAction: () {
                        Navigator.pop(context);
                      },
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                primary: nearColors.nearPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Create Wallet',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: StreamBuilder<List<Wallet>>(
                stream: homeVM.cryptoLibary.walletsStream,
                builder: (context, snapshot) {
                  final currentWallet = (snapshot.data ?? []).firstWhereOrNull(
                      (element) => element.name == selectedWallet);
                  return ListView.builder(
                    itemCount: currentWallet?.blockchainsData?.keys.length ?? 0,
                    itemBuilder: (context, index) {
                      return InkWell(
                        splashColor: nearColors.nearPurple.withOpacity(0.2),
                        highlightColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {
                          // homeVM.walletIdStream.add(homeVM.cryptoLibary
                          //         .walletsStream.valueOrNull?.first.id ??
                          //     'not founded');

                          Modular.to.pushNamed(
                            Routes.home.getRoute(Routes.home.actions),
                            arguments: currentWallet?.blockchainsData?.keys
                                .toList()[index],
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: nearColors.nearPurple,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Index of Blockchain ->  $index\nname of crypto is -> ${currentWallet?.blockchainsData?.keys.toList()[index]} \nAmount: \$${" Not getTotalAmount() yet"}",
                                style: nearTextStyles.headline!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: nearColors.nearPurple,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
          ),
        ),
      ],
    );
  }
}

class BrowserTab extends StatelessWidget {
  const BrowserTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Browser Tab'),
    );
  }
}

class SettingsTab extends StatelessWidget {
  const SettingsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Settings Tab'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();

  int _currentPageIndex = 0;

  final List<Widget> _pages = const [
    CryptoListPage(),
    BrowserTab(),
    SettingsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Crypto App',
          style: nearTextStyles.headline,
        ),
        centerTitle: true,
        backgroundColor: nearColors.nearPurple,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        selectedItemColor: nearColors.nearBlue,
        unselectedItemColor: nearColors.nearBlue.withOpacity(0.3),
        onTap: _onPageSelected,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.web_stories),
            label: 'Browser',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
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
        curve: Curves.ease,
      );
    });
  }
}
