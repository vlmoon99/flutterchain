import 'package:flutterchain/flutterchain_lib/models/core/blockchain_network_environment_settings.dart';

class XrpNetworkEnvironmentSettings
    implements BlockChainNetworkEnvironmentSettings {
  final String chainUrl;

  const XrpNetworkEnvironmentSettings({required this.chainUrl});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is XrpNetworkEnvironmentSettings && chainUrl == other.chainUrl;
}
