import 'package:flutterchain/flutterchain_lib.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';

void main() async {
  final FlutterChainLibrary cryptoLibrary =
      FlutterChainLibrary.defaultInstance();
  await cryptoLibrary.addBlockChainDataByDerivationPath(
    derivationPath: const DerivationPath(
      purpose: "44'",
      coinType: "397'",
      accountNumber: "0'",
      change: "0'",
      address: "2'",
    ),
    blockchainType: BlockChains.near, // "NEAR"
    walletID: "0",
  );
}
