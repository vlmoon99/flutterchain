import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/core/account_info_request.dart';

class NearAccountInfoRequest implements AccountInfoRequest {
  final String accountId;

  /// you also can use `publicKey` instead of `accountId`
  NearAccountInfoRequest({required this.accountId});
  
  @override
  String blockchainType = BlockChains.near;
}
