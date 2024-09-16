import 'package:flutterchain/flutterchain_lib/models/core/account_info_request.dart';

class EvmAccountInfoRequest implements AccountInfoRequest {
  final String accountId;

  EvmAccountInfoRequest({
    required this.accountId,
  });
}
