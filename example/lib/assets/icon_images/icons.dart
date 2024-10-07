import 'package:flutter/widgets.dart';

class Images {
  static const buyIcon =
      'lib/assets/icon_images/button_icons/buyButtonIcon.png';
  static const receiveIcon =
      'lib/assets/icon_images/button_icons/receiveButtonIcon.png';
  static const sendIcon =
      'lib/assets/icon_images/button_icons/sendButtonIcon.png';
  static const swapIcon =
      'lib/assets/icon_images/button_icons/swapButtonIcon.png';
  static const wallet =
      'lib/assets/icon_images/button_icons/walletButtonIcon.png';
  static const stackingIcon =
      'lib/assets/icon_images/button_icons/stackingButtonIcon.png';
  static const settingsIcon =
      'lib/assets/icon_images/button_icons/settingsButtonIcon.png';
  static const scanIcon =
      'lib/assets/icon_images/button_icons/scanButtonIcon.png';
  static const nearIcon =
      'lib/assets/icon_images/button_icons/nearTokenICon.png';
  static const octopusIcon =
      'lib/assets/icon_images/button_icons/octopusTokenIcon.png';
  static const deipIcon =
      'lib/assets/icon_images/button_icons/deipTokenIcon.png';
  static const auroraIcon =
      'lib/assets/icon_images/button_icons/auroraTokenIcon.png';
  static const usnIcon = 'lib/assets/icon_images/button_icons/usnTokenIcon.png';
  static const tomasNftICon =
      'lib/assets/icon_images/nft_icons/tomas_nft_icon.png';
  static const clausNftICon =
      'lib/assets/icon_images/nft_icons/claus_nft_icon.png';
}

// class Images {
//   // static const familyMan = 'assets/images/jhipster_family_member_0.svg';
//   static const buyIcon =
//       '/Users/hello/flutterchain1/example/lib/assets/icon_images/button_icons/buyButtonIcon.png';
//   static const receiveIcon =
//       '/Users/hello/flutterchain1/example/lib/assets/icon_images/button_icons/receiveButtonIcon.png';
//   static const sendIcon =
//       '/Users/hello/flutterchain1/example/lib/assets/icon_images/button_icons/sendButtonIcon.png';
//   static const swapIcon =
//       '/Users/hello/flutterchain1/example/lib/assets/icon_images/button_icons/swapButtonIcon.png';
//   static const wallet =
//       '/Users/hello/flutterchain1/example/lib/assets/images/button_icons/walletButtonIcon.png';
//   static const stackingIcon =
//       '/Users/hello/flutterchain1/example/lib/assets/icon_images/button_icons/stackingButtonIcon.png';
//   static const settingsIcon =
//       '/Users/hello/flutterchain1/example/lib/assets/icon_images/button_icons/settingsButtonIcon.png';
//   static const scanIcon =
//       '/Users/hello/flutterchain1/example/lib/assets/icon_images/button_icons/scanButtonIcon.png';
//   static const nearIcon =
//       '/Users/hello/flutterchain1/example/lib/assets/icon_images/button_icons/nearTokenICon.png';
//   static const octopusIcon =
//       '/Users/hello/flutterchain1/example/lib/assets/icon_images/button_icons/octopusTokenIcon.png';
//   static const deipIcon =
//       '/Users/hello/flutterchain1/example/lib/assets/icon_images/button_icons/deipTokenIcon.png';
//   static const auroraIcon =
//       '/Users/hello/flutterchain1/example/lib/assets/icon_images/button_icons/auroraTokenIcon.png';
//   static const usnIcon =
//       '/Users/hello/flutterchain1/example/lib/assets/icon_images/button_icons/usnTokenIcon.png';
//   static const tomasNftICon =
//       '/Users/hello/flutterchain1/example/lib/assets/icon_images/nft_icons/tomas_nft_icon.png';
//   static const clausNftICon =
//       '/Users/hello/flutterchain1/example/lib/assets/icon_images/nft_icons/claus_nft_icon.png';
// }

enum IconType {
  buy,
  swap,
  receive,
  send,
  wallet,
  stackingIcon,
  settingsIcon,
  scanIcon,
  octopusIcon,
  nearIcon,
  deipIcon,
  auroraIcon,
  usnIcon,
  tomasNftIcon,
  clausNftIcon,
}

class AppIcon extends StatelessWidget {
  final IconType iconType;
  final double size;

  const AppIcon({
    Key? key,
    required this.iconType,
    this.size = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String iconPath;

    switch (iconType) {
      case IconType.buy:
        iconPath = Images.buyIcon;
        break;
      case IconType.send:
        iconPath = Images.sendIcon;
        break;
      case IconType.swap:
        iconPath = Images.swapIcon;
        break;
      case IconType.receive:
        iconPath = Images.receiveIcon;
        break;
      case IconType.wallet:
        iconPath = Images.wallet;
        break;
      case IconType.stackingIcon:
        iconPath = Images.stackingIcon;
        break;
      case IconType.settingsIcon:
        iconPath = Images.settingsIcon;
        break;
      case IconType.scanIcon:
        iconPath = Images.scanIcon;
        break;
      case IconType.octopusIcon:
        iconPath = Images.octopusIcon;
        break;
      case IconType.nearIcon:
        iconPath = Images.nearIcon;
        break;
      case IconType.deipIcon:
        iconPath = Images.deipIcon;
        break;
      case IconType.auroraIcon:
        iconPath = Images.auroraIcon;
        break;
      case IconType.usnIcon:
        iconPath = Images.usnIcon;
        break;
      case IconType.tomasNftIcon:
        iconPath = Images.tomasNftICon;
        break;
      case IconType.clausNftIcon:
        iconPath = Images.clausNftICon;
        break;
    }
    return Image.asset(
      iconPath,
      width: size,
      height: size,
    );
  }
}
