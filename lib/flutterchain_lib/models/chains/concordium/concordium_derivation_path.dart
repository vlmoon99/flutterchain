import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:json_annotation/json_annotation.dart';
part 'concordium_derivation_path.g.dart';

@JsonSerializable()
class ConcordiumDerivationPath implements DerivationPathData {
  final int identityProviderIndex;
  final int identityIndex;
  final int credentialIndex;

  ConcordiumDerivationPath({
    required this.identityProviderIndex,
    this.identityIndex = 0,
    this.credentialIndex = 0,
  });

  factory ConcordiumDerivationPath.fromJson(Map<String, dynamic> json) =>
      _$ConcordiumDerivationPathFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ConcordiumDerivationPathToJson(this);

  @override
  String toString() {
    return 'identityProviderIndex: $identityProviderIndex, identityIndex: $identityIndex, credentialIndex: $credentialIndex';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConcordiumDerivationPath &&
          identityIndex == other.identityIndex &&
          identityProviderIndex == other.identityProviderIndex &&
          credentialIndex == other.credentialIndex;

  @override
  int get hashCode =>
      identityIndex.hashCode ^
      identityProviderIndex.hashCode ^
      credentialIndex.hashCode;

  @override
  String get typeOfDerivationPath => 'concordium';
}
