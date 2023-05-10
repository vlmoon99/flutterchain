import 'package:flutterchain/flutterchain_lib/network/core/network_core.dart';

class NearHelperNetworkClient extends NetworkClient {
  NearHelperNetworkClient({required super.baseUrl, required super.dio}) {
    dio.options.receiveTimeout = const Duration(seconds: 5);
  }
}
