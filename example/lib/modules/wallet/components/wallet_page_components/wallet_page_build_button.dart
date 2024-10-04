import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/assets/images/icons.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

Widget buildButton(BuildContext context, AppIcon icon, String label) {
  final theme = Modular.get<AppTheme>();
  final nearColors = theme.getTheme().extension<NearColors>()!;
  final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
  return Column(
    children: [
      Container(
        // padding: EdgeInsets.all(16.w),
        child: icon,
      ),
      Text(label,
          style: nearTextStyles.label!.copyWith(color: nearColors.nearBlack)),
    ],
  );
}
