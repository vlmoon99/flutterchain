import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/assets/icon_images/icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class PressableIconButton extends StatefulWidget {
  const PressableIconButton(
      {super.key, required this.icon, required this.onTapped, this.title});
  final AppIcon icon;
  final VoidCallback onTapped;
  final String? title;
  @override
  State<PressableIconButton> createState() => _PresableIconButtonState();
}

class _PresableIconButtonState extends State<PressableIconButton> {
  final theme = Modular.get<AppTheme>();

  bool isTapped = false;
  @override
  Widget build(BuildContext context) {
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    double screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTapDown: (_) {
        HapticFeedback.lightImpact();
        setState(() {
          isTapped = true;
        });
      },
      onTapUp: (_) async {
        setState(() {
          isTapped = false;
        });
        await Future.delayed(const Duration(milliseconds: 200));
        widget.onTapped();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: Transform.scale(
          scale: isTapped ? 0.85 : 1.0,
          child: Column(
            children: [
              widget.icon,
              if (widget.title != null)
                Text(widget.title!,
                    style: nearTextStyles.label!.copyWith(
                        color: nearColors.nearBlack,
                        fontSize: screenWidth < 500 ? 14.sp : 15.sp))
            ],
          ),
        ),
      ),
    );
  }
}
