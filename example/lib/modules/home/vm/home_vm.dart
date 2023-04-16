import 'dart:convert';

import 'package:flutterchain/flutterchain_lib.dart';
import 'package:flutterchain/flutterchain_lib/formaters/near_formater.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:rxdart/rxdart.dart';

class HomeVM {
  final FlutterChainCryptoLibrary cryptoLibary;
  final BehaviorSubject<String> walletIdStream = BehaviorSubject<String>();

  HomeVM(this.cryptoLibary) {
    cryptoLibary.walletsStream.valueOrNull?.forEach((element) {
      print(element.name);
    });
    walletIdStream
        .add(cryptoLibary.walletsStream.valueOrNull?.first.id ?? 'not founded');
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

  Future<String> getWalletPublicKeyAddressByWalletId(
          String walletName, String blockchainType) async =>
      cryptoLibary.walletsStream.value
          .firstWhere((element) => element.name == walletName)
          .blockchainsData?[blockchainType]
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
