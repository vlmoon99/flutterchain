import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/modules/home/vm/home_vm.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class CryptoActionsPage extends StatelessWidget {
  const CryptoActionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    final homeVM = Modular.get<HomeVM>();

    final blockchainKey = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: nearColors.nearPurple,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Modular.to.pop();
          },
        ),
        title: Text(
          'Crypto Actions on $blockchainKey',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 1,
              children: [
                CryptoActionCard(
                  title: 'Transfer',
                  icon: Icons.send,
                  color: nearColors.nearGreen,
                  onTap: () {},
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      FutureBuilder(
                        future: homeVM.getWalletBalanceByPublicKey(
                          walletId: homeVM.walletIdStream.value,
                          blockchainType: blockchainKey,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              'Total Amount of $blockchainKey :${snapshot.data}',
                              style: nearTextStyles.headline!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: nearColors.nearBlack,
                                fontSize: 15,
                              ),
                            );
                          } else {
                            return Expanded(child: const Placeholder());
                          }
                        },
                        // child: Text(
                        //   'Total Amount: \$" Not ${} yet"',
                        //   style: nearTextStyles.headline!.copyWith(
                        //     fontWeight: FontWeight.bold,
                        //     color: nearColors.nearBlack,
                        //     fontSize: 15,
                        //   ),
                        // ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Recipient',
                          labelStyle: nearTextStyles.bodyCopy!.copyWith(
                            color: nearColors.nearBlack,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Amount',
                          labelStyle: nearTextStyles.bodyCopy!.copyWith(
                            color: nearColors.nearBlack,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
                CryptoActionCard(
                  title: 'Smart Contract Call',
                  icon: Icons.functions_rounded,
                  color: nearColors.nearPurple,
                  onTap: () {},
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Arguments , separeted by comma',
                          labelStyle: nearTextStyles.bodyCopy!.copyWith(
                            color: nearColors.nearBlack,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Amount of Deposite',
                          labelStyle: nearTextStyles.bodyCopy!.copyWith(
                            color: nearColors.nearBlack,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: 'Smart contract address',
                          labelStyle: nearTextStyles.bodyCopy!.copyWith(
                            color: nearColors.nearBlack,
                          ),
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
    );
  }
}

class CryptoActionCard extends StatelessWidget {
  const CryptoActionCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
    required this.child,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final nearColors =
        Modular.get<AppTheme>().getTheme().extension<NearColors>()!;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 6,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: nearColors.nearBlack,
                    size: 28,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: nearColors.nearBlack,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(child: child),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  primary: color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Execute',
                    style: Theme.of(context).textTheme.button!.copyWith(
                          color: nearColors.nearWhite,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
