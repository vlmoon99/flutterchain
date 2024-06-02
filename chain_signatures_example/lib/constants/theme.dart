import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  static const Color black = Color(0xff272729);
  static const Color onBlack = Color(0xffe3dfdf);
  static const Color lightGrey = Color(0xfff3f5f6);
  static const Color darkGrey = Color(0xffe6e8e9);
  static const Color white = Color(0xffffffff);
  static const Color greyTextColor = Color(0xff8c8d99);
}

ThemeData get appTheme => ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: AppColors.black,
        onPrimary: AppColors.onBlack,
        surface: AppColors.darkGrey,
        onSurface: AppColors.black,
        background: AppColors.lightGrey,
        onBackground: AppColors.black,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightGrey,
        foregroundColor: AppColors.black,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12).r,
            ),
          ),
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12).r,
        ),
      )
    );
