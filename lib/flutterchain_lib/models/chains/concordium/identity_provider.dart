class IdentityProvider {
  final Map<String, dynamic> arsInfos;
  final Map<String, dynamic> ipInfo;
  final Map<String, dynamic> metadata;

  IdentityProvider(
      {required this.arsInfos, required this.ipInfo, required this.metadata});

  factory IdentityProvider.fromJson(Map<String, dynamic> json) {
    return IdentityProvider(
        arsInfos: json['arsInfos'],
        ipInfo: json['ipInfo'],
        metadata: json['metadata']);
  }

  Map<String, dynamic> toJson() =>
      {'arsInfos': arsInfos, 'ipInfo': ipInfo, 'metadata': metadata};

  @override
  String toString() {
    return 'IdentityProvider{arsInfos: $arsInfos, ipInfo: $ipInfo, metadata: $metadata}';
  }
}
