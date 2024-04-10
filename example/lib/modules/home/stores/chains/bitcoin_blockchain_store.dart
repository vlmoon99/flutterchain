import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:rxdart/rxdart.dart';

class BitcoinBlockchainStore {
  final BehaviorSubject<DerivationPath> currentDerivationPath =
      BehaviorSubject<DerivationPath>()
        ..add(
          const DerivationPath(
            purpose: "84'",
            coinType: "0'",
            accountNumber: "0'",
            change: "0",
            address: "0",
          ),
        );
}
