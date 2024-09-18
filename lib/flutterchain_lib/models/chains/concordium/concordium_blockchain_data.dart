import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_derivation_path.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:json_annotation/json_annotation.dart';
part 'concordium_blockchain_data.g.dart';

@JsonSerializable()
class ConcordiumBlockChainData extends BlockChainData {
  final String accountAddress;

  factory ConcordiumBlockChainData.fromJson(Map<String, dynamic> json) =>
      _$ConcordiumBlockChainDataFromJson(json);

  ConcordiumBlockChainData({
    required this.accountAddress,
    required super.publicKey,
    required super.privateKey,
    required ConcordiumDerivationPath super.derivationPath,
    super.identifier = BlockChains.concordium,
  });

  @override
  Map<String, dynamic> toJson() => _$ConcordiumBlockChainDataToJson(this);

  @override
  String toString() {
    return 'ConcordiumBlockchainData(accountAddress: $accountAddress, publicKey: $publicKey, privateKey: $privateKey, derivationPath: $derivationPath)';
  }
}
