import 'dart:developer';

import 'package:flutterchain/flutterchain_lib.dart';
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
}
