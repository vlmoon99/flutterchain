import 'package:flutterchain/flutterchain_lib/models/core/transfer_request.dart';

class ConcordiumTransferRequest implements TransferRequest {
  final String senderAddress;
  final String toAddress;
  final int transferAmountInMicroCcd;
  final String privateKey;

  ConcordiumTransferRequest({
    required this.senderAddress,
    required this.toAddress,
    required this.transferAmountInMicroCcd,
    required this.privateKey,
  });
}
