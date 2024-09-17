import 'package:flutterchain/flutterchain_lib/models/core/transfer_request.dart';

class BitcoinTransferRequest implements TransferRequest {
  final String privateKey;
  final String publicKey;
  final String toAddress;
  final String transferAmount;

  BitcoinTransferRequest({
    required this.privateKey,
    required this.publicKey,
    required this.toAddress,
    required this.transferAmount,
  });
}
