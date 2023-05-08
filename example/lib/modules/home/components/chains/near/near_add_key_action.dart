import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain_example/modules/home/components/core/crypto_actions_card.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/ui_state.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/near_vm.dart';
import 'package:flutterchain_example/theme/app_theme.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_response.dart';

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
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    final nearVM = Modular.get<NearVM>();
    final currentState = nearVM.nearState.value as SuccessNearBlockchainState;

    return CryptoActionCard(
      title: 'Add Key',
      height: 700,
      icon: Icons.key_rounded,
      color: nearColors.nearPurple,
      onTap: () {
        // ignore: unused_local_variable
        final passPhrase = addKeyPassPhraseController.text;
        final indexOfDerivationPath =
            addKeyIndexOfTheDerivationPathController.text;
        final permissionType = addKeyPermissionTypeController.text;
        final walletID = nearVM.userStore.walletIdStream.value;
        final methodsNames =
            addKeyMethodsNamesController.text.split(',').toList();
        final allowanceAmount = addKeyAllowanceAmountController.text;
        final smartContractAddress = addKeySmartContractAddressController.text;

        final derivationModel = DerivationPath(
          purpose: '44',
          coinType: '397',
          accountNumber: indexOfDerivationPath,
          change: '0',
          address: '1',
        );

        final currentDerivationPath =
            nearVM.nearBlockchainStore.currentDerivationPath.value;

        nearVM
            .addKeyNearBlockChain(
          allowance: allowanceAmount,
          derivationPathOfNewGeneratedAccount: derivationModel,
          currentDerivationPath: currentDerivationPath,
          methodNames: methodsNames,
          permission: permissionType,
          smartContractId: smartContractAddress,
          walletID: walletID,
        )
            .then((value) {
          nearVM.nearState
              .add(currentState.copyWith(addKeyResult: value.nearSuccessValue));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                value.status == BlockchainResponses.success
                    ? 'Success add key action'
                    : 'Failed add key action',
              ),
            ),
          );
          log("result of Adding Key ${value.nearSuccessValue}");
        });
      },
      child: Column(
        children: [
          const SizedBox(height: 20),
          TextField(
            controller: addKeySmartContractAddressController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Smart contract address',
              labelStyle: nearTextStyles.bodyCopy!.copyWith(
                color: nearColors.nearBlack,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: addKeyMethodsNamesController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Method names',
              labelStyle: nearTextStyles.bodyCopy!.copyWith(
                color: nearColors.nearBlack,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: addKeyIndexOfTheDerivationPathController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Derivation Account index',
              labelStyle: nearTextStyles.bodyCopy!.copyWith(
                color: nearColors.nearBlack,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: addKeyAllowanceAmountController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Amount of Allowance',
              labelStyle: nearTextStyles.bodyCopy!.copyWith(
                color: nearColors.nearBlack,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: addKeyPermissionTypeController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'functionCall | fullAccess',
              labelStyle: nearTextStyles.bodyCopy!.copyWith(
                color: nearColors.nearBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
