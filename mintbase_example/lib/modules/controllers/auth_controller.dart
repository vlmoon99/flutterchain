import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/near_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/consts/secure_storage_keys.dart';
import 'package:mintbase_example/modules/models/auth_info_model/auth_info.dart';
import 'package:rxdart/rxdart.dart';

class AuthController extends Disposable {
  final NearBlockChainService nearBlockChainService;
  final FlutterSecureStorage secureStorage;
  AuthController(this.nearBlockChainService, this.secureStorage);

  final BehaviorSubject<AuthInfo> _streamController =
      BehaviorSubject.seeded(const AuthInfo());

  Stream<AuthInfo> get stream => _streamController.stream.distinct();

  AuthInfo get state => _streamController.value;

  Future<void> loginDefault({
    required String accountId,
    required String secretKey,
    required NearNetworkType networkType,
  }) async {
    await nearBlockChainService.setBlockchainNetworkEnvironment(
      newUrl: networkType == NearNetworkType.mainnet
          ? NearBlockChainNetworkUrls.listOfUrls.elementAt(1)
          : NearBlockChainNetworkUrls.listOfUrls.first,
    );
    _streamController.add(state.copyWith(
      accountId: accountId,
      publicKey: accountId,
      secretKey: secretKey,
      privateKey: secretKey,
      networkType: networkType,
    ));
  }

  Future<void> loginWithMnemonic({
    required String accountId,
    required String publicKey,
    required String secretKey,
    required NearNetworkType networkType,
  }) async {
    await nearBlockChainService.setBlockchainNetworkEnvironment(
      newUrl: networkType == NearNetworkType.mainnet
          ? NearBlockChainNetworkUrls.listOfUrls.elementAt(1)
          : NearBlockChainNetworkUrls.listOfUrls.first,
    );

    _streamController.add(state.copyWith(
      accountId: accountId,
      publicKey: publicKey,
      secretKey: secretKey,
      privateKey: secretKey,
      networkType: networkType,
    ));
  }

  Future<void> login({
    required String accountId,
    required String secretKey,
    required NearNetworkType networkType,
  }) async {
    await nearBlockChainService.setBlockchainNetworkEnvironment(
      newUrl: networkType == NearNetworkType.mainnet
          ? NearBlockChainNetworkUrls.listOfUrls.elementAt(1)
          : NearBlockChainNetworkUrls.listOfUrls.first,
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
      networkType: networkType,
    ));
  }

  Future<void> logout() async {
    try {
      await secureStorage.delete(key: SecureStorageKeys.info);
    } catch (err) {
      rethrow;
    }
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
