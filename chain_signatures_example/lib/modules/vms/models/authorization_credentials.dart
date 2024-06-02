import 'package:chain_signatures_example/modules/vms/models/auth_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authorization_credentials.g.dart'; // This is the generated file, name it accordingly

@JsonSerializable()
class AuthorizationCredentials {
  final String accountId;
  final String secretKey;
  final NearNetworkType networkType;

  AuthorizationCredentials(this.accountId, this.secretKey, this.networkType);

  factory AuthorizationCredentials.fromJson(Map<String, dynamic> json) =>
      _$AuthorizationCredentialsFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizationCredentialsToJson(this);

  @override
  String toString() =>
      'AuthorizationCredentials(accountId: $accountId, secretKey: $secretKey, networkType: $networkType)';
}
