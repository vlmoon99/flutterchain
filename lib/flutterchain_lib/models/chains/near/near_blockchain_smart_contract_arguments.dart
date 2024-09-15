import 'package:flutterchain/flutterchain_lib/models/core/blockchain_smart_contract_arguments.dart';

class NearBlockChainSmartContractArguments
    implements BlockChainSmartContractArguments {
  final String? accountId;
  final String publicKey;
  final String privateKey;
  final String toAddress;
  final String method;
  final Map<String, dynamic> args;
  final String transferAmount;
  final String? gas;

  NearBlockChainSmartContractArguments({
    this.accountId,
    required this.publicKey,
    required this.toAddress,
    required this.privateKey,
    this.gas,
    required this.method,
    required this.args,
    required this.transferAmount,
  });
}

class RawNearBlockChainSmartContractArguments implements RawBlockChainSmartContractArguments {
  final String method;
  final Map<String, dynamic> args;
  final String transferAmount;
  final String? gas;

  RawNearBlockChainSmartContractArguments({
    required this.method,
    required this.args,
    required this.transferAmount,
    this.gas,
  });
}
