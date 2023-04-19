// TODO Check and re-wtite tests (on demand)
import 'dart:convert';

class NearFormatter {
  static String yoctoNearToNear(String yoctoNearAmount) {
    BigInt yoctoNear = BigInt.parse(yoctoNearAmount);
    String yoctoNearString = yoctoNear.toString();
    String integerPart =
        yoctoNearString.substring(0, yoctoNearString.length - 24);
    String decimalPart = yoctoNearString.substring(yoctoNearString.length - 24);

    if (decimalPart == '0') {
      return integerPart;
    } else {
      int endIndex = decimalPart.length;
      for (int i = decimalPart.length - 1; i >= 0; i--) {
        if (decimalPart[i] != '0') {
          endIndex = i + 1;
          break;
        }
      }
      decimalPart = decimalPart.substring(0, endIndex);
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

  // static String yoctoNearToNear(String yoctoNearAmount) {
  //   BigInt yoctoNear = BigInt.parse(yoctoNearAmount);
  //   BigInt near = yoctoNear ~/ BigInt.from(10).pow(24);
  //   BigInt remainder = yoctoNear % BigInt.from(10).pow(24);
  //   String nearAmount =
  //       '$near.${remainder.toString().padLeft(24, '0').substring(0, 5)}';
  //   return nearAmount;
  // }

  // static String nearToYoctoNear(String nearAmount) {
  //   if (nearAmount == '0') {
  //     return '0';
  //   }
  //   BigInt near = BigInt.parse(nearAmount);
  //   BigInt yoctoNear = near * BigInt.from(10).pow(24);
  //   return yoctoNear.toString();
  // }

  static String decodeResultOfResponse(String successValue) {
    if (successValue.isEmpty) {
      return 'none data in response';
    }
    final decodedRes = utf8.decode(base64.decode(successValue));
    return decodedRes.substring(1, decodedRes.length - 1);
  }
}
