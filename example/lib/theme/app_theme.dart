import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

// @immutable
// class MyColors extends ThemeExtension<MyColors> {
//   const MyColors(
//       {required this.customColor,
//       required this.registerNewAccount,
//       required this.grey,
//       required this.black});

//   const MyColors.dark({
//     this.customColor = const Color.fromRGBO(0, 255, 255, 1),
//     this.registerNewAccount = Colors.green,
//     this.grey = Colors.grey,
//     this.black = Colors.black,
//   });
//   const MyColors.light({
//     this.customColor = const Color.fromRGBO(0, 255, 255, 1),
//     this.registerNewAccount = Colors.green,
//     this.grey = Colors.grey,
//     this.black = Colors.black,
//   });

//   final Color customColor;
//   final Color registerNewAccount;
//   final Color grey;
//   final Color black;
//   @override
//   MyColors copyWith({
//     Color? customColor,
//     Color? registerNewAccount,
//     Color? grey,
//     Color? black,
//   }) {
//     return MyColors(
//       customColor: customColor ?? this.customColor,
//       registerNewAccount: registerNewAccount ?? this.registerNewAccount,
//       grey: grey ?? this.grey,
//       black: black ?? this.black,
//     );
//   }

//   @override
//   MyColors lerp(ThemeExtension<MyColors>? other, double t) {
//     if (other is! MyColors) {
//       return this;
//     }
//     return MyColors(
//       customColor:
//           Color.lerp(customColor, other.customColor, t) ?? Colors.black,
//       registerNewAccount:
//           Color.lerp(registerNewAccount, other.registerNewAccount, t) ??
//               Colors.black,
//       grey: Color.lerp(grey, other.grey, t) ?? Colors.grey,
//       black: Color.lerp(black, other.black, t) ?? Colors.black,
//     );
//   }

//   // Optional
//   @override
//   String toString() =>
//       'MyColors(customColor: $customColor, registerNewAccount: $registerNewAccount , grey: $grey, black: $black)';
// }

// @immutable
// class MyTextStyles extends ThemeExtension<MyTextStyles> {
//   const MyTextStyles({
//     required this.error,
//     required this.loginButton,
//     required this.didYouForgotYourPassword,
//     required this.loginTitle,
//   });

//   const MyTextStyles.defaultTextStyles({
//     this.error = const TextStyle(
//         fontSize: 20.0, color: Colors.red, fontWeight: FontWeight.bold),
//     this.loginButton = const TextStyle(
//         fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
//     this.didYouForgotYourPassword = const TextStyle(
//       fontSize: 20.0,
//       color: Colors.black,
//     ),
//     this.loginTitle = const TextStyle(
//       fontSize: 15.0,
//       color: Colors.white,
//     ),
//   });

//   final TextStyle? error;
//   final TextStyle? loginButton;
//   final TextStyle? loginTitle;
//   final TextStyle? didYouForgotYourPassword;

//   @override
//   MyTextStyles copyWith(
//       {TextStyle? error,
//       TextStyle? loginButton,
//       TextStyle? loginTitle,
//       TextStyle? didYouForgotYourPassword}) {
//     return MyTextStyles(
//       error: error ?? this.error,
//       loginButton: loginButton ?? this.loginButton,
//       loginTitle: loginTitle ?? this.loginTitle,
//       didYouForgotYourPassword:
//           didYouForgotYourPassword ?? this.didYouForgotYourPassword,
//     );
//   }

//   @override
//   MyTextStyles lerp(ThemeExtension<MyTextStyles>? other, double t) {
//     if (other is! MyTextStyles) {
//       return this;
//     }
//     return MyTextStyles(
//       error: TextStyle.lerp(error, other.error, t),
//       loginButton: TextStyle.lerp(loginButton, other.loginButton, t),
//       loginTitle: TextStyle.lerp(loginTitle, other.loginTitle, t),
//       didYouForgotYourPassword: TextStyle.lerp(
//           didYouForgotYourPassword, other.didYouForgotYourPassword, t),
//     );
//   }

