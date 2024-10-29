import 'package:flutterchain/flutterchain_lib/models/core/account_info_request.dart';

class XrpAccountInfoRequest implements AccountInfoRequest {
  final String accountId;

  XrpAccountInfoRequest({
    required this.accountId,
  });
}
