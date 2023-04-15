import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/constants/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/formaters/near_formater.dart';
import 'package:flutterchain_example/modules/home/vm/home_vm.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class CryptoActionsPage extends StatefulWidget {
  const CryptoActionsPage({Key? key}) : super(key: key);

  @override
  State<CryptoActionsPage> createState() => _CryptoActionsPageState();
}

class _CryptoActionsPageState extends State<CryptoActionsPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController recipientEditingController =
      TextEditingController();
  final TextEditingController transferDepositController =
      TextEditingController();

  final TextEditingController argumentsSmartContractController =
      TextEditingController();
  final TextEditingController amountOfDepositController =
      TextEditingController();
  final TextEditingController amountOfDepositOnSmartContractController =
      TextEditingController();
  final TextEditingController smartContractAddressController =
      TextEditingController();
  final TextEditingController smartContractMethodNameController =
      TextEditingController();

  dynamic resultOfSmartContractCall;
  @override
  void initState() {
    super.initState();
    recipientEditingController.text = "pay4result_business.testnet";
    transferDepositController.text = "1";
    argumentsSmartContractController.text =
        r'{"message": "Hello From FlutterChain"}';
    smartContractAddressController.text = "dev-1679756367837-29230485683009";
    smartContractMethodNameController.text = "set_greeting";
    amountOfDepositOnSmartContractController.text = "0";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    final homeVM = Modular.get<HomeVM>();

    final blockchainKey = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: nearColors.nearPurple,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Modular.to.pop();
          },
        ),
        title: Text(
          'Crypto Actions on $blockchainKey',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Colors.white,
              ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          FutureBuilder(
            future: homeVM.getWalletBalanceByPublicKey(
              walletId: homeVM.walletIdStream.value,
              blockchainType: blockchainKey,
            ),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    'Total Amount of $blockchainKey :${snapshot.data}',
                    style: nearTextStyles.headline!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: nearColors.nearBlack,
                      fontSize: 20,
                    ),
                  ),
                );
              } else {
                return const Expanded(child: Placeholder());
              }
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CryptoActionCard(
                    title: 'Transfer',
                    height: 350,
                    icon: Icons.send,
                    color: nearColors.nearGreen,
                    onTap: () {
                      final recipient = recipientEditingController.text;
                      final amount = transferDepositController.text;
                      final walletID = homeVM.walletIdStream.value;
                      homeVM
                          .sendNativeCoinTransferByWalletId(
                        toAdress: recipient,
                        transferAmount: amount,
                        walletId: walletID,
                        typeOfBlockchain: blockchainKey,
                      )
                          .then(
                        (value) {
                          setState(() {
                            log("Result of transfer $value");
                          });
                        },
                      );
                    },
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: recipientEditingController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Recipient',
                              labelStyle: nearTextStyles.bodyCopy!.copyWith(
                                color: nearColors.nearBlack,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: transferDepositController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Amount',
                              labelStyle: nearTextStyles.bodyCopy!.copyWith(
                                color: nearColors.nearBlack,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  CryptoActionCard(
                    title: 'Smart Contract Call',
                    height: 600,
                    icon: Icons.functions_rounded,
                    color: nearColors.nearPurple,
                    onTap: () {
                      final Map<String, dynamic> arguments =
                          argumentsSmartContractController.text.isEmpty
                              ? {}
                              : jsonDecode(
                                  argumentsSmartContractController.text);
                      final deposit =
                          amountOfDepositOnSmartContractController.text;
                      final smartContractAdress =
                          smartContractAddressController.text;
                      final methodName = smartContractMethodNameController.text;

                      final walletID = homeVM.walletIdStream.value;
                      homeVM
                          .callSmartContractFunction(
                        args: arguments,
                        amountOfDeposit: deposit,
                        blockchainType: blockchainKey,
                        walletId: walletID,
                        smartContractAddress: smartContractAdress,
                        method: methodName,
                      )
                          .then((value) {
                        setState(() {
                          final String successValue =
                              value['result']['status']['SuccessValue'];
                          final String decodedString =
                              NearFormatter.decodeResultOfResponse(
                                  successValue);
                          resultOfSmartContractCall = decodedString;
                          log(value.toString());
                        });
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
                          child: Text(
                            'Result of SM call : ${resultOfSmartContractCall.toString()}',
                            style: nearTextStyles.headline!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: nearColors.nearBlack,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CryptoActionCard extends StatelessWidget {
  const CryptoActionCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
    required this.child,
    required this.height,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final Widget child;
  final double height;
  @override
  Widget build(BuildContext context) {
    final nearColors =
        Modular.get<AppTheme>().getTheme().extension<NearColors>()!;

    return Card(
      elevation: 6,
      child: Container(
        height: height,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: nearColors.nearBlack,
                  size: 28,
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: nearColors.nearBlack,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(child: child),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                primary: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Execute',
                  style: Theme.of(context).textTheme.button!.copyWith(
                        color: nearColors.nearWhite,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
