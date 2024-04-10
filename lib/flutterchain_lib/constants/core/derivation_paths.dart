import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';

class BlockChainsDerivationPaths {
  static const DerivationPath near = DerivationPath(
    purpose: "44'",
    coinType: "397'",
    accountNumber: "0'",
    change: "0'",
    address: "1'",
  );
  static const DerivationPath bitcoin = DerivationPath(
    purpose: "84'",
    coinType: "0'",
    accountNumber: "0'",
    change: "0",
    address: "0",
  );
}
