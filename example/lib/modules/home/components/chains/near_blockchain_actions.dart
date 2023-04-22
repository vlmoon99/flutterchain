import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/constants/supported_blockchains.dart';
import 'package:flutterchain_example/modules/home/components/core/crypto_actions_card.dart';
import 'package:flutterchain_example/modules/home/vm/home_vm.dart';
import 'package:flutterchain_example/theme/app_theme.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_response.dart';

class NearBlockchainActions extends StatefulWidget {
  const NearBlockchainActions({super.key});

  @override
  State<NearBlockchainActions> createState() => _NearBlockchainActionsState();
}

class _NearBlockchainActionsState extends State<NearBlockchainActions> {
  final formKey = GlobalKey<FormState>();

  //Transfer Near
  final TextEditingController recipientEditingController =
      TextEditingController();
  final TextEditingController transferDepositController =
      TextEditingController();

  //Smart contract call
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

  //Add key

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

  dynamic resultOfSmartContractCall;
  @override
  void initState() {
    super.initState();
    //Transfer Near
    recipientEditingController.text = "pay4result_business.testnet";
    transferDepositController.text = "1";
    //Smart contract call
    argumentsSmartContractController.text =
        r'{"message": "Hello From FlutterChain"}';
    smartContractAddressController.text = "dev-1679756367837-29230485683009";
    smartContractMethodNameController.text = "set_greeting";
    amountOfDepositOnSmartContractController.text = "0";
    //Add key
    addKeySmartContractAddressController.text =
        'dev-1679756367837-29230485683009';
    addKeyMethodsNamesController.text = 'set_greeting, get_greeting';
    addKeyAllowanceAmountController.text = '1';
    addKeyPassPhraseController.text = '';
    addKeyIndexOfTheDerivationPathController.text = '1';
    addKeyPermissionTypeController.text = 'functionCall';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    final homeVM = Modular.get<HomeVM>();

    return Column(
      children: [
        const NetworkSelector(
          blockchainType: BlockChains.near,
        ),
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
              typeOfBlockchain: BlockChains.near,
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
                    : jsonDecode(argumentsSmartContractController.text);
            final deposit = amountOfDepositOnSmartContractController.text;
            final smartContractAdress = smartContractAddressController.text;
            final methodName = smartContractMethodNameController.text;

            final walletID = homeVM.walletIdStream.value;
            homeVM
                .callSmartContractFunction(
              args: arguments,
              amountOfDeposit: deposit,
              blockchainType: BlockChains.near,
              walletId: walletID,
              smartContractAddress: smartContractAdress,
              method: methodName,
            )
                .then((value) {
              setState(() {
                resultOfSmartContractCall = value.nearSuccessValue;
                log(resultOfSmartContractCall);
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
                  'Result of SM call : ${resultOfSmartContractCall.toString().length > 50 ? "${resultOfSmartContractCall.toString().substring(0, 50)}..." : resultOfSmartContractCall.toString()}',
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
        CryptoActionCard(
          title: 'Add Key',
          height: 700,
          icon: Icons.key_rounded,
          color: nearColors.nearPurple,
          onTap: () {
            final passPhrase = addKeyPassPhraseController.text;
            final indexOfDerivationPath =
                addKeyIndexOfTheDerivationPathController.text;
            final permissionType = addKeyPermissionTypeController.text;
            final walletID = homeVM.walletIdStream.value;
            final methodsNames =
                addKeyMethodsNamesController.text.split(',').toList();
            final allowanceAmount = addKeyAllowanceAmountController.text;
            final smartContractAdress = smartContractAddressController.text;

            homeVM
                .addKeyNearBlockChain(
              blockchainType: BlockChains.near,
              allowance: allowanceAmount,
              indexOfTheDerivationPath: indexOfDerivationPath,
              methodNames: methodsNames,
              permission: permissionType,
              smartContractId: smartContractAdress,
              walletID: walletID,
            )
                .then((value) {
              setState(() {
                resultOfSmartContractCall = value.nearSuccessValue;
                log(resultOfSmartContractCall);
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
                  labelText: 'Derevation index',
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
        ),
      ],
    );
  }
}

class NetworkSelector extends StatefulWidget {
  const NetworkSelector({Key? key, required this.blockchainType})
      : super(key: key);
  final String blockchainType;
  @override
  _NetworkSelectorState createState() => _NetworkSelectorState();
}

class _NetworkSelectorState extends State<NetworkSelector> {
  // String selectedUrl = 'https://rpc.nearprotocol.com';
  String selectedUrl = '';

  final TextEditingController _customUrlController = TextEditingController();

  final Set<String> networkUrls = {
    // 'https://rpc.nearprotocol.com',
    // 'https://rpc.testnet.near.org',
    // 'https://rpc.betanet.near.org',
    // 'https://rpc.mainnet.near.org',
  };

  void _handleCustomUrlChanged(String url) {
    setState(() {
      final homeVM = Modular.get<HomeVM>();
      networkUrls.add(url);
      selectedUrl = url;
      homeVM.cryptoLibary.cryptoService.setBlockchainNetworkEnvironment(
          blockchainType: BlockChains.near, newUrl: selectedUrl);
    });
  }

  @override
  void initState() {
    super.initState();
    final homeVM = Modular.get<HomeVM>();
    final preDefinedUrls = homeVM
        .cryptoLibary.cryptoService.blockchainServices[widget.blockchainType]!
        .getBlockchainsUrlsByBlockchainType();
    networkUrls.addAll(preDefinedUrls);
    selectedUrl = networkUrls.first;
    homeVM.cryptoLibary.cryptoService.setBlockchainNetworkEnvironment(
        blockchainType: BlockChains.near, newUrl: selectedUrl);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    final homeVM = Modular.get<HomeVM>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            'Your Address :${homeVM.cryptoLibary.walletsStream.valueOrNull?[int.tryParse(homeVM.walletIdStream.value) ?? 0].blockchainsData?[widget.blockchainType]?.publicKey}',
            style: nearTextStyles.headline!.copyWith(
              fontWeight: FontWeight.bold,
              color: nearColors.nearBlack,
              fontSize: 20,
            ),
          ),
        ),
        FutureBuilder(
          future: homeVM.getWalletBalanceByPublicKey(
            walletId: homeVM.walletIdStream.value,
            blockchainType: widget.blockchainType,
          ),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Total Amount of ${widget.blockchainType} :${double.parse(snapshot.data.toString()).toStringAsFixed(2)}',
                  style: nearTextStyles.headline!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: nearColors.nearBlack,
                    fontSize: 20,
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        const SizedBox(height: 16),
        Text(
          'Network:',
          style: nearTextStyles.bodyCopy!.copyWith(
            color: nearColors.nearGray,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButton<String>(
          value: selectedUrl,
          onChanged: (String? value) {
            setState(() {
              selectedUrl = value!;
              final homeVM = Modular.get<HomeVM>();
              homeVM.cryptoLibary.cryptoService.setBlockchainNetworkEnvironment(
                  blockchainType: BlockChains.near, newUrl: selectedUrl);
            });
          },
          items: networkUrls
              .map((url) => DropdownMenuItem<String>(
                    value: url,
                    child: Text(
                      url,
                      style: nearTextStyles.bodyCopy!.copyWith(
                        color: nearColors.nearGray,
                      ),
                    ),
                  ))
              .toList(),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 150,
          child: TextField(
            controller: _customUrlController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: nearColors.nearGray,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: nearColors.nearPurple,
                  width: 2,
                ),
              ),
              hintText: 'Custom URL',
              contentPadding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 12,
              ),
              hintStyle: nearTextStyles.bodyCopy!.copyWith(
                color: nearColors.nearGray,
              ),
            ),
            style: nearTextStyles.bodyCopy!.copyWith(
              color: nearColors.nearGray,
            ),
            onEditingComplete: () {
              FocusScope.of(context).unfocus();
              _handleCustomUrlChanged(_customUrlController.text);
            },
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
