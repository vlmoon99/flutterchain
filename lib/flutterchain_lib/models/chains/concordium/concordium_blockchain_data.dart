import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_derivation_path.dart';
import 'package:json_annotation/json_annotation.dart';
part 'concordium_blockchain_data.g.dart';

@JsonSerializable()
class ConcordiumBlockchainData {
  final String mnemonic;
  final String accountAddress;
  final String publicKey;
  final String signingKey;
  final ConcordiumDerivationPath derivationPath;

  ConcordiumBlockchainData({
    required this.mnemonic,
    required this.accountAddress,
    required this.publicKey,
    required this.signingKey,
    required this.derivationPath,
  });

  factory ConcordiumBlockchainData.fromJson(Map<String, dynamic> json) =>
      _$ConcordiumBlockchainDataFromJson(json);

  Map<String, dynamic> toJson() => _$ConcordiumBlockchainDataToJson(this);

  @override
  String toString() {
    return 'ConcordiumBlockchainData(mnemonic: $mnemonic, accountAddress: $accountAddress, publicKey: $publicKey, signingKey: $signingKey, derivationPath: $derivationPath)';
  }
}
