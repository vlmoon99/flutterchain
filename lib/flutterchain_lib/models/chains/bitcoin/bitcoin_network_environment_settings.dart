import 'package:flutterchain/flutterchain_lib/models/core/blockchain_network_environment_settings.dart';

class BitcoinNetworkEnvironmentSettings
    implements BlockChainNetworkEnvironmentSettings {
  final String chainUrl;

  const BitcoinNetworkEnvironmentSettings({required this.chainUrl});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BitcoinNetworkEnvironmentSettings && chainUrl == other.chainUrl;
}
