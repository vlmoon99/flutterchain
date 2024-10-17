import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutterchain_example/modules/wallet/components/core/wallet_page_components/wallet_page_pressable_button.dart';
import 'package:flutterchain_example/modules/wallet/components/core/wallet_page_components/wallet_page_qr_code_button.dart';
import 'package:flutterchain_example/modules/wallet/components/core/wallet_page_components/wallet_page_send_button_action.dart';
import 'package:flutterchain_example/routes/routes.dart';
import '../../../../../assets/icon_images/icons.dart';
import 'package:flutterchain_example/modules/wallet/components/core/wallet_page_components/wallet_page_build_nfts.dart';
import 'package:flutterchain_example/modules/wallet/components/core/wallet_page_components/wallet_page_build_tokens.dart';

import 'package:flutterchain_example/theme/app_theme.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class StackingTab extends StatelessWidget {
  const StackingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("This is stacking tab"),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('this is a profile page'),
    );
  }
}

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('this is an history tab'),
    );
  }
}

class WalletPageTab extends StatelessWidget {
  const WalletPageTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 241, 240, 240),
        drawer: Drawer(
          child: Column(children: [
            const DrawerHeader(
              child: Icon(Icons.abc),
            ),
            ListTile(
              leading: const Icon(Icons.settings_rounded),
              title: const Text("SETTINGS"),
              onTap: () {
                Modular.to
                    .navigate(Routes.wallet.getRoute(Routes.wallet.settings));
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_support_rounded),
              title: const Text(" SUPPORT"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text(" ABOUT US"),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app_rounded),
              title: const Text(" LOGOUT"),
              onTap: () {},
            ),
          ]),
        ),
        body: SafeArea(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.only(top: 20.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                        left: 10.r,
                      ),
                      child: Builder(
                          builder: (context) => IconButton(
                                onPressed: () async {
                                  HapticFeedback.lightImpact();
                                  await Future.delayed(
                                      const Duration(milliseconds: 300));
                                  Scaffold.of(context).openDrawer();
                                },
                                icon: const AppIcon(
                                    iconType: IconType.settingsIcon),
                              ))),
                  Center(
                    child: Text(
                      'Wallet',
                      style: TextStyle(
                        color: nearColors.nearBlack,
                        fontFamily: 'Manrope',
                        fontWeight: FontWeight.w900,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10.r),
                    child: IconButton(
                      icon: const AppIcon(iconType: IconType.scanIcon),
                      onPressed: () async {
                        HapticFeedback.lightImpact();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return walletPageQrCodeButton();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

//balance
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.r),
              child: Center(
                child: SizedBox(
                  child: Column(
                    children: [
                      Text('Total Balance',
                          style: nearTextStyles.label!.copyWith(
                              color: nearColors.nearGray, fontSize: 16.sp)),
                      Text('\$2,663.56',
                          style: nearTextStyles.bodyCopy!.copyWith(
                              color: nearColors.nearBlack,
                              fontSize: 33.sp,
                              fontWeight: FontWeight.w900)),
                    ],
                  ),
                ),
              ),
            ),
//buttons
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.r),
              child: Center(
                child: SizedBox(
                  width: 326.w,
                  height: 80.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PressableIconButton(
                          title: "Send",
                          icon: AppIcon(
                            iconType: IconType.send,
                            size: 56.h,
                          ),
                          onTapped: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return WalletPageSendButton();
                                });
                          }),
                      PressableIconButton(
                          title: "Receive",
                          icon: AppIcon(
                            iconType: IconType.receive,
                            size: 56.h,
                          ),
                          onTapped: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return WalletPageSendButton();
                                });
                          }),
                      PressableIconButton(
                          title: "Buy",
                          icon: AppIcon(
                            iconType: IconType.buy,
                            size: 56.h,
                          ),
                          onTapped: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return WalletPageSendButton();
                                });
                          }),
                      PressableIconButton(
                          title: "Swap",
                          icon: AppIcon(
                            iconType: IconType.swap,
                            size: 56.h,
                          ),
                          onTapped: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return WalletPageSendButton();
                                });
                          }),
                    ],
                  ),
                ),
              ),
            ),

            // this is a Tokens/NFTs tab
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: nearColors.nearWhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.dg),
                        topRight: Radius.circular(16.dg))),
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 375.w,
                        height: 10.h,
                      ),
                      Container(
                        width: 327.w,
                        height: 53.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.dg),
                            color: const Color.fromARGB(255, 241, 240, 240)),
                        child: TabBar(
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorPadding: EdgeInsets.all(4.5.r),
                          indicator: BoxDecoration(
                            color: nearColors.nearBlack,
                            borderRadius: BorderRadius.circular(12.dg),
                          ),
                          labelColor: nearColors.nearWhite,
                          labelStyle:
                              const TextStyle(fontWeight: FontWeight.w600),
                          unselectedLabelColor: Colors.black,
                          tabs: [
                            Tab(
                              child: Text(
                                "Tokens",
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "NFTs",
                                style: TextStyle(fontSize: 14.sp),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [const BuilTokens(), BuildNft()],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}