//   @override
//   String toString() => 'MyTextStyles(error: $error, loginButton: $loginButton)';
// }

@immutable
class NearTextStyles extends ThemeExtension<NearTextStyles> {
  const NearTextStyles({
    required this.headline,
    required this.subhead,
    required this.bodyCopy,
    required this.label,
    required this.highlight,
  });

  const NearTextStyles.defaultTextStyles({
    this.headline = const TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w400,
        letterSpacing: -0.02),
    this.subhead = const TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w600,
        letterSpacing: -0.02),
    this.bodyCopy = const TextStyle(
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w500,
        letterSpacing: 0.02),
    this.label = const TextStyle(
        fontFamily: 'Manrope', fontWeight: FontWeight.w600, letterSpacing: 0.0),
    this.highlight = const TextStyle(
        fontFamily: 'Manrope', fontWeight: FontWeight.w500, letterSpacing: 0.2),
  });

  final TextStyle? headline;
  final TextStyle? subhead;
  final TextStyle? bodyCopy;
  final TextStyle? label;
  final TextStyle? highlight;

  @override
  NearTextStyles copyWith(
      {TextStyle? headline,
      TextStyle? subhead,
      TextStyle? bodyCopy,
      TextStyle? label,
      TextStyle? highlight}) {
    return NearTextStyles(
      headline: headline ?? this.headline,
      subhead: subhead ?? this.subhead,
      bodyCopy: bodyCopy ?? this.bodyCopy,
      label: label ?? this.label,
      highlight: highlight ?? this.highlight,
    );
  }

  @override
  NearTextStyles lerp(
      covariant ThemeExtension<NearTextStyles>? other, double t) {
    if (other is! NearTextStyles) {
      return this;
    }
    return NearTextStyles(
      headline: TextStyle.lerp(headline, other.headline, t),
      subhead: TextStyle.lerp(subhead, other.subhead, t),
      bodyCopy: TextStyle.lerp(bodyCopy, other.bodyCopy, t),
      label: TextStyle.lerp(label, other.label, t),
      highlight: TextStyle.lerp(highlight, other.highlight, t),
    );
  }
}

@immutable
class NearColors extends ThemeExtension<NearColors> {
  const NearColors({
    required this.nearSlate,
    required this.nearGray,
    required this.nearWhite,
    required this.nearBlack,
    required this.nearBlue,
    required this.nearLilac,
    required this.nearPurple,
    required this.nearAqua,
    required this.nearGreen,
    required this.nearGold,
    required this.nearOrange,
    required this.nearRed,
  });

  const NearColors.defaultColors({
    this.nearSlate = const Color(0xff3F4246),
    this.nearGray = const Color(0xffA7A7A7),
    this.nearWhite = const Color(0xffffffff),
    this.nearBlack = const Color(0xff262626),
    this.nearBlue = const Color(0xFF5F8AFA),
    this.nearLilac = const Color(0xFFA463B0),
    this.nearPurple = const Color(0xFF6B6EF9),
    this.nearAqua = const Color(0xFF4FD1D9),
    this.nearGreen = const Color(0xFFAAD055),
    this.nearGold = const Color(0xFFFFC860),
    this.nearOrange = const Color(0xFFE3935B),
    this.nearRed = const Color(0xFFDB5555),
  });

  final Color nearSlate;
  final Color nearGray;
  final Color nearWhite;
  final Color nearBlack;
  final Color nearBlue;
  final Color nearLilac;
  final Color nearPurple;
  final Color nearAqua;
  final Color nearGreen;
  final Color nearGold;
  final Color nearOrange;
  final Color nearRed;

