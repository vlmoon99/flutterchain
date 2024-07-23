import 'package:json_annotation/json_annotation.dart';
import 'package:mintbase_example/modules/models/models.dart';

part 'authorized.g.dart';

@JsonSerializable()
class Authorized {
  final String accountId;
  final String secretKey;
  final NearNetworkType networkType;
  Authorized(this.accountId, this.secretKey, this.networkType);

  factory Authorized.fromJson(Map<String, dynamic> json) =>
      _$AuthorizedFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizedToJson(this);

  @override
  String toString() =>
      'AuthorizationCredentials(accountId: $accountId, secretKey: $secretKey, networkType: $networkType)';
}
