import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../../../assets/icon_images/icons.dart';
import 'package:flutterchain_example/theme/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildActionButtons(
  BuildContext context,
  AppIcon icon,
  String label,
) {
  final theme = Modular.get<AppTheme>();
  final nearColors = theme.getTheme().extension<NearColors>()!;
  final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
  double screenWidth = MediaQuery.of(context).size.width;
  return Column(
    children: [
      Container(
        // padding: EdgeInsets.all(16.w),
        child: icon,
      ),
      Text(
        label,
        style: nearTextStyles.label!.copyWith(
            color: nearColors.nearBlack,
            fontSize: screenWidth < 500 ? 14.sp : 15.sp),
      ),
    ],
  );
}
