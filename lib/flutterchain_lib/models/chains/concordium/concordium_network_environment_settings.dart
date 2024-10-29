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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConcordiumNetworkEnvironmentSettings &&
          baseUrl == other.baseUrl &&
          port == other.port &&
          typeOfNetwork == other.typeOfNetwork;
}
