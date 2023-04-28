// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      id: json['id'] as String,
      name: json['name'] as String,
      mnemonic: json['mnemonic'] as String,
      passphrase: json['passphrase'] as String?,
      blockchainsData: (json['blockchainsData'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
            k,
            (e as List<dynamic>)
                .map((e) => BlockChainData.fromJson(e as Map<String, dynamic>))
                .toSet()),
      ),
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mnemonic': instance.mnemonic,
      'passphrase': instance.passphrase,
      'blockchainsData':
          instance.blockchainsData?.map((k, e) => MapEntry(k, e.toList())),
    };

BlockChainData _$BlockChainDataFromJson(Map<String, dynamic> json) =>
    BlockChainData(
      publicKey: json['publicKey'] as String,
      privateKey: json['privateKey'] as String,
      derivationPath: DerivationPath.fromJson(
          json['derivationPath'] as Map<String, dynamic>),
      passphrase: json['passphrase'] as String,
    );

Map<String, dynamic> _$BlockChainDataToJson(BlockChainData instance) =>
    <String, dynamic>{
      'publicKey': instance.publicKey,
      'privateKey': instance.privateKey,
      'derivationPath': instance.derivationPath,
      'passphrase': instance.passphrase,
    };

DerivationPath _$DerivationPathFromJson(Map<String, dynamic> json) =>
    DerivationPath(
      accountNumber: json['accountNumber'] as String,
      change: json['change'] as String,
      address: json['address'] as String,
    );

Map<String, dynamic> _$DerivationPathToJson(DerivationPath instance) =>
    <String, dynamic>{
      'accountNumber': instance.accountNumber,
      'change': instance.change,
      'address': instance.address,
    };
