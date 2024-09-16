import 'package:flutterchain/flutterchain_lib/models/core/account_info_request.dart';

class BitcoinAccountInfoRequest implements AccountInfoRequest {
  final String accountId;

  BitcoinAccountInfoRequest({required this.accountId});
}
