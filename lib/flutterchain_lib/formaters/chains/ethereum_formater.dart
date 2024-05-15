import 'dart:math';

class EthereumFormater {
  
  static double convertWeiToEth(int wei) {
    double eth = wei * pow(10, -18).toDouble();
    return eth;
  }

  static int convertEthToWei(double eth) {
    int wei = eth ~/ pow(10, -18);
    return wei;
  }
}
