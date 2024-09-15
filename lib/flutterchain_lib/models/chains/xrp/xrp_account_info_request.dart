import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/core/account_info_request.dart';

class XrpAccountInfoRequest implements AccountInfoRequest {
  final String accountId;

  XrpAccountInfoRequest({
    required this.accountId,
  });

  @override
  String blockchainType = BlockChains.xrp;
}
