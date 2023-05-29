import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class NearActionTextField extends StatefulWidget {
  const NearActionTextField({
    super.key,
    required this.textEditingController,
    required this.labelText,
  });
  final TextEditingController textEditingController;
  final String labelText;

  @override
  State<NearActionTextField> createState() => _NearActionTextFieldState();
}

class _NearActionTextFieldState extends State<NearActionTextField> {
  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;

    return TextField(
      controller: widget.textEditingController,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color:
              nearColors.nearLilac, // Change this to Near Protocol's blue color
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: nearColors
                .nearLilac, // Change this to Near Protocol's blue color
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(
            color: nearColors
                .nearLilac, // Change this to Near Protocol's blue color
          ),
        ),
      ),
      style: nearTextStyles.bodyCopy!.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 14.5.sp,
        color: nearColors.nearBlack,
      ), // Change this to Near Protocol's blue color
    );
  }
}
