import 'dart:developer';

import 'package:flutterchain/flutterchain_lib/constants/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/services/crypto_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/modules/auth/pages/login_page.dart';
import 'package:flutterchain_example/modules/home/vm/home_vm.dart';

class CallSmartContractFunction extends StatefulWidget {
  const CallSmartContractFunction({super.key});

  @override
  State<CallSmartContractFunction> createState() =>
      _CallSmartContractFunctionState();
}

class _CallSmartContractFunctionState extends State<CallSmartContractFunction> {
  final TextEditingController smAddress = TextEditingController();
  final TextEditingController argument = TextEditingController();

  @override
  void initState() {
    super.initState();
    smAddress.text = 'dev-1679756367837-29230485683009';
    argument.text = "Flutter app text";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(
              left: 50,
              right: 50,
              bottom: 200,
            ),
            child: Column(
              children: [
                TextField(
                  controller: smAddress,
                  decoration: const InputDecoration(hintText: "SM address"),
                ),
                TextField(
                  controller: argument,
                  decoration: const InputDecoration(hintText: "Argument"),
                ),
              ],
            ),
          ),
          AppButton(
            title: "Call SM function",
            onPress: () async {
              final homeVM = Modular.get<HomeVM>();
              final argumentValue = argument.text;
              final smAdressValue = smAddress.text;

              final resOfTx =
                  await homeVM.cryptoLibary.callSmartContractFunction(
                walletId: homeVM.cryptoLibary.walletsStream.value.first.id,
                method: 'get_greeting',
                args: {},
                typeOfBlockchain: BlockChains.near,
                toAdress: smAddress.text,
                transferAmount: '0',
              );
              log("resOfTx $resOfTx");
            },
          ),
        ],
      ),
    );
  }
}
