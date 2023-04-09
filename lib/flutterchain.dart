
import 'flutterchain_platform_interface.dart';

class Flutterchain {
  Future<String?> getPlatformVersion() {
    return FlutterchainPlatform.instance.getPlatformVersion();
  }
}
