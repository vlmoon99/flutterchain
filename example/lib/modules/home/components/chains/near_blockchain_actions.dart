import 'dart:convert';
import 'dart:developer';
import 'package:collection/collection.dart';

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

  //Delete key
  final TextEditingController deleteKeyPublicKeyAddressController =
      TextEditingController();

  //Stake
  final TextEditingController stakeAmountController = TextEditingController();

  final TextEditingController stakeValidatorAccountIDController =
      TextEditingController();

  //Unstake
  final TextEditingController unstakeAmountController = TextEditingController();

  final TextEditingController unstakeValidatorAccountIDController =
      TextEditingController();

  final TextEditingController createBlockchainDataDerivationPath =
      TextEditingController();

  dynamic resultOfSmartContractCall;
  dynamic blockchainsDataCreatedByDerivationPath;

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
    //47926de662240fd5488434cb7d1c6c8ab5f0c708c6b247b5ccd04baed4475463
    //dev-1679756367837-29230485683009
    addKeySmartContractAddressController.text =
        'dev-1679756367837-29230485683009';
    addKeyMethodsNamesController.text = 'set_greeting, get_greeting';
    addKeyAllowanceAmountController.text = '1';
    addKeyPassPhraseController.text = '';
    addKeyIndexOfTheDerivationPathController.text = '0';
    addKeyPermissionTypeController.text = 'functionCall';

    //Delete key
    deleteKeyPublicKeyAddressController.text =
        "c1cb858d5b6177be0f4847d310eddbb302a06c76dd2f464138ec8761d9fe1c54";

    //Stake
    stakeValidatorAccountIDController.text = 'sevennines-t0.pool.f863973.m0';
    stakeAmountController.text = "1";
    //UnStake
    stakeValidatorAccountIDController.text = 'sevennines-t0.pool.f863973.m0';
    stakeAmountController.text = "1";

    //Create Adress by derivation path
    createBlockchainDataDerivationPath.text = "m/44'/397'/0'/0'/0'";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    final homeVM = Modular.get<HomeVM>();

    return Column(
      children: [
        const CryptoActionHeader(
          blockchainType: BlockChains.near,
        ),
        CryptoActionCard(
          title: 'Create Adress by derivation path',
          height: 350,
          icon: Icons.wallet,
          color: nearColors.nearGreen,
          onTap: () {
            final walletID = homeVM.walletIdStream.value;
            final derivationPath = createBlockchainDataDerivationPath.text;
            homeVM
                .addBlockChainDataByDerivationPath(
              blockchainType: BlockChains.near,
              derivationPath: derivationPath,
              walletID: walletID,
            )
                .then(
              (value) {
                setState(() {
                  blockchainsDataCreatedByDerivationPath =
                      value.toJson().toString();
                  log("Generated blockchainData ${value.toJson()}");
                });
              },
            );
          },
          child: Form(
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: createBlockchainDataDerivationPath,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Derivation Path',
                    labelStyle: nearTextStyles.bodyCopy!.copyWith(
                      color: nearColors.nearBlack,
                    ),
                  ),
                ),
                Text(blockchainsDataCreatedByDerivationPath ?? ''),
              ],
            ),
          ),
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
              toAddress: recipient,
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
            final smartContractAddress = smartContractAddressController.text;
            final methodName = smartContractMethodNameController.text;

            final walletID = homeVM.walletIdStream.value;
            homeVM
                .callSmartContractFunction(
              args: arguments,
              amountOfDeposit: deposit,
              blockchainType: BlockChains.near,
              walletId: walletID,
              smartContractAddress: smartContractAddress,
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
            // ignore: unused_local_variable
            final passPhrase = addKeyPassPhraseController.text;
            final indexOfDerivationPath =
                addKeyIndexOfTheDerivationPathController.text;
            final permissionType = addKeyPermissionTypeController.text;
            final walletID = homeVM.walletIdStream.value;
            final methodsNames =
                addKeyMethodsNamesController.text.split(',').toList();
            final allowanceAmount = addKeyAllowanceAmountController.text;
            final smartContractAddress =
                addKeySmartContractAddressController.text;

            homeVM
                .addKeyNearBlockChain(
              blockchainType: BlockChains.near,
              allowance: allowanceAmount,
              indexOfTheDerivationPath: indexOfDerivationPath,
              methodNames: methodsNames,
              permission: permissionType,
              smartContractId: smartContractAddress,
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
                  labelText: 'Derivation index',
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
        CryptoActionCard(
          title: 'Delete Key',
          height: 350,
          icon: Icons.key_off,
          color: nearColors.nearGreen,
          onTap: () {
            final deleteKeyPublicKeyAddress =
                deleteKeyPublicKeyAddressController.text;
            final walletID = homeVM.walletIdStream.value;
            final currentPublicAddress = homeVM
                    .cryptoLibrary.walletsStream.value
                    .firstWhere((element) => element.id == walletID)
                    .blockchainsData![BlockChains.near]
                    ?.firstWhereOrNull((element) =>
                        element.derivationPath
                            .replaceAll("'", '')
                            .split('/')
                            .last ==
                        '0')
                    ?.publicKey ??
                'no pub key';
            homeVM
                .deleteKeyNearBlockChain(
              blockchainType: BlockChains.near,
              walletID: walletID,
              publicKey: deleteKeyPublicKeyAddress,
              fromAddress: currentPublicAddress,
            )
                .then(
              (value) {
                setState(() {
                  log("Result of deleteKeyNearBlockChain $value");
                });
              },
            );
          },
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: deleteKeyPublicKeyAddressController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Delete Key',
                  labelStyle: nearTextStyles.bodyCopy!.copyWith(
                    color: nearColors.nearBlack,
                  ),
                ),
              ),
            ],
          ),
        ),

        // CryptoActionCard(
        //   title: 'Stake',
        //   height: 350,
        //   icon: Icons.attach_money_outlined,
        //   color: nearColors.nearGreen,
        //   onTap: () {
        //     final walletID = homeVM.walletIdStream.value;
        //     final amount = stakeAmountController.text;
        //     final validatorId = stakeValidatorAccountIDController.text;
        //     final currentPublicAddress = homeVM.cryptoLibrary.walletsStream.value
        //         .firstWhere((element) => element.id == walletID)
        //         .blockchainsData![BlockChains.near]!
        //         .publicKey;

        //     homeVM
        //         .stakeNearBlockChain(
        //       blockchainType: BlockChains.near,
        //       walletID: walletID,
        //       amount: amount,
        //       validatorId: validatorId,
        //       fromAddress: currentPublicAddress,
        //     )
        //         .then(
        //       (value) {
        //         setState(() {
        //           log("Result of deleteKeyNearBlockChain $value");
        //         });
        //       },
        //     );

        //     // final deleteKeyPublicKeyAddress =
        //     //     deleteKeyPublicKeyAddressController.text;
        //     // final walletID = homeVM.walletIdStream.value;
        //     // final currentPublicAddress = homeVM.cryptoLibrary.walletsStream.value
        //     //     .firstWhere((element) => element.id == walletID)
        //     //     .blockchainsData![BlockChains.near]!
        //     //     .publicKey;
        //     // homeVM
        //     //     .deleteKeyNearBlockChain(
        //     //   blockchainType: BlockChains.near,
        //     //   walletID: walletID,
        //     //   publicKey: deleteKeyPublicKeyAddress,
        //     //   fromAddress: currentPublicAddress,
        //     // )
        //     //     .then(
        //     //   (value) {
        //     //     setState(() {
        //     //       log("Result of deleteKeyNearBlockChain $value");
        //     //     });
        //     //   },
        //     // );
        //   },
        //   child: Column(
        //     children: [
        //       const SizedBox(height: 20),
        //       TextFormField(
        //         controller: stakeValidatorAccountIDController,
        //         decoration: InputDecoration(
        //           border: const OutlineInputBorder(),
        //           labelText: 'Validator account ID',
        //           labelStyle: nearTextStyles.bodyCopy!.copyWith(
        //             color: nearColors.nearBlack,
        //           ),
        //         ),
        //       ),
        //       const SizedBox(height: 20),
        //       TextFormField(
        //         controller: stakeAmountController,
        //         decoration: InputDecoration(
        //           border: const OutlineInputBorder(),
        //           labelText: 'Amount of staking Near',
        //           labelStyle: nearTextStyles.bodyCopy!.copyWith(
        //             color: nearColors.nearBlack,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        // CryptoActionCard(
        //   title: 'Unstake',
        //   height: 350,
        //   icon: Icons.attach_money_outlined,
        //   color: nearColors.nearGreen,
        //   onTap: () {
        //     // final deleteKeyPublicKeyAddress =
        //     //     deleteKeyPublicKeyAddressController.text;
        //     // final walletID = homeVM.walletIdStream.value;
        //     // final currentPublicAddress = homeVM.cryptoLibrary.walletsStream.value
        //     //     .firstWhere((element) => element.id == walletID)
        //     //     .blockchainsData![BlockChains.near]!
        //     //     .publicKey;
        //     // homeVM
        //     //     .deleteKeyNearBlockChain(
        //     //   blockchainType: BlockChains.near,
        //     //   walletID: walletID,
        //     //   publicKey: deleteKeyPublicKeyAddress,
        //     //   fromAddress: currentPublicAddress,
        //     // )
        //     //     .then(
        //     //   (value) {
        //     //     setState(() {
        //     //       log("Result of deleteKeyNearBlockChain $value");
        //     //     });
        //     //   },
        //     // );
        //   },
        //   child: Column(
        //     children: [
        //       const SizedBox(height: 20),
        //       TextFormField(
        //         controller: unstakeValidatorAccountIDController,
        //         decoration: InputDecoration(
        //           border: const OutlineInputBorder(),
        //           labelText: 'Validator account ID',
        //           labelStyle: nearTextStyles.bodyCopy!.copyWith(
        //             color: nearColors.nearBlack,
        //           ),
        //         ),
        //       ),
        //       const SizedBox(height: 20),
        //       TextFormField(
        //         controller: unstakeAmountController,
        //         decoration: InputDecoration(
        //           border: const OutlineInputBorder(),
        //           labelText: 'Amount of unstacking Near',
        //           labelStyle: nearTextStyles.bodyCopy!.copyWith(
        //             color: nearColors.nearBlack,
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}

