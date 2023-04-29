import 'dart:convert';

import 'package:flutterchain/flutterchain_lib/constants/storage_keys.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain/flutterchain_lib/repositories/core/core_repository.dart';
import 'package:collection/collection.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class WalletRepository extends Repository<Wallet> {
  final FlutterSecureStorage secureStorage;

  WalletRepository({required this.secureStorage});

  factory WalletRepository.defaultInstance() {
    return WalletRepository(
      secureStorage: const FlutterSecureStorage(),
    );
  }
  @override
  Future<void> delete(String id) async {
    final wallets =
        (jsonDecode(await secureStorage.read(key: StorageKeys.wallets) ?? '[]')
                as List<dynamic>)
            .map((e) => Wallet.fromJson(e as Map<String, dynamic>))
            .toList();
    wallets.removeWhere((element) => element.id == id);
    secureStorage.write(key: StorageKeys.wallets, value: jsonEncode(wallets));
  }

  @override
  Future<void> deleteAll() async {
    secureStorage.delete(key: StorageKeys.wallets);
  }

  @override
  Future<Wallet> read(String id) async {
    final wallet =
        (jsonDecode(await secureStorage.read(key: StorageKeys.wallets) ?? '[]')
                as List<dynamic>)
            .map((e) => Wallet.fromJson(e as Map<String, dynamic>))
            .toList()
            .firstWhereOrNull((element) => element.id == id);

    if (wallet == null) {
      throw Exception("This Wallet doesn't exist");
    }

    return wallet;
  }

  @override
  Future<List<Wallet>> readAll() async {
    return (jsonDecode(
                await secureStorage.read(key: StorageKeys.wallets) ?? '[]')
            as List<dynamic>)
        .map((e) => Wallet.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> save(Wallet item) async {
    final wallets =
        (jsonDecode(await secureStorage.read(key: StorageKeys.wallets) ?? '[]')
                as List<dynamic>)
            .map((e) => Wallet.fromJson(e as Map<String, dynamic>))
            .toList();
    wallets.add(item);
    secureStorage.write(key: StorageKeys.wallets, value: jsonEncode(wallets));
  }

  @override
  Future<void> update(String id, Wallet item) async {
    final wallets =
        (jsonDecode(await secureStorage.read(key: StorageKeys.wallets) ?? '[]')
                as List<dynamic>)
            .map((e) => Wallet.fromJson(e as Map<String, dynamic>))
            .toList();
    wallets.removeWhere((element) => element.id == id);
    wallets.add(item);
    secureStorage.write(key: StorageKeys.wallets, value: jsonEncode(wallets));
  }

  @override
  Future<void> saveAll(List<Wallet> items) async {
    secureStorage.write(key: StorageKeys.wallets, value: jsonEncode(items));
  }
}
