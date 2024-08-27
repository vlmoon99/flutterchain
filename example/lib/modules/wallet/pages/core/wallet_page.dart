import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/theme/app_theme.dart';
import 'package:flutterchain_example/assets/images/icons.dart';

//this is a action buttons
Widget _buildButton(BuildContext context, AppIcon icon, String label) {
  final theme = Modular.get<AppTheme>();
  final nearColors = theme.getTheme().extension<NearColors>()!;
  final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(16),
        child: icon,
      ),
      SizedBox(height: 8),
      Text(label,
          style: nearTextStyles.label!.copyWith(color: nearColors.nearBlack)),
    ],
  );
}

Widget _buildTokensAndNfts() {
  final theme = Modular.get<AppTheme>();
  final nearColors = theme.getTheme().extension<NearColors>()!;
  final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;

  List<Map<dynamic, dynamic>> tokens = [
    {
      'icon': const AppIcon(
        iconType: IconType.nearIcon,
        size: 40,
      ),
      'name': "NEAR",
      'price': '\$6.34',
      'amount': '198.24 NEAR',
      'change': '^ 2.6%',
      'total price': '\$1251.44'
    },
    {
      'icon': const AppIcon(
        iconType: IconType.octopusIcon,
        size: 40,
      ),
      'name': "Octopus Network",
      'price': '\$0.34',
      'amount': '0.6317 OCT',
      'change': '^ 3.6%',
      'total price': '\$0.70'
    },
    {
      'icon': const AppIcon(
        iconType: IconType.deipIcon,
        size: 40,
      ),
      'name': "DEIP Token",
      'price': '\$0.34',
      'amount': '555.94874 DEIP',
      'change': '⌄  0,97%',
      'total price': '\$0.76'
    },
    {
      'icon': const AppIcon(
        iconType: IconType.auroraIcon,
        size: 40,
      ),
      'name': "Aurora",
      'price': '\$6.34',
      'amount': '300 Aurora',
      'change': '^ 2.6%',
      'total price': '\$1137'
    },
    {
      'icon': const AppIcon(
        iconType: IconType.usnIcon,
        size: 40,
      ),
      'name': "USN",
      'price': '\$1.33',
      'amount': '205 USN',
      'change': '^ 38.76%',
      'total price': '\$276.65'
    }
  ];

  return ListView.builder(
    itemCount: tokens.length,
    itemBuilder: (context, index) {
      final token = tokens[index];
      return ListTile(
        leading: token['icon'] as Widget,
        title: Text(
          token['name']!,
          style: nearTextStyles.highlight!.copyWith(
              color: nearColors.nearBlack, fontWeight: FontWeight.w700),
        ),
        subtitle: Row(
          children: [
            Text(
              token['price']!,
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              token['change']!,
              style: TextStyle(
                  color: token['change']!.contains('⌄ ')
                      ? Colors.red
                      : Colors.green),
            ),
          ],
        ),
        trailing: Column(
          children: [
            Text(token['amount']!,
                style: nearTextStyles.label!.copyWith(
                    color: nearColors.nearBlack,
                    fontWeight: FontWeight.w700,
                    fontSize: 16)),
            Text(token['total price']!,
                style: nearTextStyles.label!
                    .copyWith(color: nearColors.nearGray, fontSize: 12)),
          ],
        ),
      );
    },
  );
}

//this is a Wallet page,it's main page of UI.
class WalletPageTab extends StatelessWidget {
  const WalletPageTab({super.key});

  get height => null;

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;

    return Scaffold(
      backgroundColor: nearColors.nearWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //this is TopBar
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AppIcon(
                      iconType: IconType.settingsIcon,
                      size: 24,
                    ),
                    Text('Wallet',
                        style: nearTextStyles.label!.copyWith(
                            fontWeight: FontWeight.w700, fontSize: 25)),
                    const AppIcon(
                      iconType: IconType.scanIcon,
                      size: 30,
                    )
                  ],
                ),
              ),
              // this is Balance
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Text('Total balance',
                    style: nearTextStyles.label!
                        .copyWith(color: nearColors.nearGray, fontSize: 16)),
              ),
              const SizedBox(
                width: 10,
              ),
              Center(
                child: Text('\$2.663.56',
                    style: nearTextStyles.bodyCopy!.copyWith(
                        color: nearColors.nearBlack,
                        fontSize: 32,
                        fontWeight: FontWeight.w700)),
              ),
              const SizedBox(
                width: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton(
                      context,
                      const AppIcon(
                        iconType: IconType.send,
                        size: 56,
                      ),
                      'Send'),
                  _buildButton(
                      context,
                      const AppIcon(
                        iconType: IconType.receive,
                        size: 56,
                      ),
                      'Receive'),
                  _buildButton(context,
                      const AppIcon(iconType: IconType.buy, size: 56), 'Buy'),
                  _buildButton(
                      context,
                      const AppIcon(
                        iconType: IconType.swap,
                        size: 56,
                      ),
                      'Swap'),
                ],
              ),
              SizedBox(height: 30),
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      width: 327,
                      height: 56,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color.fromARGB(255, 241, 240, 240)),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorPadding: const EdgeInsets.all(4.5),
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
                      height: 400,
                      child: TabBarView(
                        children: [
                          _buildTokensAndNfts(),
                          const Center(
                            child: Text(
                              'this is nft tab',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
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
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;

    return Scaffold(
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
                  icon: AppIcon(iconType: IconType.wallet), label: 'wallet'),
              BottomNavigationBarItem(
                  icon: AppIcon(iconType: IconType.stackingIcon),
                  label: 'stacking'),
              BottomNavigationBarItem(icon: Icon(Icons.man), label: 'profile'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.history), label: 'histroy'),
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
