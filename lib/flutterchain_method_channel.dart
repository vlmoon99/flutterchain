import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutterchain_platform_interface.dart';

/// An implementation of [FlutterchainPlatform] that uses method channels.
class MethodChannelFlutterchain extends FlutterchainPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutterchain');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
