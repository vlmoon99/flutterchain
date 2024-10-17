import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../assets/icon_images/icons.dart';

// ignore: must_be_immutable
class BuildNft extends StatelessWidget {
  BuildNft({super.key});

  List<Map<dynamic, dynamic>> nfts = [
    {
      'icon': const AppIcon(
        iconType: IconType.tomasNftIcon,
        size: 1000,
      ),
      'name': const Text(
        'Tommy',
        style: TextStyle(color: Colors.white),
      ),
    },
    {
      'icon': const AppIcon(
        iconType: IconType.clausNftIcon,
        size: 1000,
      ),
      'name': const Text(
        'Daddy Claus',
        style: TextStyle(color: Colors.white),
      ),
    },
    {
      'icon': const AppIcon(
        iconType: IconType.tomasNftIcon,
        size: 1000,
      ),
      'name': const Text(
        'Tommy',
        style: TextStyle(color: Colors.white),
      ),
    },
    {
      'icon': const AppIcon(
        iconType: IconType.clausNftIcon,
        size: 1000,
      ),
      'name': const Text(
        'Daddy Claus',
        style: TextStyle(color: Colors.white),
      ),
    },
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AspectRatio(
      aspectRatio: 1,
      child: SizedBox(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: nfts.length,
          itemBuilder: (BuildContext context, int index) {
            final nft = nfts[index];
            return Padding(
              padding: EdgeInsets.all(8.r),
              child: SizedBox(
                child: Stack(
                  children: [
                    nft['icon'],
                    Positioned(
                      bottom: screenWidth < 500 ? 7.h : 45.h,
                      left: screenWidth < 500 ? 20.w : 35.w,
                      child: Container(
                        height: screenWidth < 500 ? 27.h : 50,
                        width: screenWidth < 500 ? 90.w : 50.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black,
                        ),
                        child: Center(child: nft['name']),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
