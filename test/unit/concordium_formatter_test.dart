import 'package:flutter_test/flutter_test.dart';
import 'package:flutterchain/flutterchain_lib/formaters/chains/concordium_formatter.dart';

void main() {
  group("ConcordiumFormatter tests", () {
    test("Convert micro Ccd to Ccd", () {
      expect(ConcordiumFormatter.convertMicroCcdToCcd(1000000), 1);
    });

    test("Convert Ccd to micro Ccd", () {
      expect(ConcordiumFormatter.convertCcdToMicroCcd(1), 1000000);
    });
  });
}
