import 'package:flutterchain/flutterchain_lib/models/core/blockchain_network_environment_settings.dart';

class EvmNetworkEnvironmentSettings
    implements BlockChainNetworkEnvironmentSettings {
  final String chainUrl;

  EvmNetworkEnvironmentSettings({required this.chainUrl});
}
