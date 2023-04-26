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
                .toList()),
      ),
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'mnemonic': instance.mnemonic,
      'passphrase': instance.passphrase,
      'blockchainsData': instance.blockchainsData,
    };

BlockChainData _$BlockChainDataFromJson(Map<String, dynamic> json) =>
    BlockChainData(
      publicKey: json['publicKey'] as String,
      privateKey: json['privateKey'] as String,
      derivationPath: json['derivationPath'] as String,
      passphrase: json['passphrase'] as String,
    );

Map<String, dynamic> _$BlockChainDataToJson(BlockChainData instance) =>
    <String, dynamic>{
      'publicKey': instance.publicKey,
      'privateKey': instance.privateKey,
      'derivationPath': instance.derivationPath,
      'passphrase': instance.passphrase,
    };
