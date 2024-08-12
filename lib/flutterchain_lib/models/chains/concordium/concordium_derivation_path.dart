import 'package:json_annotation/json_annotation.dart';
part 'concordium_derivation_path.g.dart';

@JsonSerializable()
class ConcordiumDerivationPath {
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

  Map<String, dynamic> toJson() => _$ConcordiumDerivationPathToJson(this);

  @override
  String toString() {
    return 'identityProviderIndex: $identityProviderIndex, identityIndex: $identityIndex, credentialIndex: $credentialIndex';
  }
}
