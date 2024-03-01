import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:rxdart/rxdart.dart';

class NearBlockchainStore {
  final BehaviorSubject<DerivationPath> currentDerivationPath =
      BehaviorSubject<DerivationPath>()
        ..add(
          const DerivationPath(
            purpose: "44'",
            coinType: "397'",
            accountNumber: "0'",
            change: "0'",
            address: "1'",
          ),
        );
}
