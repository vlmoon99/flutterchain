import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutterchain/flutterchain_lib.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/formaters/chains/near_formater.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_smart_contract_arguments.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:flutterchain_example/modules/home/services/helper_service.dart';
import 'package:flutterchain_example/modules/home/stores/chains/near_blockchain_store.dart';
import 'package:flutterchain_example/modules/home/stores/core/user_store.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/ui_state.dart';
import 'package:rxdart/rxdart.dart';

class NearVM {
  final FlutterChainLibrary cryptoLibrary;
  final NearBlockchainStore nearBlockchainStore;
  final NearHelperService nearHelperService;
  final UserStore userStore;
  final BehaviorSubject<NearState> nearState = BehaviorSubject<NearState>()
    ..add(SuccessNearBlockchainState());
  NearVM(
    this.cryptoLibrary,
    this.nearBlockchainStore,
    this.userStore,
    this.nearHelperService,
  );

  Future<BlockChainData> addBlockChainDataByDerivationPath({
    required DerivationPath derivationPath,
    required String walletID,
  }) async {
    return cryptoLibrary.addBlockChainDataByDerivationPath(
      derivationPath: derivationPath,
      blockchainType: BlockChains.near,
      walletID: walletID,
    );
  }

  Future<BlockchainResponse> addKeyNearBlockChain({
    required String permission,
    required String allowance,
    required String smartContractId,
    required List<String> methodNames,
    required String walletID,
    required DerivationPath currentDerivationPath,
  }) async {
    final yoctoNearAllowance = NearFormatter.nearToYoctoNear(allowance);
    final nearBlockChainService = cryptoLibrary.blockchainService
        .blockchainServices[BlockChains.near] as NearBlockChainService?;
    if (nearBlockChainService == null) {
      throw Exception("didn't found near blockchain service");
    }
    const randomWalletDerivationPath = DerivationPath(
      purpose: "44'",
      coinType: "397'",
      accountNumber: "0'",
      change: "0'",
      address: "1'",
    );
    final generatedWallet = await cryptoLibrary.blockchainService
        .generateNewWallet(walletName: "GeneratedRandom ${DateTime.now()}");
    final randomBlockchainData = await cryptoLibrary
        .blockchainService.blockchainServices[BlockChains.near]!
        .getBlockChainDataByDerivationPath(
      derivationPath: randomWalletDerivationPath,
      mnemonic: generatedWallet.mnemonic,
      passphrase: '',
    );
    log("New Public Key ${randomBlockchainData.publicKey}");
    final currentWallet = cryptoLibrary.walletsStream.value
        .firstWhere((element) => element.id == walletID);

    final fromTheAddress = ((currentWallet.blockchainsData?[BlockChains.near])
                    ?.firstWhereOrNull((element) =>
                        element.derivationPath == currentDerivationPath)
                as NearBlockChainData)
            .accountId ??
        (currentWallet.blockchainsData?[BlockChains.near] as NearBlockChainData)
            .publicKey;

    final publicKey = currentWallet.blockchainsData?[BlockChains.near]!
        .firstWhereOrNull(
            (element) => element.derivationPath == currentDerivationPath)
        ?.publicKey;
    if (publicKey == null) {
      throw Exception('Incorrect User public key is null');
    }

    final privateKey = currentWallet.blockchainsData?[BlockChains.near]
        ?.firstWhereOrNull(
            (element) => element.derivationPath == currentDerivationPath)
        ?.privateKey;

    if (privateKey == null) {
      throw Exception('Incorrect User private key is null');
    }

    final response = nearBlockChainService.addKey(
      permission: permission,
      allowance: yoctoNearAllowance,
      smartContractId: smartContractId,
      methodNames: methodNames,
      derivationPathOfNewGeneratedAccount: randomWalletDerivationPath,
      fromAddress: fromTheAddress,
      mnemonic: generatedWallet.mnemonic,
      privateKey: privateKey,
      publicKey: publicKey,
    );

    return response;
  }

