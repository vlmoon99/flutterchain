import 'package:flutterchain_example/network/helper_network_client.dart';

class NearHelperService {
  final NearHelperNetworkClient networkClient;

  NearHelperService(this.networkClient);

  Future<bool> activateTestNetAccountID(String accountId) async {
    final res = await networkClient
        .postHTTP('/create_account', {"accountId": accountId});
    return res.isSuccess;
  }
}