class CryptoActionHeader extends StatefulWidget {
  const CryptoActionHeader({Key? key, required this.blockchainType})
      : super(key: key);
  final String blockchainType;
  @override
  // ignore: library_private_types_in_public_api
  _CryptoActionHeaderState createState() => _CryptoActionHeaderState();
}

class _CryptoActionHeaderState extends State<CryptoActionHeader> {
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
      homeVM.cryptoLibrary.cryptoService.setBlockchainNetworkEnvironment(
          blockchainType: BlockChains.near, newUrl: selectedUrl);
    });
  }

  @override
  void initState() {
    super.initState();
    final homeVM = Modular.get<HomeVM>();
    final preDefinedUrls = homeVM
        .cryptoLibrary.cryptoService.blockchainServices[widget.blockchainType]!
        .getBlockchainsUrlsByBlockchainType();
    networkUrls.addAll(preDefinedUrls);
    selectedUrl = networkUrls.first;
    homeVM.cryptoLibrary.cryptoService.setBlockchainNetworkEnvironment(
      blockchainType: BlockChains.near,
      newUrl: selectedUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    final homeVM = Modular.get<HomeVM>();

    final currentPublicAddress = homeVM.cryptoLibrary.walletsStream.value
        .firstWhere((element) => element.id == homeVM.walletIdStream.value)
        .blockchainsData![BlockChains.near]
        ?.firstWhereOrNull((element) =>
            element.derivationPath.replaceAll("'", '').split('/').last == '0')
        ?.publicKey;

    final derivationPath = homeVM.cryptoLibrary.walletsStream.value
        .firstWhere((element) => element.id == homeVM.walletIdStream.value)
        .blockchainsData![BlockChains.near]
        ?.firstWhereOrNull((element) =>
            element.derivationPath.replaceAll("'", '').split('/').last == '0')
        ?.derivationPath;

    log("currentPublicAddress $currentPublicAddress");
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            'Your Derivation Path :$derivationPath',
            style: nearTextStyles.headline!.copyWith(
              fontWeight: FontWeight.bold,
              color: nearColors.nearBlack,
              fontSize: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            'Your Address :$currentPublicAddress',
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
              homeVM.cryptoLibrary.cryptoService
                  .setBlockchainNetworkEnvironment(
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
