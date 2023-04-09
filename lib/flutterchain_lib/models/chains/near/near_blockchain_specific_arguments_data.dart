import 'package:flutterchain/flutterchain_lib/models/core/blockchain_specific_data.dart';

class NearBlockChainSpecificArgumentsData
    implements BlockChainSpecificArgumentsData {
  final String privateKey;

  final String gas;

  final int nonce;

  final String blockHash;

  final List<Map<String, dynamic>> actions;

  NearBlockChainSpecificArgumentsData({
    required this.privateKey,
    required this.gas,
    required this.nonce,
    required this.blockHash,
    required this.actions,
  });
}
