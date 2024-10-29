class IdentityInfo {
  final Map<String, dynamic> attributeList;
  final Map<String, dynamic> preIdentityObject;
  final String signature;

  IdentityInfo(
      {required this.attributeList,
      required this.preIdentityObject,
      required this.signature});

  factory IdentityInfo.fromJson(Map<String, dynamic> json) {
    return IdentityInfo(
      attributeList: json['attributeList'],
      preIdentityObject: json['preIdentityObject'],
      signature: json['signature'],
    );
  }

  Map<String, dynamic> toJson() => {
        'attributeList': attributeList,
        'preIdentityObject': preIdentityObject,
        'signature': signature,
      };

  @override
  String toString() {
    return 'IdentityInfo{attributeList: $attributeList, preIdentityObject: $preIdentityObject, signature: $signature}';
  }
}
