import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/blockchain_response.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/near_action_text_field.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/see_tx_in_explorer.dart';
import 'package:flutterchain_example/modules/home/components/core/crypto_actions_card.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/ui_state.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/near_vm.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

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
    smartContractAddressController.text = "dev-1687089474176-80791139926242";
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
    final result = (currentState.resultOfSmartContractCall?['success']
                    .toString()
                    .length ??
                0) >
            50
        ? "${currentState.resultOfSmartContractCall?['success'].toString().substring(0, 50)}..."
        : currentState.resultOfSmartContractCall?['success'].toString();
    final error =
        currentState.resultOfSmartContractCall?['error'] ?? 'No error';
    return CryptoActionCard(
      title: 'Smart Contract Call',
      height: 700,
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
              resultOfSmartContractCall: value.data,
            ),
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
          log('resultOfSmartContractCall ${value.data.toString()}');
        });
      },
      child: Column(
        children: [
          const SizedBox(height: 20),
          NearActionTextField(
            labelText: 'Smart contract address',
            textEditingController: smartContractAddressController,
          ),
          const SizedBox(height: 20),
          NearActionTextField(
            labelText: 'Method name',
            textEditingController: smartContractMethodNameController,
          ),
          const SizedBox(height: 20),
          NearActionTextField(
            labelText: '{"key(argument name)":"value"}',
            textEditingController: argumentsSmartContractController,
          ),
          const SizedBox(height: 20),
          NearActionTextField(
            labelText: 'Amount of Deposit',
            textEditingController: amountOfDepositOnSmartContractController,
          ),
          const SizedBox(height: 20),
          // SeeTheLastTxNearBlockchainComponent(tx: '',),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText(
                  'Result: ${result == 'null' ? error : result}',
                  style: nearTextStyles.headline!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: nearColors.nearBlack,
                    fontSize: 13.sp,
                  ),
                ),
                const SizedBox(height: 20),
                SeeTransactionInfoNearBlockchain(
                  tx: currentState.resultOfSmartContractCall?['txHash']
                      .toString(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
