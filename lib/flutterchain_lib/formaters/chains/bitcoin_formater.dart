import 'dart:convert';

class BitcoinFormatter {
  static String satoshiToBitcoin(String satoshiAmount) {
    BigInt satoshi = BigInt.parse(satoshiAmount);
    double bitcoinAmount = satoshi / BigInt.from(100000000);
    return bitcoinAmount.toString();
  }

  static String bitcoinToSatoshi(String bitcoinAmount) {
    double bitcoin = double.parse(bitcoinAmount);
    BigInt satoshi = (bitcoin * 100000000).toInt().toBigInt();
    return satoshi.toString();
  }

  static String decodeResultOfResponse(String successValue) {
    if (successValue.isEmpty || successValue == 'null') {
      return 'none data in response';
    }
    final decodedRes = utf8.decode(base64.decode(successValue));
    return decodedRes;
  }
}

extension on int {
  BigInt toBigInt() => BigInt.from(this);
}
