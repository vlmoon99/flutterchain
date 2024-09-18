import 'package:flutterchain/flutterchain_lib/models/core/account_info_request.dart';

class ConcordiumAccountInfoRequest implements AccountInfoRequest {
  final String accountAddress;
  String? blockHash;

  ConcordiumAccountInfoRequest({
    required this.accountAddress,
    this.blockHash,
  });
}
