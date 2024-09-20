class ConcordiumFormatter {
  static int convertMicroCcdToCcd(int microCcd) {
    return microCcd ~/ 1000000;
  }

  static int convertCcdToMicroCcd(int ccd) {
    return ccd * 1000000;
  }
}
