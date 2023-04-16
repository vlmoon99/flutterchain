import 'dart:convert';

import 'package:flutterchain/flutterchain_lib/formaters/near_formater.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'near_blockchain_response.g.dart';

@JsonSerializable()
class NearReceiptOutcome {
  final String id;
  final Map<String, dynamic> outcome;

  NearReceiptOutcome({required this.id, required this.outcome});

  factory NearReceiptOutcome.fromJson(Map<String, dynamic> json) =>
      _$NearReceiptOutcomeFromJson(json);

  Map<String, dynamic> toJson() => _$NearReceiptOutcomeToJson(this);
}

@JsonSerializable()
class NearTransaction {
  final List<dynamic> actions;
  final String hash;
  final int nonce;
  final String publicKey;
  final String receiverId;
  final String signature;
  final String signerId;

  NearTransaction({
    required this.actions,
    required this.hash,
    required this.nonce,
    required this.publicKey,
    required this.receiverId,
    required this.signature,
    required this.signerId,
  });

  factory NearTransaction.fromJson(Map<String, dynamic> json) =>
      _$NearTransactionFromJson(json);

  Map<String, dynamic> toJson() => _$NearTransactionToJson(this);
}

@JsonSerializable()
class NearTransactionOutcome {
  final String id;
  final Map<String, dynamic> outcome;

  NearTransactionOutcome({required this.id, required this.outcome});

  factory NearTransactionOutcome.fromJson(Map<String, dynamic> json) =>
      _$NearTransactionOutcomeFromJson(json);

  Map<String, dynamic> toJson() => _$NearTransactionOutcomeToJson(this);
}

extension BlockchainResponseExtension on BlockchainResponse {
  List<NearReceiptOutcome> get nearReceiptsOutcome =>
      (data['receipts_outcome'] as List)
          .map((e) => NearReceiptOutcome.fromJson(e as Map<String, dynamic>))
          .toList();

  NearTransaction get nearTransaction =>
      NearTransaction.fromJson(data['transaction'] as Map<String, dynamic>);

  NearTransactionOutcome get nearTransactionOutcome =>
      NearTransactionOutcome.fromJson(
          data['transaction_outcome'] as Map<String, dynamic>);

  Map<String, dynamic> get nearTransactionStatus =>
      data['status'] as Map<String, dynamic>;

  String get nearSuccessValue {
    final successValue = nearTransactionStatus['SuccessValue'];
    final decodedResponse = successValue != null
        ? NearFormatter.decodeResultOfResponse(successValue)
        : 'No data in response';
    return decodedResponse;
  }
}
