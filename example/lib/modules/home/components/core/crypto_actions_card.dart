import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

    return Container(
      margin: const EdgeInsets.all(16.0),
      height: height,
      decoration: BoxDecoration(
        color: nearColors.nearWhite,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 2),
            blurRadius: 4,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: -1,
          ),
        ],
      ),
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
                  color: nearColors.nearLilac,
                  size: 28,
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: nearTextStyles.bodyCopy!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: nearColors.nearBlack,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(child: child),
            const SizedBox(height: 40),
            InkWell(
              onTap: onTap,
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: nearColors.nearAqua,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(0, 1),
                      blurRadius: 2,
                      spreadRadius: -1,
                    ),
                  ],
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
            ),
          ],
        ),
      ),
    );
    // return Card(
    //   elevation: 6,
    // child: Container(
    //   height: height,
    //   padding: const EdgeInsets.all(16),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: [
    //       Row(
    //         children: [
    //           Icon(
    //             icon,
    //             color: nearColors.nearBlack,
    //             size: 28,
    //           ),
    //           const SizedBox(width: 16),
    //           Text(
    //             title,
    //             style: nearTextStyles.bodyCopy!.copyWith(
    //               fontWeight: FontWeight.bold,
    //               color: nearColors.nearBlack,
    //             ),
    //           ),
    //         ],
    //       ),
    //       const SizedBox(height: 20),
    //       Expanded(child: child),
    //       const SizedBox(height: 40),
    //       InkWell(
    //         onTap: onTap,
    //         child: Container(
    //           alignment: Alignment.center,
    //           decoration: BoxDecoration(
    //             color: nearColors.nearAqua,
    //             borderRadius: BorderRadius.circular(8),
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Colors.black.withOpacity(0.1),
    //                 offset: const Offset(0, 2),
    //                 blurRadius: 4,
    //                 spreadRadius: 0,
    //               ),
    //               BoxShadow(
    //                 color: Colors.black.withOpacity(0.1),
    //                 offset: const Offset(0, 1),
    //                 blurRadius: 2,
    //                 spreadRadius: -1,
    //               ),
    //             ],
    //           ),
    //           child: Padding(
    //             padding: const EdgeInsets.symmetric(vertical: 16),
    //             child: Text(
    //               'Execute',
    //               style: nearTextStyles.bodyCopy!.copyWith(
    //                 color: nearColors.nearWhite,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
    // );
  }
}
