import 'package:chain_signatures_example/constants/routs.dart';
import 'package:chain_signatures_example/constants/storage_keys.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: MainRoutes.auth);
  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    final secureStorage = Modular.get<FlutterSecureStorage>();
    String? value = await secureStorage.read(key: SecureStorageKeys.authInfo);
    if (value?.isNotEmpty ?? false) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }
}
