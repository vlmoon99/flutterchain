import 'dart:convert';

import 'package:flutterchain_example/network/helper_network_client.dart';
import 'package:url_launcher/url_launcher.dart';

class NearHelperService {
  final NearHelperNetworkClient networkClient;

  NearHelperService(this.networkClient);

  Future<bool> activateTestNetAccountID(String accountId) async {
    final res = await networkClient.postHTTP(
        '/create-account', jsonEncode({"accountId": accountId}));
    return res.isSuccess;
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
