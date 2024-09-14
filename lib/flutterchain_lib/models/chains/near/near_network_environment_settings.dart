import 'package:flutterchain/flutterchain_lib/models/core/blockchain_network_environment_settings.dart';

class NearNetworkEnvironmentSettings
    implements BlockChainNetworkEnvironmentSettings {
  final String chainUrl;

  NearNetworkEnvironmentSettings({required this.chainUrl});
}
