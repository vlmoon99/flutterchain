import 'package:chain_signatures_example/constants/storage_keys.dart';
import 'package:chain_signatures_example/modules/vms/models/auth_info.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/near_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:rxdart/rxdart.dart';

class AuthController extends Disposable {
  final NearBlockChainService nearBlockChainService;
  final FlutterSecureStorage secureStorage;
  AuthController(this.nearBlockChainService, this.secureStorage);

  final BehaviorSubject<AuthInfo> _streamController =
      BehaviorSubject.seeded(const AuthInfo());

  Stream<AuthInfo> get stream => _streamController.stream.distinct();

  AuthInfo get state => _streamController.value;

  Future<void> login({
    required String accountId,
    required String secretKey,
    required NearNetworkType networkType,
  }) async {
    // try {
    await nearBlockChainService.setBlockchainNetworkEnvironment(
      NearNetworkEnvironmentSettings(
        chainUrl: networkType == NearNetworkType.mainnet
            ? NearBlockChainNetworkUrls.listOfUrls.elementAt(1)
            : NearBlockChainNetworkUrls.listOfUrls.first,
      ),
    );

    final privateKey = await nearBlockChainService
        .getPrivateKeyFromSecretKeyFromNearApiJSFormat(
      secretKey.split(":").last,
    );
    final publicKey = await nearBlockChainService
        .getPublicKeyFromSecretKeyFromNearApiJSFormat(
      secretKey.split(":").last,
    );

    _streamController.add(state.copyWith(
      accountId: accountId,
      publicKey: publicKey,
      secretKey: secretKey,
      privateKey: privateKey,
      status: AuthInfoStatus.authenticated,
      networkType: networkType,
    ));
    // } catch (err) {
    //   rethrow;
    // }
  }

  Future<void> logout() async {
    try {
      await secureStorage.delete(key: SecureStorageKeys.authInfo);
      _streamController.add(state.copyWith(
        status: AuthInfoStatus.unauthenticated,
      ));
    } catch (err) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
