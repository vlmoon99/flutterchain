import 'package:flutter_test/flutter_test.dart';
import 'package:flutterchain/flutterchain_lib/formaters/chains/near_formater.dart';

void main() {
  group('NearFormatter tests', () {
    test('Test converting yoctoNEAR to NEAR', () {
      const yoctoNearAmount = '1000000000000000000000000';
      const expectedNearAmount = '1.00000';
      final actualNearAmount = NearFormatter.yoctoNearToNear(yoctoNearAmount);
      expect(actualNearAmount, expectedNearAmount);
    });

    test('Test converting NEAR to yoctoNEAR', () {
      final nearAmount = double.tryParse('1.00000')?.round() ?? 1;
      const expectedYoctoNearAmount = '1000000000000000000000000';
      final actualYoctoNearAmount =
          NearFormatter.nearToYoctoNear(nearAmount.toString());
      expect(actualYoctoNearAmount, expectedYoctoNearAmount);
    });
  });
}
