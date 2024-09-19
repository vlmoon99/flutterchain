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

class ConcordiumDelegationTx extends StatefulWidget {
  const ConcordiumDelegationTx({super.key});

  @override
  State<ConcordiumDelegationTx> createState() => _ConcordiumDelegationTxState();
}

class _ConcordiumDelegationTxState extends State<ConcordiumDelegationTx> {
  bool sendTransaction = false;

  final TextEditingController amountEditingController = TextEditingController();
  bool restakeEarnings = true;
  String delegationType = ConcordiumDelegationType.passive;
  final TextEditingController bakerIdEditingController =
      TextEditingController();
  String txHash = '';

  bool updateRestakeEarnings = true;
  bool updateDelegationType = true;
  bool updateAmount = true;

  @override
  Widget build(BuildContext context) {
    final ConcordiumBlockChainService concordiumBlockChainService =
        Modular.get<ConcordiumBlockChainService>();
    final ConcordiumVm concordiumVm = Modular.get<ConcordiumVm>();
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    return CryptoActionCard(
      title: 'Delegation Transaction',
      icon: Icons.arrow_forward,
      color: nearColors.nearGreen,
      height: 600.h,
      onTap: () async {
        try {
          if (delegationType == ConcordiumDelegationType.baker &&
              bakerIdEditingController.text.isEmpty) {
            return;
          }
          setState(() {
            sendTransaction = true;
          });
          final chosenBlockchain =
              concordiumVm.state.blockchainsData.firstWhere(
            (element) =>
                (element.derivationPath as ConcordiumDerivationPath)
                    .credentialIndex ==
                concordiumVm.state.currentBlockchainIndex,
          );
          if (delegationType == ConcordiumDelegationType.passive) {
            final res =
                await concordiumBlockChainService.sendDelegationTransaction(
              senderAddress: chosenBlockchain.accountAddress,
              privateKey: chosenBlockchain.privateKey,
              restakeEarnings: updateRestakeEarnings ? restakeEarnings : null,
              amountInMicroCcd: updateAmount
                  ? ConcordiumFormatter.convertCcdToMicroCcd(
                      int.parse(amountEditingController.text))
                  : null,
              delegationType: updateDelegationType
                  ? ConcordiumDelegationType.passive
                  : null,
            );
            setState(() {
              txHash = res.data['txHash'];
            });
          } else {
            final res =
                await concordiumBlockChainService.sendDelegationTransaction(
              senderAddress: chosenBlockchain.accountAddress,
              privateKey: chosenBlockchain.privateKey,
              restakeEarnings: updateRestakeEarnings ? restakeEarnings : null,
              amountInMicroCcd: updateAmount
                  ? ConcordiumFormatter.convertCcdToMicroCcd(
                      int.parse(amountEditingController.text))
                  : null,
              delegationType:
                  updateDelegationType ? ConcordiumDelegationType.baker : null,
              bakerId:
                  updateDelegationType ? bakerIdEditingController.text : null,
            );
            setState(() {
              txHash = res.data['txHash'];
            });
          }
        } finally {
          setState(() {
            sendTransaction = false;
          });
        }
      },
      child: SingleChildScrollView(
        child: Column(
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
                  const Text("Delegation type: "),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: delegationType,
                    items: [
                      ConcordiumDelegationType.passive,
                      ConcordiumDelegationType.baker
                    ]
                        .map((val) => DropdownMenuItem<String>(
                            value: val, child: Text(val)))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        delegationType = value!;
                      });
                    },
                  ),
                ],
              ),
              if (delegationType == ConcordiumDelegationType.baker) ...[
                const SizedBox(height: 20),
                NearActionTextField(
                  labelText: 'Baker ID',
                  textEditingController: bakerIdEditingController,
                ),
              ],
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
                  const Text('Update restake earnings'),
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
                  const Text('Update amount'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                      value: updateDelegationType,
                      onChanged: (value) {
                        setState(() {
                          updateDelegationType = value!;
                        });
                      }),
                  const Text('Update delegation type'),
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
      ),
    );
  }
}
