// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'concordium_derivation_path.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConcordiumDerivationPath _$ConcordiumDerivationPathFromJson(
        Map<String, dynamic> json) =>
    ConcordiumDerivationPath(
      identityProviderIndex: (json['identityProviderIndex'] as num).toInt(),
      identityIndex: (json['identityIndex'] as num?)?.toInt() ?? 0,
      credentialIndex: (json['credentialIndex'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ConcordiumDerivationPathToJson(
        ConcordiumDerivationPath instance) =>
    <String, dynamic>{
      'identityProviderIndex': instance.identityProviderIndex,
      'identityIndex': instance.identityIndex,
      'credentialIndex': instance.credentialIndex,
    };
