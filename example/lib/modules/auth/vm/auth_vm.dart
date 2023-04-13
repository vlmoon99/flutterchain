import 'package:flutterchain/flutterchain_lib/flutterchain_lib.dart';

class AuthVM {
  final FlutterChainCryptoLibrary cryptoLibary;
  AuthVM(this.cryptoLibary);

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
}
