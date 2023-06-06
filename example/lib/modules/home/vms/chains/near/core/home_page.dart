import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain_example/modules/home/pages/core/create_wallet_page.dart';
import 'package:flutterchain_example/modules/home/vms/core/home_vm.dart';
import 'package:flutterchain_example/routes/routes.dart';
import 'package:flutterchain_example/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CryptoListPage extends StatefulWidget {
  const CryptoListPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CryptoListPageState createState() => _CryptoListPageState();
}

class _CryptoListPageState extends State<CryptoListPage> {
  String? selectedWallet;
  String? mnemonic;

  @override
  void initState() {
    super.initState();
    final cryptoLibrary = Modular.get<HomeVM>().cryptoLibrary;

    selectedWallet = cryptoLibrary.walletsStream.valueOrNull?.isNotEmpty ??
            false
        ? cryptoLibrary.walletsStream.valueOrNull?.first.name ?? 'not founded'
        : 'not founded';

    mnemonic = cryptoLibrary.walletsStream.valueOrNull?.isNotEmpty ?? false
        ? cryptoLibrary.walletsStream.valueOrNull?.first.mnemonic ??
            'not founded'
        : 'not founded';
  }

  @override
  Widget build(BuildContext context) {
    final homeVM = Modular.get<HomeVM>();
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    final cryptoLibrary = Modular.get<HomeVM>().cryptoLibrary;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return StreamBuilder<String>(
        stream: homeVM.userStore.walletIdStream,
        builder: (context, snapshot) {
          final currentWalletID = snapshot.data ?? 'not found';
          log("currentWalletID $currentWalletID");
          selectedWallet =
              cryptoLibrary.walletsStream.valueOrNull?.isNotEmpty ?? false
                  ? cryptoLibrary.walletsStream.valueOrNull
                          ?.firstWhereOrNull(
                              (element) => element.id == currentWalletID)
                          ?.name ??
                      'not found'
                  : 'not found';

          mnemonic =
              cryptoLibrary.walletsStream.valueOrNull?.isNotEmpty ?? false
                  ? cryptoLibrary.walletsStream.valueOrNull
                          ?.firstWhereOrNull(
                              (element) => element.id == currentWalletID)
                          ?.mnemonic ??
                      'not found'
                  : 'not found';

          return Column(
            children: [
              SizedBox(
                height: 10.w,
              ),
              Text(
                'Total Amount: \$" Not yet implemented"',
                style: nearTextStyles.headline!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: nearColors.nearPurple,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SelectableText(
                    'Selected wallet: ${selectedWallet!.length > 30 ? '${selectedWallet!.substring(0, 30)}...' : selectedWallet!}',
                    style: nearTextStyles.subhead!.copyWith(
                      color: nearColors.nearPurple,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                    ),
                    child: SelectableText(
                      'Your mnemonic: $mnemonic',
                      style: nearTextStyles.subhead!.copyWith(
                        color: nearColors.nearPurple,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  SizedBox(
                    width: 300,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return ListView.builder(
                              itemCount: homeVM.cryptoLibrary.walletsStream
                                      .valueOrNull?.length ??
                                  0,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  title: Text(
                                    homeVM.cryptoLibrary.walletsStream
                                        .value[index].name,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      final chosenWallet = homeVM.cryptoLibrary
                                          .walletsStream.value[index];
                                      selectedWallet = chosenWallet.name;
                                      homeVM.userStore.walletIdStream.add(
                                        chosenWallet.id,
                                      );
                                      log("Current Wallet ID ${homeVM.userStore.walletIdStream.value}");
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
                        backgroundColor: nearColors.nearPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Switch Wallet',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.w,
                  ),
                  SizedBox(
                    width: 300,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                child: CreateWalletPage(
                                  onLoginAction: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: nearColors.nearPurple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        'Create Wallet',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.w),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(width * 0.06),
                  child: StreamBuilder<List<Wallet>>(
                      stream: homeVM.cryptoLibrary.walletsStream,
                      builder: (context, snapshot) {
                        final currentWallet = (snapshot.data ?? [])
                            .firstWhereOrNull(
                                (element) => element.name == selectedWallet);
                        return ListView.builder(
                          itemCount:
                              currentWallet?.blockchainsData?.keys.length ?? 0,
                          itemBuilder: (context, index) {
                            return InkWell(
                              splashColor:
                                  nearColors.nearPurple.withOpacity(0.2),
                              highlightColor: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                // homeVM.userStore.walletIdStream.add(homeVM.cryptoLibrary
                                //         .walletsStream.valueOrNull?.first.id ??
                                //     'not founded');

                                Modular.to.pushNamed(
                                  Routes.home.getRoute(Routes.home.actions),
                                  arguments: currentWallet
                                      ?.blockchainsData?.keys
                                      .toList()[index],
                                );
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 8.0),
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
                                    Container(
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.only(
                                        bottom: 10.0,
                                      ),
                                      child: Text(
                                        'Blockchain data card',
                                        style:
                                            nearTextStyles.headline!.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: nearColors.nearPurple,
                                          fontSize: height * 0.018,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Blockchain -> ${currentWallet?.blockchainsData?.keys.toList()[index]} \nAmount: \$${" Not getTotalAmount() yet"}",
                                      style: nearTextStyles.headline!.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: nearColors.nearPurple,
                                        fontSize: height * 0.02,
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
        });
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
          'Flutter Chain Library Example',
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
