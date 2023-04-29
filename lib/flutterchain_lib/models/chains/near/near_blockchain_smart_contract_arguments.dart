import 'package:flutterchain/flutterchain_lib/models/core/blockchain_smart_contract_arguments.dart';

class NearBlockChainSmartContractArguments
    extends BlockChainSmartContractArguments {
  final String method;
  final Map<String, dynamic> args;
  final String transferAmount;

  NearBlockChainSmartContractArguments({
    required this.method,
    required this.args,
    required this.transferAmount,
  });
}
