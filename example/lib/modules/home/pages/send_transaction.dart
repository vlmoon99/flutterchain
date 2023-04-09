import 'dart:developer';

import 'package:flutterchain/flutterchain_lib/constants/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/services/crypto_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/modules/auth/pages/login_page.dart';
import 'package:flutterchain_example/modules/home/vm/home_vm.dart';

class SendTransactionPage extends StatefulWidget {
  const SendTransactionPage({super.key});

  @override
  State<SendTransactionPage> createState() => _SendTransactionPageState();
}

class _SendTransactionPageState extends State<SendTransactionPage> {
  final TextEditingController toAddressController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    toAddressController.text = "pay4result_business.testnet";
    amountController.text = "1";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeVM = Modular.get<HomeVM>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 40,
                bottom: 40,
                top: 200,
              ),
              child: FutureBuilder<dynamic>(
                future: homeVM.getWalletBalanceByPublicKey(
                  blockchainType: BlockChains.near,
                  walletId: homeVM.cryptoLibary.walletsStream.value.first.id,
                ),
                builder: (context, snapshot) {
                  final balance = snapshot.data;
                  return Text(
                    "Your Balance : ${balance ?? ''}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 40,
                bottom: 40,
              ),
              child: TextField(
                controller: toAddressController,
                decoration:
                    const InputDecoration(hintText: "Send near to address"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 40,
                right: 40,
                bottom: 40,
              ),
              child: TextField(
                controller: amountController,
                decoration: const InputDecoration(hintText: "Amount"),
              ),
            ),
            AppButton(
              title: "Send transaction",
              onPress: () async {
                if (toAddressController.text.isNotEmpty &&
                    amountController.text.isNotEmpty) {
                  final resOfTx =
                      await homeVM.sendNativeCoinTransferByWalletName(
                    toAdress: toAddressController.text,
                    transferAmount: amountController.text,
                    typeOfBlockchain: BlockChains.near,
                    walletId: homeVM.cryptoLibary.walletsStream.value.first.id,
                  );
                  log("resOfTx $resOfTx");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Your address or amount is incorrect"),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
