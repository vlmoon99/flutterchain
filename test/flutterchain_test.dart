import 'package:flutter_test/flutter_test.dart';
import 'package:flutterchain/flutterchain.dart';
import 'package:flutterchain/flutterchain_platform_interface.dart';
import 'package:flutterchain/flutterchain_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterchainPlatform
    with MockPlatformInterfaceMixin
    implements FlutterchainPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterchainPlatform initialPlatform = FlutterchainPlatform.instance;

  test('$MethodChannelFlutterchain is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterchain>());
  });

  test('getPlatformVersion', () async {
    Flutterchain flutterchainPlugin = Flutterchain();
    MockFlutterchainPlatform fakePlatform = MockFlutterchainPlatform();
    FlutterchainPlatform.instance = fakePlatform;

    expect(await flutterchainPlugin.getPlatformVersion(), '42');
  });
}
