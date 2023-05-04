import 'dart:convert';
import 'dart:developer';
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/formaters/near_formater.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:flutterchain_example/modules/home/components/core/crypto_actions_card.dart';
import 'package:flutterchain_example/modules/home/vms/core/home_vm.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near_vm.dart';
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

  //Make action with injected private Key
  final TextEditingController makeActionWithInjectedPrivateKey =
      TextEditingController();
  final TextEditingController makeActionWithInjectedAccountId =
      TextEditingController();

  dynamic resultOfSmartContractCall;
  dynamic blockchainsDataCreatedByDerivationPath;
  dynamic exportSecretKeyToTheNearApiJsFormat;
  dynamic creatingNearAccount;
  // final nearBlockChainSupportedActions = [
  //   'transfer',
  //   'smartContractCall',
  //   'addKey',
  //   'deleteKey',
  // ];

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
    // argumentsSmartContractController.text =
    //     r'{"new_account_id": "test12wqq.testnet","new_public_key": "ed25519:GPZ9HFmtvbBweLpXUQ3cJEHvDr39dfJN9aNEn1G9nsoU"}';
    // smartContractAddressController.text = "testnet";
    // smartContractMethodNameController.text = "create_account";
    // amountOfDepositOnSmartContractController.text = '0.00182';

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

    //Create Address by derivation path
    createBlockchainDataDerivationPath.text = "m/44'/397'/0'/0'/1'";

    //Make action with injected private Key
    makeActionWithInjectedPrivateKey.text =
        'ed25519:w6iUJ6uLt1crmMcYMqeWXk3UVAzXzmgTibcsno639PCUfAQtxvbysXyxeeKja6BuwcA7B8gcMDXm4WiHAo6UgfF';
    // 'ed25519:2WB6k8p1RWXYYcnyP3aqCZRqmr7iXW2oRCaoFpuWtkPqi1C9DrSFGWEheik3CYQVqVE2aQpaVBsXuTHdCchyUm8z';
    makeActionWithInjectedAccountId.text = "vladddddd.testnet";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    final homeVM = Modular.get<HomeVM>();
    final nearVM = Modular.get<NearVM>();

    return Column(
      children: [
        const CryptoActionHeader(
          blockchainType: BlockChains.near,
        ),
        CryptoActionCard(
          title: 'Create New BlockChainData by derivation path',
          height: 350,
          icon: Icons.wallet,
          color: nearColors.nearGreen,
          onTap: () {
            final walletID = homeVM.userStore.walletIdStream.value;
            final derivationPath = createBlockchainDataDerivationPath.text
                .replaceAll("'", "")
                .split('/')
                .toList();

            final derivationModel = DerivationPath(
              purpose: derivationPath[1],
              coinType: derivationPath[2],
              accountNumber: derivationPath[3],
              change: derivationPath[4],
              address: derivationPath[5],
            );
            nearVM
                .addBlockChainDataByDerivationPath(
              currentDerivationPath: derivationModel,
              walletID: walletID,
            )
                .then(
              (value) {
                setState(() {
                  nearVM.nearBlockchainStore.currentDerivationPath
                      .add(value.derivationPath);
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
            final walletID = homeVM.userStore.walletIdStream.value;
            final derivationPath =
                nearVM.nearBlockchainStore.currentDerivationPath.value;
            nearVM
                .sendNativeCoinTransferByWalletId(
              currentDerivationPath: derivationPath,
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
            final derivationPath =
                nearVM.nearBlockchainStore.currentDerivationPath.value;

            final walletID = homeVM.userStore.walletIdStream.value;
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
            final walletID = homeVM.userStore.walletIdStream.value;
            final methodsNames =
                addKeyMethodsNamesController.text.split(',').toList();
            final allowanceAmount = addKeyAllowanceAmountController.text;
            final smartContractAddress =
                addKeySmartContractAddressController.text;

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
        ),
        CryptoActionCard(
          title: 'Delete Key',
          height: 350,
          icon: Icons.key_off,
          color: nearColors.nearGreen,
          onTap: () {
            final deleteKeyPublicKeyAddress =
                deleteKeyPublicKeyAddressController.text;
            final walletID = homeVM.userStore.walletIdStream.value;
            final currentDerivationPath =
                nearVM.nearBlockchainStore.currentDerivationPath.value;

            nearVM
                .deleteKeyNearBlockChain(
              walletID: walletID,
              currentDerivationPath: currentDerivationPath,
              publicKey: deleteKeyPublicKeyAddress,
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
        CryptoActionCard(
          title:
              'Make Transfer with injected private key\n(from near api js format)',
          height: 650,
          icon: Icons.key_rounded,
          color: nearColors.nearGreen,
          onTap: () async {
            final privateKey = makeActionWithInjectedPrivateKey.text;
            final recipient = recipientEditingController.text;
            final amount = transferDepositController.text;
            final accountIdOfInjectedKey = makeActionWithInjectedAccountId.text;
            final nearService = nearVM.cryptoLibrary.blockchainService
                .blockchainServices[BlockChains.near] as NearBlockChainService;
            final pubKeyFromSecretKeyNearApiJsFormat =
                await nearService.getPublicKeyFromSecretKeyFromNearApiJSFormat(
              privateKey.split(":").last,
            );
            log('pubKeyFromPrivateKey is $pubKeyFromSecretKeyNearApiJsFormat');
            final privKeyFromSecretKeyNearApiJsFormat =
                await nearService.getPrivateKeyFromSecretKeyFromNearApiJSFormat(
              privateKey.split(":").last,
            );
            log('privKeyFromSecretKeyNearApiJsFormat is $privKeyFromSecretKeyNearApiJsFormat');
            log('pubKeyBase58 ${await nearService.getBase58PubKeyFromHexValue(
              hexEncodedPubKey: pubKeyFromSecretKeyNearApiJsFormat,
            )}');
            final res = await nearService.sendTransferNativeCoin(
              recipient,
              accountIdOfInjectedKey,
              NearFormatter.nearToYoctoNear(amount),
              privKeyFromSecretKeyNearApiJsFormat,
              pubKeyFromSecretKeyNearApiJsFormat,
            );
            log('Transfer is ${res.status}');
          },
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: makeActionWithInjectedPrivateKey,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Injected Private Key',
                  labelStyle: nearTextStyles.bodyCopy!.copyWith(
                    color: nearColors.nearBlack,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: makeActionWithInjectedAccountId,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Public ID in near blockchain',
                  labelStyle: nearTextStyles.bodyCopy!.copyWith(
                    color: nearColors.nearBlack,
                  ),
                ),
              ),
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
        CryptoActionCard(
          title: 'Export private key to (near api js format)',
          height: 500,
          icon: Icons.storage,
          color: nearColors.nearGreen,
          onTap: () async {
            final nearService = nearVM.cryptoLibrary.blockchainService
                .blockchainServices[BlockChains.near] as NearBlockChainService;
            final walletID = homeVM.userStore.walletIdStream.value;
            final currentDerivationPath =
                nearVM.nearBlockchainStore.currentDerivationPath.value;
            final currentWallet = homeVM.cryptoLibrary.walletsStream.value
                .firstWhere((element) => element.id == walletID);
            final currentBlockchainData = currentWallet
                .blockchainsData?[BlockChains.near]
                ?.firstWhere((element) =>
                    element.derivationPath == currentDerivationPath);
            final secretKey =
                await nearService.exportPrivateKeyToTheNearApiJsFormat(
              currentBlockchainData: currentBlockchainData,
            );
            setState(() {
              exportSecretKeyToTheNearApiJsFormat = secretKey;
              log(exportSecretKeyToTheNearApiJsFormat.toString());
            });
          },
          child: Column(
            children: [
              Center(
                child: Text(
                  'Exported private key in near api js format is -> :\n $exportSecretKeyToTheNearApiJsFormat',
                  style: nearTextStyles.bodyCopy!.copyWith(
                      fontWeight: FontWeight.w300,
                      color: nearColors.nearBlack,
                      fontSize: 30),
                ),
              ),
            ],
          ),
        ),
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
  String selectedUrl = '';

  final TextEditingController _customUrlController = TextEditingController();

  final Set<String> networkUrls = {};

  void _handleCustomUrlChanged(String url) {
    setState(() {
      final nearVM = Modular.get<NearVM>();
      networkUrls.add(url);
      selectedUrl = url;
      nearVM.cryptoLibrary.blockchainService.setBlockchainNetworkEnvironment(
          blockchainType: BlockChains.near, newUrl: selectedUrl);
    });
  }

  @override
  void initState() {
    super.initState();
    final nearVM = Modular.get<NearVM>();
    final preDefinedUrls = nearVM.cryptoLibrary.blockchainService
        .blockchainServices[widget.blockchainType]!
        .getBlockchainsUrlsByBlockchainType();
    networkUrls.addAll(preDefinedUrls);
    selectedUrl = networkUrls.first;
    nearVM.cryptoLibrary.blockchainService.setBlockchainNetworkEnvironment(
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
    final nearVM = Modular.get<NearVM>();

    return StreamBuilder<DerivationPath>(
        stream: nearVM.nearBlockchainStore.currentDerivationPath,
        builder: (context, snapshot) {
          final derivationModel =
              nearVM.nearBlockchainStore.currentDerivationPath.value;
          final listOfBlockChainData = homeVM.cryptoLibrary.walletsStream.value
              .firstWhere((element) =>
                  element.id == homeVM.userStore.walletIdStream.value)
              .blockchainsData![BlockChains.near];
          final currentPublicAddress = homeVM.cryptoLibrary.walletsStream.value
              .firstWhere((element) =>
                  element.id == homeVM.userStore.walletIdStream.value)
              .blockchainsData![BlockChains.near]
              ?.firstWhereOrNull(
                  (element) => element.derivationPath == derivationModel)
              ?.publicKey;
          final currentPrivAddress = homeVM.cryptoLibrary.walletsStream.value
              .firstWhere((element) =>
                  element.id == homeVM.userStore.walletIdStream.value)
              .blockchainsData![BlockChains.near]
              ?.firstWhereOrNull(
                  (element) => element.derivationPath == derivationModel)
              ?.privateKey;

          final derivationPath = homeVM.cryptoLibrary.walletsStream.value
              .firstWhere((element) =>
                  element.id == homeVM.userStore.walletIdStream.value)
              .blockchainsData![BlockChains.near]
              ?.firstWhereOrNull(
                  (element) => element.derivationPath == derivationModel)
              ?.derivationPath;
          log("currentPublicAddress $currentPublicAddress");
          log("currentPrivAddress $currentPrivAddress");
          log("mnemonic ${homeVM.cryptoLibrary.walletsStream.value.firstWhere((element) => element.id == homeVM.userStore.walletIdStream.value).mnemonic}");

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
              DropdownButton<DerivationPath>(
                value: derivationModel,
                onChanged: (DerivationPath? value) {
                  setState(() {
                    final nearVM = Modular.get<NearVM>();
                    nearVM.nearBlockchainStore.currentDerivationPath
                        .add(value!);
                  });
                },
                items: listOfBlockChainData
                    ?.map((blockChainData) => DropdownMenuItem<DerivationPath>(
                          value: blockChainData.derivationPath,
                          child: Text(
                            blockChainData.derivationPath.toString(),
                            style: nearTextStyles.bodyCopy!.copyWith(
                              color: nearColors.nearGray,
                            ),
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),
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
                future: nearVM.getBalanceByDerivationPath(
                  walletId: homeVM.userStore.walletIdStream.value,
                  currentDerivationPath: derivationModel,
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
                    return const SizedBox();
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
                    final nearVM = Modular.get<NearVM>();
                    nearVM.cryptoLibrary.blockchainService
                        .setBlockchainNetworkEnvironment(
                            blockchainType: BlockChains.near,
                            newUrl: selectedUrl);
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
        });
  }
}
