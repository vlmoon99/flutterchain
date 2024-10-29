import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/blockchain_response.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/near_action_text_field.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/see_tx_in_explorer.dart';
import 'package:flutterchain_example/modules/home/components/core/crypto_actions_card.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/ui_state.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/near_vm.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class NearAddKeyAction extends StatefulWidget {
  const NearAddKeyAction({super.key});

  @override
  State<NearAddKeyAction> createState() => _NearAddKeyActionState();
}

class _NearAddKeyActionState extends State<NearAddKeyAction> {
  final TextEditingController addKeySmartContractAddressController =
      TextEditingController();
  final TextEditingController addKeyMethodsNamesController =
      TextEditingController();
  final TextEditingController addKeyAllowanceAmountController =
      TextEditingController();
  final TextEditingController addKeyPassPhraseController =
      TextEditingController();
  final TextEditingController addKeyIndexOfTheDerivationPathController =
      TextEditingController();
  final TextEditingController addKeyPermissionTypeController =
      TextEditingController();

  dynamic txHash;

  @override
  void initState() {
    super.initState();
    addKeySmartContractAddressController.text =
        'dev-1679756367837-29230485683009';
    addKeyMethodsNamesController.text = 'set_greeting, get_greeting';
    addKeyAllowanceAmountController.text = '1';
    addKeyPassPhraseController.text = '';
    addKeyIndexOfTheDerivationPathController.text = '0';
    addKeyPermissionTypeController.text = 'functionCall';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearVM = Modular.get<NearVM>();
    final currentState = nearVM.nearState.value as SuccessNearBlockchainState;
    final height = MediaQuery.of(context).size.height;

    return CryptoActionCard(
      title: 'Add Key',
      height: height * 0.70,
      icon: Icons.key_rounded,
      color: nearColors.nearPurple,
      onTap: () {
        // ignore: unused_local_variable
        final passPhrase = addKeyPassPhraseController.text;
        final permissionType = addKeyPermissionTypeController.text;
        final walletID = nearVM.userStore.walletIdStream.value;
        final methodsNames =
            addKeyMethodsNamesController.text.split(',').toList();
        final allowanceAmount = addKeyAllowanceAmountController.text;
        final smartContractAddress = addKeySmartContractAddressController.text;

        final currentDerivationPath =
            nearVM.nearBlockchainStore.currentDerivationPath.value;

        nearVM
            .addKeyNearBlockChain(
          allowance: allowanceAmount,
          currentDerivationPath: currentDerivationPath,
          methodNames: methodsNames,
          permission: permissionType,
          smartContractId: smartContractAddress,
          walletID: walletID,
        )
            .then((value) {
          nearVM.nearState.add(currentState.copyWith(addKeyResult: value.data));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                value.status == BlockchainResponses.success
                    ? 'Success add key action'
                    : 'Failed add key action',
              ),
            ),
          );
          log("result of Adding Key ${value.data['response']}");
        });
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
          ),
          const SizedBox(height: 20),
          NearActionTextField(
            labelText: 'Method names',
            textEditingController: addKeyMethodsNamesController,
          ),
          const SizedBox(height: 20),
          NearActionTextField(
            labelText: 'Derivation Account index',
            textEditingController: addKeyIndexOfTheDerivationPathController,
          ),
          const SizedBox(height: 20),
          NearActionTextField(
            labelText: 'Amount of Allowance',
            textEditingController: addKeyAllowanceAmountController,
          ),
          const SizedBox(height: 20),
          NearActionTextField(
            labelText: 'functionCall | fullAccess',
            textEditingController: addKeyPermissionTypeController,
          ),
          const SizedBox(height: 20),
          SeeTransactionInfoNearBlockchain(
            tx: currentState.addKeyResult?['txHash'].toString(),
          ),
        ],
      ),
    );
  }
}
