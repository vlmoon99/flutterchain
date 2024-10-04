import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterchain_example/assets/images/icons.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

Widget buildTokens() {
  final theme = Modular.get<AppTheme>();
  final nearColors = theme.getTheme().extension<NearColors>()!;
  final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;

  List<Map<dynamic, dynamic>> tokens = [
    {
      'icon': const AppIcon(
        iconType: IconType.nearIcon,
        size: 40,
      ),
      'name': "NEAR",
      'price': '\$6.34',
      'amount': '198.24 NEAR',
      'change': '^ 2.6%',
      'total price': '\$1251.44'
    },
    {
      'icon': const AppIcon(
        iconType: IconType.octopusIcon,
        size: 40,
      ),
      'name': "Octopus Network",
      'price': '\$0.34',
      'amount': '0.6317 OCT',
      'change': '^ 3.6%',
      'total price': '\$0.70'
    },
    {
      'icon': const AppIcon(
        iconType: IconType.deipIcon,
        size: 40,
      ),
      'name': "DEIP Token",
      'price': '\$0.34',
      'amount': '555.94874 DEIP',
      'change': '⌄  0,97%',
      'total price': '\$0.76'
    },
    {
      'icon': const AppIcon(
        iconType: IconType.auroraIcon,
        size: 40,
      ),
      'name': "Aurora",
      'price': '\$6.34',
      'amount': '300 Aurora',
      'change': '^ 2.6%',
      'total price': '\$1137'
    },
    {
      'icon': const AppIcon(
        iconType: IconType.usnIcon,
        size: 40,
      ),
      'name': "USN",
      'price': '\$1.33',
      'amount': '205 USN',
      'change': '^ 38.76%',
      'total price': '\$276.65'
    }
  ];

  return ListView.separated(
    separatorBuilder: (context, index) => Divider(
      color: nearColors.nearGray,
      thickness: 0.1,
    ),
    itemCount: tokens.length,
    itemBuilder: (context, index) {
      final token = tokens[index];
      return ListTile(
        leading: token['icon'] as Widget,
        title: Text(
          token['name']!,
          style: nearTextStyles.highlight!.copyWith(
              color: nearColors.nearBlack, fontWeight: FontWeight.w700),
        ),
        subtitle: Row(
          children: [
            Text(
              token['price']!,
            ),
            SizedBox(
              width: 3.w,
            ),
            Text(
              token['change']!,
              style: TextStyle(
                  color: token['change']!.contains('⌄ ')
                      ? Colors.red
                      : Colors.green),
            ),
          ],
        ),
        trailing: Column(
          children: [
            Text(token['amount']!,
                style: nearTextStyles.label!.copyWith(
                    color: nearColors.nearBlack,
                    fontWeight: FontWeight.w700,
                    fontSize: 10.sp)),
            Text(token['total price']!,
                style: nearTextStyles.label!
                    .copyWith(color: nearColors.nearGray, fontSize: 12.sp)),
          ],
        ),
      );
    },
  );
}
