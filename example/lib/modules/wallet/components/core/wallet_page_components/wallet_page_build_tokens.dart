import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../assets/icon_images/icons.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class BuilTokens extends StatelessWidget {
  const BuilTokens({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    double screenWidth = MediaQuery.of(context).size.width;

    List<Map<dynamic, dynamic>> tokens = [
      {
        'icon': AppIcon(
          iconType: IconType.nearIcon,
          size: 40.h,
        ),
        'name': "NEAR",
        'price': '\$6.34',
        'amount': '198.24 NEAR',
        'change': '^ 2.6%',
        'total price': '\$1251.44'
      },
      {
        'icon': AppIcon(
          iconType: IconType.octopusIcon,
          size: 40.h,
        ),
        'name': "Octopus Network",
        'price': '\$0.34',
        'amount': '0.6317 OCT',
        'change': '^ 3.6%',
        'total price': '\$0.70'
      },
      {
        'icon': AppIcon(
          iconType: IconType.deipIcon,
          size: 40.h,
        ),
        'name': "DEIP Token",
        'price': '\$0.34',
        'amount': '555.94874 DEIP',
        'change': '⌄  0,97%',
        'total price': '\$0.76'
      },
      {
        'icon': AppIcon(
          iconType: IconType.auroraIcon,
          size: 40.h,
        ),
        'name': "Aurora",
        'price': '\$6.34',
        'amount': '300 Aurora',
        'change': '^ 2.6%',
        'total price': '\$1137'
      },
      {
        'icon': AppIcon(
          iconType: IconType.usnIcon,
          size: 40.h,
        ),
        'name': "USN",
        'price': '\$1.33',
        'amount': '205 USN',
        'change': '^ 38.76%',
        'total price': '\$276.65'
      },
      {
        'icon': AppIcon(
          iconType: IconType.nearIcon,
          size: 40.h,
        ),
        'name': "NEAR",
        'price': '\$6.34',
        'amount': '198.24 NEAR',
        'change': '^ 2.6%',
        'total price': '\$1251.44'
      },
      {
        'icon': AppIcon(
          iconType: IconType.octopusIcon,
          size: 40.h,
        ),
        'name': "Octopus Network",
        'price': '\$0.34',
        'amount': '0.6317 OCT',
        'change': '^ 3.6%',
        'total price': '\$0.70'
      },
      {
        'icon': AppIcon(
          iconType: IconType.deipIcon,
          size: 40.h,
        ),
        'name': "DEIP Token",
        'price': '\$0.34',
        'amount': '555.94874 DEIP',
        'change': ' ⌄  0,97%',
        'total price': '\$0.76'
      },
      {
        'icon': AppIcon(
          iconType: IconType.auroraIcon,
          size: 40.h,
        ),
        'name': "Aurora",
        'price': '\$6.34',
        'amount': '300 Aurora',
        'change': '^ 2.6%',
        'total price': '\$1137'
      },
      {
        'icon': AppIcon(
          iconType: IconType.usnIcon,
          size: 40.h,
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
        thickness: 0.2,
      ),
      itemCount: tokens.length,
      itemBuilder: (context, index) {
        final token = tokens[index];

        return Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
          child: Row(
            children: [
              token['icon'] as Widget,
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      token['name']!,
                      style: nearTextStyles.highlight!.copyWith(
                          color: nearColors.nearBlack,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp),
                    ),
                    Row(
                      children: [
                        Text(
                          token['price']!,
                          style: nearTextStyles.highlight!
                              .copyWith(fontSize: 12.sp),
                        ),
                        SizedBox(width: 3.w),
                        Text(
                          token['change']!,
                          style: nearTextStyles.highlight!.copyWith(
                              color: token['change']!.contains('⌄ ')
                                  ? nearColors.nearRed
                                  : nearColors.nearGreen,
                              fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    token['amount']!,
                    style: nearTextStyles.label!.copyWith(
                      color: nearColors.nearBlack,
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    token['total price']!,
                    style: nearTextStyles.label!.copyWith(
                      color: nearColors.nearGray,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
