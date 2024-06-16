class XrpFormatter {
  static const int DROPS_PER_XRP = 1000000;

  static int xrpToDrops(double xrp) {
    // double.parse(xrp.toStringAsFixed(2))
    return (xrp * DROPS_PER_XRP).toInt();
  }

  static double dropsToXrp(int drops) {
    return drops / DROPS_PER_XRP;
  }
}
