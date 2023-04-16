import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/constants/supported_blockchains.dart';
import 'package:flutterchain_example/modules/home/components/chains/near_blockchain_actions.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class CryptoActionsPage extends StatelessWidget {
  const CryptoActionsPage({Key? key}) : super(key: key);

  Widget getBlockchainActions(String blockchainKey) {
    if (blockchainKey == BlockChains.near) {
      return const NearBlockchainActions();
    }
    return const NearBlockchainActions();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;

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
          style: nearTextStyles.headline!.copyWith(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: getBlockchainActions(blockchainKey),
            ),
          ),
        ],
      ),
    );
  }
}
