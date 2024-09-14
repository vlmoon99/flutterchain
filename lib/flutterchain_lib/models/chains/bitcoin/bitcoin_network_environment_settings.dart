import 'package:flutterchain/flutterchain_lib/models/core/blockchain_network_environment_settings.dart';

class BitcoinNetworkEnvironmentSettings
    implements BlockChainNetworkEnvironmentSettings {
  final String chainUrl;

  BitcoinNetworkEnvironmentSettings({required this.chainUrl});
}
