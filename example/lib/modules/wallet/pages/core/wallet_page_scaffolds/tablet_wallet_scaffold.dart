import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:flutterchain_example/modules/wallet/components/wallet_page_tabs.dart';
import 'package:flutterchain_example/theme/app_theme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

//this is a Wallet page,it's the main page of UI.

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
                  icon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
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




















// import 'dart:math';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:flutter/material.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:flutterchain_example/theme/app_theme.dart';
// import 'package:flutterchain_example/assets/images/icons.dart';
// import 'package:fluentui_system_icons/fluentui_system_icons.dart';

// //this is an action buttons
// Widget _buildButton(BuildContext context, AppIcon icon, String label) {
//   final theme = Modular.get<AppTheme>();
//   final nearColors = theme.getTheme().extension<NearColors>()!;
//   final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
//   return Column(
//     children: [
//       Container(
//         // padding: EdgeInsets.all(16.w),
//         child: icon,
//       ),
//       Text(label,
//           style: nearTextStyles.label!.copyWith(color: nearColors.nearBlack)),
//     ],
//   );
// }

// Widget _buildTokensAndNfts() {
//   final theme = Modular.get<AppTheme>();
//   final nearColors = theme.getTheme().extension<NearColors>()!;
//   final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;

//   List<Map<dynamic, dynamic>> tokens = [
//     {
//       'icon': const AppIcon(
//         iconType: IconType.nearIcon,
//         size: 40,
//       ),
//       'name': "NEAR",
//       'price': '\$6.34',
//       'amount': '198.24 NEAR',
//       'change': '^ 2.6%',
//       'total price': '\$1251.44'
//     },
//     {
//       'icon': const AppIcon(
//         iconType: IconType.octopusIcon,
//         size: 40,
//       ),
//       'name': "Octopus Network",
//       'price': '\$0.34',
//       'amount': '0.6317 OCT',
//       'change': '^ 3.6%',
//       'total price': '\$0.70'
//     },
//     {
//       'icon': const AppIcon(
//         iconType: IconType.deipIcon,
//         size: 40,
//       ),
//       'name': "DEIP Token",
//       'price': '\$0.34',
//       'amount': '555.94874 DEIP',
//       'change': '⌄  0,97%',
//       'total price': '\$0.76'
//     },
//     {
//       'icon': const AppIcon(
//         iconType: IconType.auroraIcon,
//         size: 40,
//       ),
//       'name': "Aurora",
//       'price': '\$6.34',
//       'amount': '300 Aurora',
//       'change': '^ 2.6%',
//       'total price': '\$1137'
//     },
//     {
//       'icon': const AppIcon(
//         iconType: IconType.usnIcon,
//         size: 40,
//       ),
//       'name': "USN",
//       'price': '\$1.33',
//       'amount': '205 USN',
//       'change': '^ 38.76%',
//       'total price': '\$276.65'
//     }
//   ];

//   return ListView.separated(
//     separatorBuilder: (context, index) => Divider(
//       color: nearColors.nearGray,
//       thickness: 0.1,
//     ),
//     itemCount: tokens.length,
//     itemBuilder: (context, index) {
//       final token = tokens[index];
//       return ListTile(
//         leading: token['icon'] as Widget,
//         title: Text(
//           token['name']!,
//           style: nearTextStyles.highlight!.copyWith(
//               color: nearColors.nearBlack, fontWeight: FontWeight.w700),
//         ),
//         subtitle: Row(
//           children: [
//             Text(
//               token['price']!,
//             ),
//             SizedBox(
//               width: 3.w,
//             ),
//             Text(
//               token['change']!,
//               style: TextStyle(
//                   color: token['change']!.contains('⌄ ')
//                       ? Colors.red
//                       : Colors.green),
//             ),
//           ],
//         ),
//         trailing: Column(
//           children: [
//             Text(token['amount']!,
//                 style: nearTextStyles.label!.copyWith(
//                     color: nearColors.nearBlack,
//                     fontWeight: FontWeight.w700,
//                     fontSize: 10.sp)),
//             Text(token['total price']!,
//                 style: nearTextStyles.label!
//                     .copyWith(color: nearColors.nearGray, fontSize: 12.sp)),
//           ],
//         ),
//       );
//     },
//   );
// }

// //this is a Wallet page,it's the main page of UI.

// class WalletPageTab extends StatelessWidget {
//   const WalletPageTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Modular.get<AppTheme>();
//     final nearColors = theme.getTheme().extension<NearColors>()!;
//     final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;

//     return Scaffold(
//         backgroundColor: const Color.fromARGB(255, 241, 240, 240),
//         body: SafeArea(
//           child: Column(
//             children: [
//               //wallet and icons
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 24.r),
//                 child: SizedBox(
//                   height: 28.h,
//                   width: 375.w,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Icon(Icons.settings),
//                       Text(
//                         'Wallet  for tablet',
//                         style: TextStyle(
//                             color: nearColors.nearBlack,
//                             fontFamily: 'Manrope',
//                             fontWeight: FontWeight.w700,
//                             fontSize: 20.sp),
//                       ),
//                       Icon(Icons.qr_code_scanner)
//                     ],
//                   ),
//                 ),
//               ),

