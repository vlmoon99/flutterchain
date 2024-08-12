class CreateIdentityRequestParams {
  final int v;
  final Map<String, dynamic> value;

  CreateIdentityRequestParams({required this.v, required this.value});

  factory CreateIdentityRequestParams.fromJson(Map<String, dynamic> json) {
    return CreateIdentityRequestParams(
      v: json['v'],
      value: json['value'],
    );
  }
  Map<String, dynamic> toJson() => {'v': v, 'value': value};

  @override
  String toString() {
    return 'CreateIdentityRequestParams{v: $v, value: $value}';
  }
}
