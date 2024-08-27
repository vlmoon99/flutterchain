import 'package:flutter/widgets.dart';

class Images {
  // static const familyMan = 'assets/images/jhipster_family_member_0.svg';
  static const buyIcon =
      '/Users/hello/flutterchain/flutterchain/flutterchain/example/lib/assets/images/icons/buyButtonIcon.png';
  static const receiveIcon =
      '/Users/hello/flutterchain/flutterchain/flutterchain/example/lib/assets/images/icons/receiveButtonIcon.png';
  static const sendIcon =
      '/Users/hello/flutterchain/flutterchain/flutterchain/example/lib/assets/images/icons/sendButtonIcon.png';
  static const swapIcon =
      '/Users/hello/flutterchain/flutterchain/flutterchain/example/lib/assets/images/icons/swapButtonIcon.png';
  static const wallet =
      '/Users/hello/flutterchain/flutterchain/flutterchain/example/lib/assets/images/icons/walletButtonIcon.png';
  static const stackingIcon =
      '/Users/hello/flutterchain/flutterchain/flutterchain/example/lib/assets/images/icons/stackingButtonIcon.png';
  static const settingsIcon =
      '/Users/hello/flutterchain/flutterchain/flutterchain/example/lib/assets/images/icons/settingsButtonIcon.png';
  static const scanIcon =
      '/Users/hello/flutterchain/flutterchain/flutterchain/example/lib/assets/images/icons/scanButtonIcon.png';
  static const nearIcon =
      '/Users/hello/flutterchain/flutterchain/flutterchain/example/lib/assets/images/icons/nearTokenICon.png';
  static const octopusIcon =
      '/Users/hello/flutterchain/flutterchain/flutterchain/example/lib/assets/images/icons/octopusTokenIcon.png';
  static const deipIcon =
      '/Users/hello/flutterchain/flutterchain/flutterchain/example/lib/assets/images/icons/deipTokenIcon.png';
  static const auroraIcon =
      '/Users/hello/flutterchain/flutterchain/flutterchain/example/lib/assets/images/icons/auroraTokenIcon.png';
  static const usnIcon =
      '/Users/hello/flutterchain/flutterchain/flutterchain/example/lib/assets/images/icons/usnTokenIcon.png';
}

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
  usnIcon
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
    }
    return Image.asset(
      iconPath,
      width: size,
      height: size,
    );
  }
}
