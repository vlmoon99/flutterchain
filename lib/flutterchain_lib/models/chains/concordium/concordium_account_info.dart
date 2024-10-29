class ConcordiumAccountInfo {
  final String type;
  final String accountAddress;
  final int accountNonce;
  // in microCcd
  final String accountAmount;
  final int accountIndex;
  final int accountThreshold;
  final String accountEncryptionKey;
  final Map<String, dynamic> accountEncryptedAmount;
  final Map<String, dynamic> accountReleaseSchedule;
  final Map<String, dynamic> accountCredentials;
  final Map<String, dynamic>? accountDelegation;
  final Map<String, dynamic>? accountBaker;

  ConcordiumAccountInfo({
    required this.type,
    required this.accountAddress,
    required this.accountNonce,
    required this.accountAmount,
    required this.accountIndex,
    required this.accountThreshold,
    required this.accountEncryptionKey,
    required this.accountEncryptedAmount,
    required this.accountReleaseSchedule,
    required this.accountCredentials,
    this.accountDelegation,
    this.accountBaker,
  });

  factory ConcordiumAccountInfo.fromJson(Map<String, dynamic> json) {
    return ConcordiumAccountInfo(
      type: json['type'],
      accountAddress: json['accountAddress'],
      accountNonce: json['accountNonce'],
      accountAmount: json['accountAmount'],
      accountIndex: json['accountIndex'],
      accountThreshold: json['accountThreshold'],
      accountEncryptionKey: json['accountEncryptionKey'],
      accountEncryptedAmount: json['accountEncryptedAmount'],
      accountReleaseSchedule: json['accountReleaseSchedule'],
      accountCredentials: json['accountCredentials'],
      accountDelegation: json['accountDelegation'],
      accountBaker: json['accountBaker'],
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'accountAddress': accountAddress,
        'accountNonce': accountNonce,
        'accountAmount': accountAmount,
        'accountIndex': accountIndex,
        'accountThreshold': accountThreshold,
        'accountEncryptionKey': accountEncryptionKey,
        'accountEncryptedAmount': accountEncryptedAmount,
        'accountReleaseSchedule': accountReleaseSchedule,
        'accountCredentials': accountCredentials,
        'accountDelegation': accountDelegation,
        'accountBaker': accountBaker,
      };

  @override
  String toString() => toJson().toString();
}
