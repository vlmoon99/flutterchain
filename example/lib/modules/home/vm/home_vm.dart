import 'dart:developer';

import 'package:collection/collection.dart';

import 'package:flutterchain/flutterchain_lib.dart';
import 'package:flutterchain/flutterchain_lib/formaters/near_formater.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:rxdart/rxdart.dart';

class HomeVM {
  final FlutterChainCryptoLibrary cryptoLibrary;
  final BehaviorSubject<String> walletIdStream = BehaviorSubject<String>();

  HomeVM(this.cryptoLibrary) {
    cryptoLibrary.walletsStream.valueOrNull?.forEach((element) {
      log(element.name);
    });
    walletIdStream.add(
        (cryptoLibrary.walletsStream.valueOrNull?.isNotEmpty ?? false)
            ? cryptoLibrary.walletsStream.valueOrNull?.first.id ?? 'not founded'
            : 'not founded');
  }

  Set<String> getBlockchainsUrlsByBlockchainType(String blockchainType) {
    return cryptoLibrary.getBlockchainsUrlsByBlockchainType(blockchainType);
  }

  Future<void> createWallet(
    String? mnemonic,
    String walletName,
  ) async {
    if (mnemonic?.isEmpty ?? true) {
      cryptoLibrary.createWalletWithGeneratedMnemonic(walletName: walletName);
    } else {
      cryptoLibrary.createWallet(mnemonic: mnemonic!, walletName: walletName);
    }
  }

  Future<BlockchainResponse> addKeyNearBlockChain({
    required String indexOfTheDerivationPath,
    required String permission,
    required String allowance,
    required String smartContractId,
    required List<String> methodNames,
    required String blockchainType,
    required String walletID,
  }) {
    final yoctoNearAllowance = NearFormatter.nearToYoctoNear(allowance);
    final response = cryptoLibrary.addKeyNearBlockChain(
      indexOfTheDerivationPath: indexOfTheDerivationPath,
      permission: permission,
      allowance: yoctoNearAllowance,
      smartContractId: smartContractId,
      methodNames: methodNames,
      blockchainType: blockchainType,
      walletID: walletID,
    );

    return response;
  }

  Future<BlockchainResponse> deleteKeyNearBlockChain({
    required String blockchainType,
    required String walletID,
    required String publicKey,
    required String fromAddress,
  }) {
    final response = cryptoLibrary.deleteKeyNearBlockChain(
      blockchainType: blockchainType,
      walletID: walletID,
      publicKey: publicKey,
      fromAdress: fromAddress,
    );

    return response;
  }

  Future<BlockchainResponse> stakeNearBlockChain({
    required String blockchainType,
    required String walletID,
    required String amount,
    required String validatorId,
    required String fromAdress,
  }) {
    final response = cryptoLibrary.stakeNearBlockChain(
      blockchainType: blockchainType,
      walletID: walletID,
      amount: NearFormatter.nearToYoctoNear(amount),
      validatorId: validatorId,
      fromAdress: fromAdress,
    );

    return response;
  }

  Future<BlockchainResponse> callSmartContractFunction({
    required Map<String, dynamic> args,
    required String amountOfDeposit,
    required String blockchainType,
    required String walletId,
    required String smartContractAddress,
    required String method,
  }) {
    final response = cryptoLibrary.callSmartContractFunction(
      walletId: walletId,
      typeOfBlockchain: blockchainType,
      toAdress: smartContractAddress,
      transferAmount: NearFormatter.nearToYoctoNear(amountOfDeposit),
      args: args,
      method: method,
    );
    return response;
  }

  Future<dynamic> getWalletBalanceByPublicKey({
    required String walletId,
    required String blockchainType,
  }) async =>
      cryptoLibrary.getBalanceOfAddressOnSpecificBlockchain(
          walletId: walletId, blockchainType: blockchainType);

  Future<String> getWalletPublicKeyAddressByWalletId(String walletName,
          String blockchainType, String derivationIndex) async =>
      cryptoLibrary.walletsStream.value
          .firstWhere((element) => element.name == walletName)
          .blockchainsData?[blockchainType]!
          .firstWhereOrNull((element) =>
              element.derivationPath.replaceAll("'", '').split('/').last ==
              derivationIndex)
          ?.publicKey ??
      'No public key';

  Future<String> getMnemonicPhraseByWalletId(
    String walletName,
  ) async =>
      cryptoLibrary.walletsStream.value
          .firstWhere((element) => element.name == walletName)
          .mnemonic;

  Future<dynamic> sendNativeCoinTransferByWalletId({
    required String toAddress,
    required String transferAmount,
    required String walletId,
    required String typeOfBlockchain,
  }) async {
    final response = cryptoLibrary.sendTransferNativeCoin(
      walletId: walletId,
      typeOfBlockchain: typeOfBlockchain,
      toAdress: toAddress,
      transferAmount: NearFormatter.nearToYoctoNear(transferAmount),
    );
    return response;
  }
}
