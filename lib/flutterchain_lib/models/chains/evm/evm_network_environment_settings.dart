import 'package:flutterchain/flutterchain_lib/models/core/blockchain_network_environment_settings.dart';

class EvmNetworkEnvironmentSettings
    implements BlockChainNetworkEnvironmentSettings {
  final String chainUrl;

  const EvmNetworkEnvironmentSettings({required this.chainUrl});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EvmNetworkEnvironmentSettings && chainUrl == other.chainUrl;
}
