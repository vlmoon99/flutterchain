// TODO Check and re-wtite tests (on demand)
import 'dart:convert';

class NearFormatter {
  static String yoctoNearToNear(String yoctoNearAmount) {
    BigInt yoctoNear = BigInt.parse(yoctoNearAmount);
    BigInt near = yoctoNear ~/ BigInt.from(10).pow(24);
    BigInt remainder = yoctoNear % BigInt.from(10).pow(24);
    String nearAmount =
        '$near.${remainder.toString().padLeft(24, '0').substring(0, 5)}';
    return nearAmount;
  }

  static String nearToYoctoNear(String nearAmount) {
    if (nearAmount == '0') {
      return '0';
    }
    BigInt near = BigInt.parse(nearAmount);
    BigInt yoctoNear = near * BigInt.from(10).pow(24);
    return yoctoNear.toString();
  }

  static String decodeResultOfResponse(String successValue) {
    if (successValue.isEmpty) {
      return 'none data in response';
    }
    final decodedRes = utf8.decode(base64.decode(successValue));
    return decodedRes.substring(1, decodedRes.length - 1);
  }
}
