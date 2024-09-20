import 'package:flutterchain/flutterchain_lib/models/core/blockchain_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/network/core/network_core.dart';

class ConcordiumNetworkEnvironmentSettings
    implements BlockChainNetworkEnvironmentSettings {
  final String baseUrl;
  final int port;
  final String typeOfNetwork;
  final NetworkClient? networkClient;

  ConcordiumNetworkEnvironmentSettings({
    required this.baseUrl,
    required this.port,
    required this.typeOfNetwork,
    this.networkClient,
  });
}