  @override
  NearColors copyWith({
    Color? nearSlate,
    Color? nearGray,
    Color? nearWhite,
    Color? nearBlack,
    Color? nearBlue,
    Color? nearLilac,
    Color? nearPurple,
    Color? nearAqua,
    Color? nearGreen,
    Color? nearGold,
    Color? nearOrange,
    Color? nearRed,
  }) {
    return NearColors(
      nearSlate: nearSlate ?? this.nearSlate,
      nearGray: nearGray ?? this.nearGray,
      nearWhite: nearWhite ?? this.nearWhite,
      nearBlack: nearBlack ?? this.nearBlack,
      nearBlue: nearBlue ?? this.nearBlue,
      nearLilac: nearLilac ?? this.nearLilac,
      nearPurple: nearPurple ?? this.nearPurple,
      nearAqua: nearAqua ?? this.nearAqua,
      nearGreen: nearGreen ?? this.nearGreen,
      nearGold: nearGold ?? this.nearGold,
      nearOrange: nearOrange ?? this.nearOrange,
      nearRed: nearRed ?? this.nearRed,
    );
  }

  @override
  NearColors lerp(ThemeExtension<NearColors>? other, double t) {
    if (other is! NearColors) {
      return this;
    }
    return NearColors(
      nearSlate: Color.lerp(nearSlate, other.nearSlate, t) ?? Colors.black,
      nearGray: Color.lerp(nearGray, other.nearGray, t) ?? Colors.black,
      nearWhite: Color.lerp(nearWhite, other.nearWhite, t) ?? Colors.grey,
      nearBlack: Color.lerp(nearBlack, other.nearBlack, t) ?? Colors.black,
      nearBlue: Color.lerp(nearBlue, other.nearBlue, t) ?? Colors.blue,
      nearLilac: Color.lerp(nearLilac, other.nearLilac, t) ?? Colors.purple,
      nearPurple: Color.lerp(nearPurple, other.nearPurple, t) ?? Colors.purple,
      nearAqua: Color.lerp(nearAqua, other.nearAqua, t) ?? Colors.cyan,
      nearGreen: Color.lerp(nearGreen, other.nearGreen, t) ?? Colors.green,
      nearGold: Color.lerp(nearGold, other.nearGold, t) ?? Colors.yellow,
      nearOrange: Color.lerp(nearOrange, other.nearOrange, t) ?? Colors.orange,
      nearRed: Color.lerp(nearRed, other.nearRed, t) ?? Colors.red,
    );
  }

  // Optional
  @override
  String toString() =>
      'NearColors(nearSlate: $nearSlate, nearGray: $nearGray, nearWhite: $nearWhite, nearBlack: $nearBlack, nearBlue: $nearBlue, nearLilac: $nearLilac, nearPurple: $nearPurple, nearAqua: $nearAqua, nearGreen: $nearGreen, nearGold: $nearGold, nearOrange: $nearOrange, nearRed: $nearRed)';
}

class AppTheme {
  final _darkTheme = ThemeData.dark().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      const NearTextStyles.defaultTextStyles(),
      const NearColors.defaultColors(),
      // const MyColors.dark(),
      // const MyTextStyles.defaultTextStyles(),
    ],
  );

  final _lightTheme = ThemeData.light().copyWith(
    extensions: [
      const NearTextStyles.defaultTextStyles(),
      const NearColors.defaultColors(),

      // const MyColors.light(),
      // const MyTextStyles.defaultTextStyles(),
    ],
  );

  final appThemeStream = BehaviorSubject<ThemeData>(sync: true);

  ThemeData getTheme() => appThemeStream.value;

  AppTheme() {
    appThemeStream.add(_lightTheme);

    final prefs = SharedPreferences.getInstance();

    prefs.then((storage) {
      final value = storage.get('themeMode');

      var themeMode = value ?? 'light';
      if (themeMode == 'light') {
        appThemeStream.add(_lightTheme);
      } else {
        appThemeStream.add(_darkTheme);
      }
    });
  }

  void setDarkMode() async {
    appThemeStream.add(_darkTheme);
    final prefs = await SharedPreferences.getInstance();

    prefs.setString('themeMode', 'dark');
  }

  void setLightMode() async {
    appThemeStream.add(_lightTheme);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', 'light');
  }
}
