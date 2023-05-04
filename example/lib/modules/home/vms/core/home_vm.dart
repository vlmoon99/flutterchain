import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutterchain/flutterchain_lib.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain_example/modules/home/stores/core/user_store.dart';

class HomeVM {
  final FlutterChainLibrary cryptoLibrary;
  final UserStore userStore;
  HomeVM(
    this.cryptoLibrary,
    this.userStore,
  ) {
    cryptoLibrary.walletsStream.valueOrNull?.forEach((element) {
      log(element.name);
    });
    userStore.walletIdStream.add(
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
    Wallet? wallet;
    if (mnemonic?.isEmpty ?? true) {
      wallet = await cryptoLibrary.createWalletWithGeneratedMnemonic(
          walletName: walletName);
    } else {
      wallet = await cryptoLibrary.createWalletByImportedMnemonic(
          mnemonic: mnemonic!, walletName: walletName);
    }
    userStore.walletIdStream.add(wallet.id);
  }
}
