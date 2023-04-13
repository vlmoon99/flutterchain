// TODO Check and re-wtite tests (on demand)
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
    BigInt near = BigInt.parse(nearAmount);
    BigInt yoctoNear = near * BigInt.from(10).pow(24);
    return yoctoNear.toString();
  }
}
