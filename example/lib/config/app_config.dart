import 'package:rxdart/rxdart.dart';

class AppConfig {
  AppConfig() {
    _configStream.add(Config.getTestNetConfig());
  }
  final BehaviorSubject<Config> _configStream = BehaviorSubject<Config>();

  Config get config => _configStream.value;

  set setConfig(Config config) => _configStream.add(config);
}

class Config {
  final String baseUrl;

  const Config(this.baseUrl);

  static Config getMainNetConfig() =>
      const Config('https://rpc.mainnet.near.org');
  static Config getTestNetConfig() =>
      const Config('https://rpc.testnet.near.org');
}
