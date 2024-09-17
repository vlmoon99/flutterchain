import 'package:flutter/material.dart';

enum NearNetworkType { testnet, mainnet }

@immutable
class AuthInfo {
  final String accountId;
  final String publicKey;
  final String secretKey;
  final String privateKey;
  final NearNetworkType networkType;

  const AuthInfo({
    this.accountId = "",
    this.publicKey = "",
    this.secretKey = "",
    this.privateKey = "",
    this.networkType = NearNetworkType.testnet,
  });

  AuthInfo copyWith({
    String? accountId,
    String? publicKey,
    String? secretKey,
    String? privateKey,
    NearNetworkType? networkType,
  }) {
    return AuthInfo(
      accountId: accountId ?? this.accountId,
      publicKey: publicKey ?? this.publicKey,
      secretKey: secretKey ?? this.secretKey,
      privateKey: privateKey ?? this.privateKey,
      networkType: networkType ?? this.networkType,
    );
  }
}
