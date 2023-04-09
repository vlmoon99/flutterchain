import 'package:flutterchain/flutterchain_lib/flutterchain_lib.dart';

class AuthVM {
  final FlutterChainCryptoLibrary cryptoLibary;
  AuthVM(this.cryptoLibary);

  Future<void> createWallet(
    String mnemonic,
    String walletName,
  ) async {
    cryptoLibary.createWallet(mnemonic: mnemonic, walletName: walletName);
  }

  Future<void> createWalletWithGeneratedMnemonic(String walletName) async {
    cryptoLibary.createWalletWithGeneratedMnemonic(walletName: walletName);
  }
}
