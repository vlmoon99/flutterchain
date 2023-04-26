import 'dart:convert';
import 'package:collection/collection.dart';

import 'package:flutterchain/flutterchain_lib.dart';
import 'package:flutterchain/flutterchain_lib/formaters/near_formater.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:rxdart/rxdart.dart';

class HomeVM {
  final FlutterChainCryptoLibrary cryptoLibary;
  final BehaviorSubject<String> walletIdStream = BehaviorSubject<String>();

  HomeVM(this.cryptoLibary) {
    cryptoLibary.walletsStream.valueOrNull?.forEach((element) {
      print(element.name);
    });
    walletIdStream.add(
        (cryptoLibary.walletsStream.valueOrNull?.isNotEmpty ?? false)
            ? cryptoLibary.walletsStream.valueOrNull?.first.id ?? 'not founded'
            : 'not founded');
  }

  Set<String> getBlockchainsUrlsByBlockchainType(String blockchainType) {
    return cryptoLibary.getBlockchainsUrlsByBlockchainType(blockchainType);
  }

  Future<void> createWallet(
    String? mnemonic,
    String walletName,
  ) async {
    if (mnemonic?.isEmpty ?? true) {
      cryptoLibary.createWalletWithGeneratedMnemonic(walletName: walletName);
    } else {
      cryptoLibary.createWallet(mnemonic: mnemonic!, walletName: walletName);
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
    final response = cryptoLibary.addKeyNearBlockChain(
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
    required String fromAdress,
  }) {
    final response = cryptoLibary.deleteKeyNearBlockChain(
      blockchainType: blockchainType,
      walletID: walletID,
      publicKey: publicKey,
      fromAdress: fromAdress,
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
    final response = cryptoLibary.stakeNearBlockChain(
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
    final response = cryptoLibary.callSmartContractFunction(
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
      cryptoLibary.getBalanceOfAddressOnSpecificBlockchain(
          walletId: walletId, blockchainType: blockchainType);

  Future<String> getWalletPublicKeyAddressByWalletId(String walletName,
          String blockchainType, String derivationIndex) async =>
      cryptoLibary.walletsStream.value
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
      cryptoLibary.walletsStream.value
          .firstWhere((element) => element.name == walletName)
          .mnemonic;

  Future<dynamic> sendNativeCoinTransferByWalletId({
    required String toAdress,
    required String transferAmount,
    required String walletId,
    required String typeOfBlockchain,
  }) async {
    final response = cryptoLibary.sendTransferNativeCoin(
      walletId: walletId,
      typeOfBlockchain: typeOfBlockchain,
      toAdress: toAdress,
      transferAmount: NearFormatter.nearToYoctoNear(transferAmount),
    );
    return response;
  }
}
