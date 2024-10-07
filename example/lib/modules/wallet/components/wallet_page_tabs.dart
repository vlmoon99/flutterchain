import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/modules/wallet/components/wallet_page_components/wallet_page_qr_code_button.dart';
import 'package:flutterchain_example/modules/wallet/components/wallet_page_components/wallet_page_send_button_action.dart';
import 'package:flutterchain_example/routes/routes.dart';
import '../../../../assets/icon_images/icons.dart';
import 'package:flutterchain_example/modules/wallet/components/wallet_page_build_nfts.dart';
import 'package:flutterchain_example/modules/wallet/components/wallet_page_components/wallet_page_build_button.dart';
import 'package:flutterchain_example/modules/wallet/components/wallet_page_components/wallet_page_build_tokens.dart';

import 'package:flutterchain_example/theme/app_theme.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class StackingTab extends StatelessWidget {
  const StackingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('this is Stacking tab'),
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
        body: SafeArea(
          child: Column(
            children: [
              //wallet and icons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.r),
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Modular.to.navigate(
                              Routes.wallet.getRoute(Routes.wallet.send));
                        },
                        child: const Icon(Icons.settings),
                      ),
                      Text(
                        'Wallet',
                        style: TextStyle(
                            color: nearColors.nearBlack,
                            fontFamily: 'Manrope',
                            fontWeight: FontWeight.w700,
                            fontSize: 20.sp),
                      ),
                      IconButton(
                        icon: Icon(Icons.qr_code),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return WalletPageQrCodeButton();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

//balance
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.r),
                child: Center(
                  child: SizedBox(
                    width: 166.w,
                    height: 64.h,
                    child: Column(
                      children: [
                        Text('Total balance',
                            style: nearTextStyles.label!.copyWith(
                                color: nearColors.nearGray, fontSize: 16.sp)),
                        Text('\$2,663.56',
                            style: nearTextStyles.bodyCopy!.copyWith(
                                color: nearColors.nearBlack,
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
              ),
//buttons
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.r),
                child: Center(
                  child: SizedBox(
                    width: 326.w,
                    height: 80.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return WalletPageSendButton();
                              },
                            );
                          },
                          child: buildActionButtons(
                              context,
                              AppIcon(
                                iconType: IconType.send,
                                size: 56.h,
                              ),
                              'Send'),
                        ),
                        InkWell(
                          child: buildActionButtons(
                              context,
                              AppIcon(
                                iconType: IconType.receive,
                                size: 56.h,
                              ),
                              'Receive'),
                        ),
                        InkWell(
                          child: buildActionButtons(
                              context,
                              AppIcon(iconType: IconType.buy, size: 56.h),
                              'Buy'),
                        ),
                        InkWell(
                          child: buildActionButtons(
                              context,
                              AppIcon(
                                iconType: IconType.swap,
                                size: 56.h,
                              ),
                              'Swap'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // this is a Tokens/NFTs tab
              Expanded(
                child: Container(
                  color: nearColors.nearWhite,
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        Container(
                          width: 327.w,
                          height: 56.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.dg),
                              color: const Color.fromARGB(255, 241, 240, 240)),
                          child: TabBar(
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicatorPadding: EdgeInsets.all(4.5.r),
                            indicator: BoxDecoration(
                              color: nearColors.nearBlack,
                              borderRadius: BorderRadius.circular(17),
                            ),
                            labelColor: nearColors.nearWhite,
                            labelStyle:
                                const TextStyle(fontWeight: FontWeight.w600),
                            unselectedLabelColor: Colors.black,
                            tabs: const [
                              Tab(
                                text: 'Tokens',
                              ),
                              Tab(
                                text: 'NFTs',
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [buildTokens(), BuildNft()],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
