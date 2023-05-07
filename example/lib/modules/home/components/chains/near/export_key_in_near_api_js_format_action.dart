import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:flutterchain_example/modules/home/components/core/crypto_actions_card.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/ui_state.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/near_vm.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class ExportKeyInNearApiJsFormat extends StatefulWidget {
  const ExportKeyInNearApiJsFormat({super.key});

  @override
  State<ExportKeyInNearApiJsFormat> createState() =>
      _ExportKeyInNearApiJsFormatState();
}

class _ExportKeyInNearApiJsFormatState
    extends State<ExportKeyInNearApiJsFormat> {
  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    final nearVM = Modular.get<NearVM>();
    final currentState = nearVM.nearState.value as SuccessNearBlockchainState;
    return CryptoActionCard(
      title: 'Export private key to (near api js format)',
      height: 500,
      icon: Icons.storage,
      color: nearColors.nearGreen,
      onTap: () async {
        final walletID = nearVM.userStore.walletIdStream.value;
        final currentDerivationPath =
            nearVM.nearBlockchainStore.currentDerivationPath.value;
        final currentWallet = nearVM.cryptoLibrary.walletsStream.value
            .firstWhere((element) => element.id == walletID);
        final currentBlockchainData =
            currentWallet.blockchainsData?[BlockChains.near]?.firstWhere(
                (element) => element.derivationPath == currentDerivationPath);
        final secretKey = await NearBlockChainService.defaultInstance()
            .exportPrivateKeyToTheNearApiJsFormat(
          currentBlockchainData: currentBlockchainData,
        );
        nearVM.nearState.add(
          currentState.copyWith(exportSecretKeyToTheNearApiJsFormat: secretKey),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              secretKey.isNotEmpty
                  ? 'Success exporting BlockchainData to the NearAPI-JS format'
                  : 'Failed exporting BlockchainData to the NearAPI-JS format',
            ),
          ),
        );
        log("exportSecretKeyToTheNearApiJsFormat $secretKey");
      },
      child: Column(
        children: [
          Center(
            child: SelectableText(
              'Exported private key in near api js format is -> :\n ${currentState.exportSecretKeyToTheNearApiJsFormat}',
              style: nearTextStyles.bodyCopy!.copyWith(
                  fontWeight: FontWeight.w300,
                  color: nearColors.nearBlack,
                  fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}
