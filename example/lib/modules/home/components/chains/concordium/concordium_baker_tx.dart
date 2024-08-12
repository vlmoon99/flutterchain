import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterchain/flutterchain_lib/formaters/chains/concordium_formatter.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/concordium_blockchain_service.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/near_action_text_field.dart';
import 'package:flutterchain_example/modules/home/components/core/crypto_actions_card.dart';
import 'package:flutterchain_example/modules/home/vms/chains/concordium_vm.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class ConcordiumBakerTx extends StatefulWidget {
  const ConcordiumBakerTx({super.key});

  @override
  State<ConcordiumBakerTx> createState() => _ConcordiumBakerTxState();
}

class _ConcordiumBakerTxState extends State<ConcordiumBakerTx> {
  bool sendTransaction = false;

  bool restakeEarnings = true;
  DelegationOpenStatus openStatus = DelegationOpenStatus.OpenForAll;
  final TextEditingController amountEditingController = TextEditingController()
    ..text = ConcordiumFormatter.convertMicroCcdToCcd(14000000000).toString();
  final TextEditingController metadataUrlEditingController =
      TextEditingController()..text = "www.url.for.metadata";
  final TextEditingController
      transactionFeeCommissionInPercentageEditingController =
      TextEditingController()..text = "10";
  final TextEditingController
      bakingRewardCommissionInPercentageEditingController =
      TextEditingController()..text = "10";
  final TextEditingController
      finalizationRewardCommissionInPercentageController =
      TextEditingController()..text = "100";

  String txHash = '';

  bool updateRestakeEarnings = true;
  bool updateAmount = true;
  bool updateMetadataUrl = true;
  bool updateTransactionFeeCommissionInPercentage = true;
  bool updateBakingRewardCommissionInPercentage = true;
  bool updateFinalizationRewardCommissionInPercentage = true;
  bool updateOpenStatus = true;

  @override
  Widget build(BuildContext context) {
    final ConcordiumBlockchainService concordiumBlockchainService =
        Modular.get<ConcordiumBlockchainService>();
    final ConcordiumVm concordiumVm = Modular.get<ConcordiumVm>();
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    return CryptoActionCard(
      title: 'Baker Transaction',
      icon: Icons.arrow_forward,
      color: nearColors.nearGreen,
      height: 1000.h,
      onTap: () async {
        try {
          setState(() {
            sendTransaction = true;
          });

          final choosenBlockchain =
              concordiumVm.state.blockchainsData.firstWhere(
            (element) =>
                element.derivationPath.credentialIndex ==
                concordiumVm.state.currentBlockchainIndex,
          );

          final res = await concordiumBlockchainService.sendBakerTransaction(
            senderAddress: choosenBlockchain.accountAddress,
            signingKey: choosenBlockchain.signingKey,
            restakeEarnings: updateRestakeEarnings ? restakeEarnings : null,
            stakeAmountInMicroCcd: updateAmount
                ? ConcordiumFormatter.convertCcdToMicroCcd(
                    int.parse(amountEditingController.text))
                : null,
            metadataUrl:
                updateMetadataUrl ? metadataUrlEditingController.text : null,
            transactionFeeCommissionInPercentage:
                updateTransactionFeeCommissionInPercentage
                    ? double.parse(
                        transactionFeeCommissionInPercentageEditingController
                            .text)
                    : null,
            bakingRewardCommissionInPercentage:
                updateBakingRewardCommissionInPercentage
                    ? double.parse(
                        bakingRewardCommissionInPercentageEditingController
                            .text)
                    : null,
            finalizationRewardCommissionInPercentage:
                updateFinalizationRewardCommissionInPercentage
                    ? double.parse(
                        finalizationRewardCommissionInPercentageController.text)
                    : null,
            openStatus: updateOpenStatus ? openStatus : null,
          );

          setState(() {
            txHash = res.data['txHash'];
          });
        } finally {
          setState(() {
            sendTransaction = false;
          });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!sendTransaction) ...[
            const SizedBox(height: 20),
            NearActionTextField(
              labelText: 'Amount',
              textEditingController: amountEditingController,
            ),
            const SizedBox(height: 20),
            // restakeEarnings
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Restake earnings: '),
                const SizedBox(width: 10),
                DropdownButton<bool>(
                  value: restakeEarnings,
                  items: [true, false]
                      .map((val) => DropdownMenuItem<bool>(
                          value: val, child: Text('$val')))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      restakeEarnings = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text("Delegation OpenStatus: "),
                const SizedBox(width: 10),
                DropdownButton<DelegationOpenStatus>(
                  value: openStatus,
                  items: DelegationOpenStatus.values
                      .map((val) => DropdownMenuItem<DelegationOpenStatus>(
                          value: val, child: Text(val.name)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      openStatus = value!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            NearActionTextField(
              labelText: 'Metadata Url',
              textEditingController: metadataUrlEditingController,
            ),
            const SizedBox(height: 20),
            NearActionTextField(
              labelText: 'Transaction Fee Commission In Percentage',
              textEditingController:
                  transactionFeeCommissionInPercentageEditingController,
            ),
            const SizedBox(height: 20),
            NearActionTextField(
              labelText: 'Baking Reward Commission In Percentage',
              textEditingController:
                  bakingRewardCommissionInPercentageEditingController,
            ),
            const SizedBox(height: 20),
            NearActionTextField(
              labelText: 'Finalization Reward Commission In Percentage',
              textEditingController:
                  finalizationRewardCommissionInPercentageController,
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Checkbox(
                    value: updateRestakeEarnings,
                    onChanged: (value) {
                      setState(() {
                        updateRestakeEarnings = value!;
                      });
                    }),
                const Expanded(child: Text('Update restake earnings')),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: updateAmount,
                    onChanged: (value) {
                      setState(() {
                        updateAmount = value!;
                      });
                    }),
                const Expanded(child: Text('Update amount')),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: updateOpenStatus,
                    onChanged: (value) {
                      setState(() {
                        updateOpenStatus = value!;
                      });
                    }),
                const Expanded(child: Text('Update Delegation OpenStatus')),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: updateMetadataUrl,
                    onChanged: (value) {
                      setState(() {
                        updateMetadataUrl = value!;
                      });
                    }),
                const Expanded(child: Text('Update Metadata Url')),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: updateTransactionFeeCommissionInPercentage,
                    onChanged: (value) {
                      setState(() {
                        updateTransactionFeeCommissionInPercentage = value!;
                      });
                    }),
                const Expanded(
                    child: Text('Update Transaction Fee Commission')),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: updateFinalizationRewardCommissionInPercentage,
                    onChanged: (value) {
                      setState(() {
                        updateFinalizationRewardCommissionInPercentage = value!;
                      });
                    }),
                const Expanded(
                    child: Text('Update Finalization Reward Commission')),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    value: updateBakingRewardCommissionInPercentage,
                    onChanged: (value) {
                      setState(() {
                        updateBakingRewardCommissionInPercentage = value!;
                      });
                    }),
                const Expanded(child: Text('Update Baking Reward Commission')),
              ],
            ),
          ] else ...[
            const Center(child: CircularProgressIndicator())
          ],
          if (txHash.isNotEmpty) ...[
            const SizedBox(height: 20),
            SelectableText("Transaction Hash: $txHash"),
          ],
        ],
      ),
    );
  }
}
