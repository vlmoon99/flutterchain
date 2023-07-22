import 'dart:convert';

class NearFormatter {
  static String yoctoNearToNear(String yoctoNearAmount) {
    BigInt yoctoNear = BigInt.parse(yoctoNearAmount);
    String yoctoNearString = yoctoNear
        .toString()
        .padLeft(25, '0'); // pad with leading zeroes if needed

    String integerPart =
        yoctoNearString.substring(0, yoctoNearString.length - 24);
    String decimalPart = yoctoNearString.substring(yoctoNearString.length - 24);

    decimalPart =
        decimalPart.replaceAll(RegExp(r'0*$'), ''); // remove trailing zeros

    if (decimalPart.isEmpty) {
      return integerPart;
    } else {
      return double.tryParse('$integerPart.$decimalPart')?.toStringAsFixed(5) ??
          '0';
    }
  }

  static String nearToYoctoNear(String nearAmount) {
    if (nearAmount == '0') {
      return '0';
    }

    int decimalIndex = nearAmount.indexOf('.');
    if (decimalIndex == -1) {
      BigInt near = BigInt.parse(nearAmount);
      BigInt yoctoNear = near * BigInt.from(10).pow(24);
      return yoctoNear.toString();
    } else {
      String integerPart = nearAmount.substring(0, decimalIndex);
      String decimalPart = nearAmount.substring(decimalIndex + 1);
      if (decimalPart.length <= 24) {
        decimalPart = decimalPart.padRight(24, '0');
      } else {
        decimalPart = decimalPart.substring(0, 24);
      }
      BigInt near = BigInt.parse('$integerPart$decimalPart');
      BigInt yoctoNear = near * BigInt.from(10).pow(24 - decimalPart.length);
      return yoctoNear.toString();
    }
  }

  static String decodeResultOfResponse(String successValue) {
    if (successValue.isEmpty || successValue == 'null') {
      return 'none data in response';
    }
    final decodedRes = utf8.decode(base64.decode(successValue));
    return decodedRes;
  }
}
