import 'package:flutterchain/flutterchain_lib/models/core/transfer_request.dart';

class NearTransferRequest implements TransferRequest {
  final String? accountId;
  final String publicKey;
  final String privateKey;

  final String toAddress;
  final String transferAmount;

  String? gas;

  NearTransferRequest({
    this.accountId,
    required this.publicKey,
    required this.privateKey,
    required this.toAddress,
    required this.transferAmount,
    this.gas,
  });
}
