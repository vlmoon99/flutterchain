import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/near_action_text_field.dart';
import 'package:flutterchain_example/modules/home/components/core/crypto_actions_card.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/near_vm.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/ui_state.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class NearTransferAction extends StatefulWidget {
  const NearTransferAction({super.key});

  @override
  State<NearTransferAction> createState() => _NearTransferActionState();
}

class _NearTransferActionState extends State<NearTransferAction> {
  final TextEditingController recipientEditingController =
      TextEditingController();
  final TextEditingController transferDepositController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    recipientEditingController.text = "pay4result_business.testnet";
    transferDepositController.text = "1";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    final nearVM = Modular.get<NearVM>();
    final currentState = nearVM.nearState.value as SuccessNearBlockchainState;
    return CryptoActionCard(
      title: 'Transfer',
      height: 380,
      icon: Icons.send,
      color: nearColors.nearGreen,
      onTap: () {
        final recipient = recipientEditingController.text;
        final amount = transferDepositController.text;
        final walletID = nearVM.userStore.walletIdStream.value;
        final derivationPath =
            nearVM.nearBlockchainStore.currentDerivationPath.value;
        nearVM
            .sendNativeCoinTransferByWalletId(
          currentDerivationPath: derivationPath,
          toAddress: recipient,
          transferAmount: amount,
          walletId: walletID,
          typeOfBlockchain: BlockChains.near,
        )
            .then(
          (value) {
            nearVM.nearState.add(
              currentState.copyWith(transferResult: value),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  value.status == BlockchainResponses.success
                      ? 'Success transfer'
                      : 'Failed transfer',
                ),
              ),
            );
            log("Result of transfer $value");
          },
        );
      },
      child: Form(
        child: Column(
          children: [
            const SizedBox(height: 20),
            NearActionTextField(
              labelText: 'Recipient',
              textEditingController: recipientEditingController,
            ),
            const SizedBox(height: 20),
            NearActionTextField(
              labelText: 'Amount',
              textEditingController: transferDepositController,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
