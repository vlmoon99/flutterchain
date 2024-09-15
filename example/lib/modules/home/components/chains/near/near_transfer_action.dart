import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/blockchain_response.dart';
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
    final nearVM = Modular.get<NearVM>();
    final currentState = nearVM.nearState.value as SuccessNearBlockchainState;
    return CryptoActionCard(
      title: 'Transfer',
      height: 450,
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
          derivationPathData: derivationPath,
          toAddress: recipient,
          transferAmount: amount,
          walletId: walletID,
        )
            .then(
          (value) {
            nearVM.nearState.add(
              currentState.copyWith(transferResult: value.data),
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
            // SeeTransactionInfoNearBlockchain(
            //   tx: currentState.transferResult?['txHash'].toString(),
            // ),
          ],
        ),
      ),
    );
  }
}