  Future<BlockchainResponse> deleteKeyNearBlockChain({
    required String walletID,
    required String deletedPublicKey,
    required DerivationPath currentDerivationPath,
  }) {
    final nearBlockChainService = cryptoLibrary.blockchainService
        .blockchainServices[BlockChains.near] as NearBlockChainService?;
    if (nearBlockChainService == null) {
      throw Exception("didn't found near blockchain service");
    }
    final currentWallet = cryptoLibrary.walletsStream.value
        .firstWhere((element) => element.id == walletID);

    final accountId = ((currentWallet.blockchainsData?[BlockChains.near])
                    ?.firstWhereOrNull((element) =>
                        element.derivationPath == currentDerivationPath)
                as NearBlockChainData)
            .accountId ??
        (currentWallet.blockchainsData?[BlockChains.near] as NearBlockChainData)
            .publicKey;
    final publicKey = currentWallet.blockchainsData?[BlockChains.near]!
        .firstWhereOrNull(
            (element) => element.derivationPath == currentDerivationPath)
        ?.publicKey;
    if (publicKey == null) {
      throw Exception('Incorrect User public key is null');
    }

    final privateKey = currentWallet.blockchainsData?[BlockChains.near]
        ?.firstWhereOrNull(
            (element) => element.derivationPath == currentDerivationPath)
        ?.privateKey;

    if (privateKey == null) {
      throw Exception('Incorrect User private key is null');
    }

    final response = nearBlockChainService.deleteKey(
      publicKey: publicKey,
      accountId: accountId,
      privateKey: privateKey,
      deletedPublicKey: deletedPublicKey,
    );

    return response;
  }

  Future<BlockchainResponse> callSmartContractFunction({
    required Map<String, dynamic> args,
    required String amountOfDeposit,
    required String walletId,
    required String smartContractAddress,
    required String method,
    required DerivationPath currentDerivationPath,
  }) {
    final response = cryptoLibrary.callSmartContractFunction(
      currentDerivationPath: currentDerivationPath,
      walletId: walletId,
      typeOfBlockchain: BlockChains.near,
      toAddress: smartContractAddress,
      arguments: NearBlockChainSmartContractArguments(
        method: method,
        args: args,
        transferAmount: NearFormatter.nearToYoctoNear(amountOfDeposit),
      ),
    );
    return response;
  }

  Future<dynamic> getBalanceByDerivationPath({
    required String walletId,
    required DerivationPath currentDerivationPath,
  }) async =>
      cryptoLibrary.getBalanceOfAddressOnSpecificBlockchain(
        walletId: walletId,
        blockchainType: BlockChains.near,
        currentDerivationPath: currentDerivationPath,
      );

  Future<String> getWalletPublicKeyAddressByWalletId(
          String walletName, DerivationPath currentDerivationPath) async =>
      cryptoLibrary.walletsStream.value
          .firstWhere((element) => element.name == walletName)
          .blockchainsData?[BlockChains.near]!
          .firstWhereOrNull(
              (element) => element.derivationPath == currentDerivationPath)
          ?.publicKey ??
      'not founded';

  Future<String> getMnemonicPhraseByWalletName(
    String walletName,
  ) async =>
      cryptoLibrary.walletsStream.value
          .firstWhere((element) => element.name == walletName)
          .mnemonic;

  Future<BlockchainResponse> sendNativeCoinTransferByWalletId({
    required String toAddress,
    required String transferAmount,
    required String walletId,
    required String typeOfBlockchain,
    required DerivationPath currentDerivationPath,
  }) async {
    final response = cryptoLibrary.sendTransferNativeCoin(
      walletId: walletId,
      typeOfBlockchain: typeOfBlockchain,
      toAddress: toAddress,
      currentDerivationPath: currentDerivationPath,
      transferAmount: NearFormatter.nearToYoctoNear(transferAmount),
    );
    return response;
  }

  Future<bool> activateAccount(String accountId) async {
    return nearHelperService.activateTestNetAccountID(accountId);
  }
}
