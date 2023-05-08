import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/blockchain_response.dart';
import 'package:flutterchain_example/modules/home/components/core/crypto_actions_card.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/ui_state.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/near_vm.dart';
import 'package:flutterchain_example/theme/app_theme.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_response.dart';

class NearSmartContractCall extends StatefulWidget {
  const NearSmartContractCall({super.key});

  @override
  State<NearSmartContractCall> createState() => _NearSmartContractCallState();
}

class _NearSmartContractCallState extends State<NearSmartContractCall> {
  final TextEditingController argumentsSmartContractController =
      TextEditingController();
  final TextEditingController amountOfDepositOnSmartContractController =
      TextEditingController();
  final TextEditingController smartContractAddressController =
      TextEditingController();
  final TextEditingController smartContractMethodNameController =
      TextEditingController();
  @override
  void initState() {
    super.initState();
    //Smart contract call
    argumentsSmartContractController.text =
        r'{"message": "Hello From FlutterChain"}';
    smartContractAddressController.text = "dev-1679756367837-29230485683009";
    smartContractMethodNameController.text = "set_greeting";
    amountOfDepositOnSmartContractController.text = "0";
    // argumentsSmartContractController.text =
    //     r'{"new_account_id": "flutterchain.testnet","new_public_key": "ed25519:BXMGyxk2QkrqRb4vxZqaxBNbDEtMZ7p6Y1gChkR9nHyf"}';
    // smartContractAddressController.text = "testnet";
    // smartContractMethodNameController.text = "create_account";
    // amountOfDepositOnSmartContractController.text = '0.00182';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    final nearVM = Modular.get<NearVM>();
    final currentState = nearVM.nearState.value as SuccessNearBlockchainState;
    return CryptoActionCard(
      title: 'Smart Contract Call',
      height: 600,
      icon: Icons.functions_rounded,
      color: nearColors.nearPurple,
      onTap: () {
        final Map<String, dynamic> arguments =
            argumentsSmartContractController.text.isEmpty
                ? {}
                : jsonDecode(argumentsSmartContractController.text);
        final deposit = amountOfDepositOnSmartContractController.text;
        final smartContractAddress = smartContractAddressController.text;
        final methodName = smartContractMethodNameController.text;
        final derivationPath =
            nearVM.nearBlockchainStore.currentDerivationPath.value;

        final walletID = nearVM.userStore.walletIdStream.value;
        nearVM
            .callSmartContractFunction(
          currentDerivationPath: derivationPath,
          args: arguments,
          amountOfDeposit: deposit,
          walletId: walletID,
          smartContractAddress: smartContractAddress,
          method: methodName,
        )
            .then((value) {
          nearVM.nearState.add(
            currentState.copyWith(
                resultOfSmartContractCall: value.nearSuccessValue),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                value.status == BlockchainResponses.success
                    ? 'Success smart contract call'
                    : 'Failed smart contract call',
              ),
            ),
          );
          log('resultOfSmartContractCall ${value.nearSuccessValue}');
        });
      },
      child: Column(
        children: [
          const SizedBox(height: 20),
          TextField(
            controller: smartContractAddressController,
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
            controller: smartContractMethodNameController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Method name',
              labelStyle: nearTextStyles.bodyCopy!.copyWith(
                color: nearColors.nearBlack,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: argumentsSmartContractController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: '{"key(argument name)":"value"}',
              labelStyle: nearTextStyles.bodyCopy!.copyWith(
                color: nearColors.nearBlack,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: amountOfDepositOnSmartContractController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Amount of Deposit',
              labelStyle: nearTextStyles.bodyCopy!.copyWith(
                color: nearColors.nearBlack,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SelectableText(
              'Result of SM call : ${currentState.resultOfSmartContractCall.toString().length > 50 ? "${currentState.resultOfSmartContractCall.toString().substring(0, 50)}..." : currentState.resultOfSmartContractCall.toString()}',
              style: nearTextStyles.headline!.copyWith(
                fontWeight: FontWeight.bold,
                color: nearColors.nearBlack,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
