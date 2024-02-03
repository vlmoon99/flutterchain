import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutterchain_method_channel.dart';

abstract class FlutterchainPlatform extends PlatformInterface {
  /// Constructs a FlutterchainPlatform.
  FlutterchainPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterchainPlatform _instance = MethodChannelFlutterchain();

  /// The default instance of [FlutterchainPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterchain].
  static FlutterchainPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterchainPlatform] when
  /// they register themselves.
  static set instance(FlutterchainPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
