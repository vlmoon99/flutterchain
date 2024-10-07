import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../assets/icon_images/icons.dart';

Widget BuildNft() {
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
                    bottom: 5,
                    left: 20,
                    child: Container(
                      height: 37.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black,
                      ),
                      child: Center(child: nft['name']),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    ),
  );
}
