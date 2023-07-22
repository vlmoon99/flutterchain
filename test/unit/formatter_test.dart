import 'package:flutter_test/flutter_test.dart';
import 'package:flutterchain/flutterchain_lib/formaters/chains/near_formater.dart';

void main() {
  group('NearFormatter tests', () {
    test('Test converting yoctoNEAR to NEAR - case 1', () {
      const yoctoNearAmount = '1000000000000000000000000';
      const expectedNearAmount = '1';
      final actualNearAmount = NearFormatter.yoctoNearToNear(yoctoNearAmount);
      expect(actualNearAmount, expectedNearAmount);
    });

    test('Test converting yoctoNEAR to NEAR - case 2', () {
      const yoctoNearAmount = '20000000000000000000000000';
      const expectedNearAmount = '20';
      final actualNearAmount = NearFormatter.yoctoNearToNear(yoctoNearAmount);
      expect(actualNearAmount, expectedNearAmount);
    });

    test('Test converting yoctoNEAR to NEAR - case 3', () {
      const yoctoNearAmount = '123456789123456789123456789';
      const expectedNearAmount = '123.45679';
      final actualNearAmount = NearFormatter.yoctoNearToNear(yoctoNearAmount);
      expect(actualNearAmount, expectedNearAmount);
    });

    test('Test converting NEAR to yoctoNEAR - case 1', () {
      final nearAmount = double.tryParse('1')?.round() ?? 1;
      const expectedYoctoNearAmount = '1000000000000000000000000';
      final actualYoctoNearAmount =
          NearFormatter.nearToYoctoNear(nearAmount.toString());
      expect(actualYoctoNearAmount, expectedYoctoNearAmount);
    });

    test('Test converting NEAR to yoctoNEAR - case 2', () {
      final nearAmount = double.tryParse('20')?.round() ?? 20;
      const expectedYoctoNearAmount = '20000000000000000000000000';
      final actualYoctoNearAmount =
          NearFormatter.nearToYoctoNear(nearAmount.toString());
      expect(actualYoctoNearAmount, expectedYoctoNearAmount);
    });

    test('Test converting NEAR to yoctoNEAR - case 3', () {
      final nearAmount = double.tryParse('123.45679')?.round() ?? 123;
      const expectedYoctoNearAmount = '123000000000000000000000000';
      final actualYoctoNearAmount =
          NearFormatter.nearToYoctoNear(nearAmount.toString());
      expect(actualYoctoNearAmount, expectedYoctoNearAmount);
    });

    test('Test converting yoctoNEAR to NEAR - small amount 1', () {
      const yoctoNearAmount = '100000000000000000000000';
      const expectedNearAmount = '0.10000';
      final actualNearAmount = NearFormatter.yoctoNearToNear(yoctoNearAmount);
      expect(actualNearAmount, expectedNearAmount);
    });

    test('Test converting yoctoNEAR to NEAR - small amount 2', () {
      const yoctoNearAmount = '10000000000000000000000';
      const expectedNearAmount = '0.01000';
      final actualNearAmount = NearFormatter.yoctoNearToNear(yoctoNearAmount);
      expect(actualNearAmount, expectedNearAmount);
    });

    test('Test converting yoctoNEAR to NEAR - small amount 3', () {
      const yoctoNearAmount = '1000000000000000000000';
      const expectedNearAmount = '0.00100';
      final actualNearAmount = NearFormatter.yoctoNearToNear(yoctoNearAmount);
      expect(actualNearAmount, expectedNearAmount);
    });

    test('Test converting NEAR to yoctoNEAR - small amount 1', () {
      final nearAmount = double.tryParse('0.1');
      const expectedYoctoNearAmount = '100000000000000000000000';
      final actualYoctoNearAmount =
          NearFormatter.nearToYoctoNear(nearAmount.toString());
      expect(actualYoctoNearAmount, expectedYoctoNearAmount);
    });

    test('Test converting NEAR to yoctoNEAR - small amount 2', () {
      final nearAmount = double.tryParse('0.01');
      const expectedYoctoNearAmount = '10000000000000000000000';
      final actualYoctoNearAmount =
          NearFormatter.nearToYoctoNear(nearAmount.toString());
      expect(actualYoctoNearAmount, expectedYoctoNearAmount);
    });

    test('Test converting NEAR to yoctoNEAR - small amount 3', () {
      final nearAmount = double.tryParse('0.001');
      const expectedYoctoNearAmount = '1000000000000000000000';
      final actualYoctoNearAmount =
          NearFormatter.nearToYoctoNear(nearAmount.toString());
      expect(actualYoctoNearAmount, expectedYoctoNearAmount);
    });
  });
}
