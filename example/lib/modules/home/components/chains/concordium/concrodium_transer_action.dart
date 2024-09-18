import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterchain/flutterchain_lib/formaters/chains/concordium_formatter.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_derivation_path.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/concordium_blockchain_service.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/near_action_text_field.dart';
import 'package:flutterchain_example/modules/home/components/core/crypto_actions_card.dart';
import 'package:flutterchain_example/modules/home/vms/chains/concordium_vm.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class ConcrodiumTransferAction extends StatefulWidget {
  const ConcrodiumTransferAction({super.key});

  @override
  State<ConcrodiumTransferAction> createState() =>
      _ConcrodiumTransferActionState();
}

class _ConcrodiumTransferActionState extends State<ConcrodiumTransferAction> {
  final TextEditingController recipientEditingController =
      TextEditingController();

  final TextEditingController transferDepositController =
      TextEditingController();

  String txHash = '';
  bool sendTransaction = false;

  @override
  Widget build(BuildContext context) {
    final ConcordiumBlockchainService concordiumBlockchainService =
        Modular.get<ConcordiumBlockchainService>();
    final ConcordiumVm concordiumVm = Modular.get<ConcordiumVm>();
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    return StreamBuilder(
      stream: concordiumVm.stream,
      builder: (context, snapshot) {
        return CryptoActionCard(
          title: 'Transfer',
          icon: Icons.arrow_forward,
          color: nearColors.nearGreen,
          height: 330.h,
          onTap: () async {
            try {
              setState(() {
                sendTransaction = true;
              });

              final choosenBlockchain =
                  concordiumVm.state.blockchainsData.firstWhere(
                (element) =>
                    (element.derivationPath as ConcordiumDerivationPath)
                        .credentialIndex ==
                    concordiumVm.state.currentBlockchainIndex,
              );

              final recipient = recipientEditingController.text;
              final amount = transferDepositController.text;
              if (recipient.isEmpty || amount.isEmpty) {
                return;
              }
              final txResult =
                  await concordiumBlockchainService.sendTransferTransaction(
                senderAddress: choosenBlockchain.accountAddress,
                toAddress: recipient,
                transferAmountInMicroCcd:
                    ConcordiumFormatter.convertCcdToMicroCcd(int.parse(amount)),
                privateKey: choosenBlockchain.privateKey,
              );

              setState(() {
                txHash = txResult.data['txHash'];
              });
            } finally {
              sendTransaction = false;
            }
          },
          child: SingleChildScrollView(
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
                if (sendTransaction) const CircularProgressIndicator(),
                if (txHash.isNotEmpty) SelectableText("txHash: $txHash"),
              ],
            ),
          ),
        );
      },
    );
  }
}
