import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class CryptoActionCard extends StatelessWidget {
  const CryptoActionCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
    required this.child,
    required this.height,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final Widget child;
  final double height;
  @override
  Widget build(BuildContext context) {
    final nearColors =
        Modular.get<AppTheme>().getTheme().extension<NearColors>()!;
    final nearTextStyles =
        Modular.get<AppTheme>().getTheme().extension<NearTextStyles>()!;

    return Card(
      elevation: 6,
      child: Container(
        height: height,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: nearColors.nearBlack,
                  size: 28,
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: nearTextStyles.bodyCopy!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: nearColors.nearBlack,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(child: child),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                primary: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Execute',
                  style: nearTextStyles.bodyCopy!.copyWith(
                    color: nearColors.nearWhite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