// //balance
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 15.r),
//                 child: Center(
//                   child: SizedBox(
//                     width: 166.w,
//                     height: 64.h,
//                     child: Column(
//                       children: [
//                         Text('Total balance',
//                             style: nearTextStyles.label!.copyWith(
//                                 color: nearColors.nearGray, fontSize: 16.sp)),
//                         Text('\$2,663.56',
//                             style: nearTextStyles.bodyCopy!.copyWith(
//                                 color: nearColors.nearBlack,
//                                 fontSize: 26.sp,
//                                 fontWeight: FontWeight.w700)),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
// //buttons
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 20.r),
//                 child: Center(
//                   child: SizedBox(
//                     width: 326.w,
//                     height: 80.h,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         _buildButton(
//                             context,
//                             AppIcon(
//                               iconType: IconType.send,
//                               size: 56.h,
//                             ),
//                             'Send'),
//                         _buildButton(
//                             context,
//                             AppIcon(
//                               iconType: IconType.receive,
//                               size: 56.h,
//                             ),
//                             'Receive'),
//                         _buildButton(context,
//                             AppIcon(iconType: IconType.buy, size: 56.h), 'Buy'),
//                         _buildButton(
//                             context,
//                             AppIcon(
//                               iconType: IconType.swap,
//                               size: 56.h,
//                             ),
//                             'Swap'),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),

//               // this is a Tokens/NFTs tab
//               Expanded(
//                 child: Container(
//                   color: nearColors.nearWhite,
//                   child: DefaultTabController(
//                     length: 2,
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 327.w,
//                           height: 56.h,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(16.dg),
//                               color: const Color.fromARGB(255, 241, 240, 240)),
//                           child: TabBar(
//                             indicatorSize: TabBarIndicatorSize.tab,
//                             indicatorPadding: EdgeInsets.all(4.5.r),
//                             indicator: BoxDecoration(
//                               color: nearColors.nearBlack,
//                               borderRadius: BorderRadius.circular(17),
//                             ),
//                             labelColor: nearColors.nearWhite,
//                             labelStyle:
//                                 const TextStyle(fontWeight: FontWeight.w600),
//                             unselectedLabelColor: Colors.black,
//                             tabs: const [
//                               Tab(
//                                 text: 'Tokens',
//                               ),
//                               Tab(
//                                 text: 'NFTs',
//                               )
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10.h,
//                         ),
//                         Expanded(
//                           child: TabBarView(
//                             children: [
//                               _buildTokensAndNfts(),
//                               const Center(
//                                 child: Text(
//                                   'this is nft tab',
//                                   style: TextStyle(color: Colors.black),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }

// class StackingTab extends StatelessWidget {
//   const StackingTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('this is Stacking tab'),
//     );
//   }
// }

// class ProfileTab extends StatelessWidget {
//   const ProfileTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('this is a profile page'),
//     );
//   }
// }

// class HistoryTab extends StatelessWidget {
//   const HistoryTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('this is an history tab'),
//     );
//   }
// }

// class TabletWalletScaffold extends StatefulWidget {
//   const TabletWalletScaffold({super.key});

//   @override
//   State<TabletWalletScaffold> createState() => _TabletWalletScaffoldState();
// }

// class _TabletWalletScaffoldState extends State<TabletWalletScaffold> {
//   final PageController _pageController = PageController();

//   int _currentPageIndex = 0;
//   final List<Widget> _pages = const [
//     WalletPageTab(),
//     StackingTab(),
//     ProfileTab(),
//     HistoryTab()
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final theme = Modular.get<AppTheme>();
//     final nearColors = theme.getTheme().extension<NearColors>()!;

//     return Scaffold(
//         backgroundColor: nearColors.nearWhite,
//         body: PageView(
//           controller: _pageController,
//           onPageChanged: _onPageChanged,
//           children: _pages,
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//             currentIndex: _currentPageIndex,
//             selectedItemColor: nearColors.nearBlack,
//             unselectedItemColor: nearColors.nearGray,
//             onTap: _onPageSelected,
//             items: const [
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.account_balance_wallet), label: 'Wallet'),
//               BottomNavigationBarItem(
//                   icon: Icon(FluentIcons.stack_24_regular), label: 'Stacking'),
//               BottomNavigationBarItem(
//                   icon: Icon(FluentIcons.person_24_regular), label: 'Profile'),
//               BottomNavigationBarItem(
//                 icon: Icon(FluentIcons.history_24_regular),
//                 label: ('History'),
//               )
//             ]));
//   }

//   void _onPageChanged(int index) {
//     setState(() {
//       _currentPageIndex = index;
//     });
//   }

//   void _onPageSelected(int index) {
//     setState(() {
//       _currentPageIndex = index;
//       _pageController.animateToPage(
//         index,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.linear,
//       );
//     });
//   }
// }
