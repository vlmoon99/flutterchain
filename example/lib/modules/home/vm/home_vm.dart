import 'dart:convert';

import 'package:flutterchain/flutterchain_lib/flutterchain_lib.dart';
import 'package:flutterchain/flutterchain_lib/formaters/near_formater.dart';
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
