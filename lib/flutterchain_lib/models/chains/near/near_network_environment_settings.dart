import 'package:flutterchain/flutterchain_lib/models/core/blockchain_network_environment_settings.dart';

class NearNetworkEnvironmentSettings
    implements BlockChainNetworkEnvironmentSettings {
  final String chainUrl;

  const NearNetworkEnvironmentSettings({required this.chainUrl});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NearNetworkEnvironmentSettings && chainUrl == other.chainUrl;
}
