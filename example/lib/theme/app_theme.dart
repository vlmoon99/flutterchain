import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class MyColors extends ThemeExtension<MyColors> {
  const MyColors(
      {required this.customColor,
      required this.registerNewAccount,
      required this.grey,
      required this.black});

  const MyColors.dark({
    this.customColor = const Color.fromRGBO(0, 255, 255, 1),
    this.registerNewAccount = Colors.green,
    this.grey = Colors.grey,
    this.black = Colors.black,
  });
  const MyColors.light({
    this.customColor = const Color.fromRGBO(0, 255, 255, 1),
    this.registerNewAccount = Colors.green,
    this.grey = Colors.grey,
    this.black = Colors.black,
  });

  final Color customColor;
  final Color registerNewAccount;
  final Color grey;
  final Color black;
  @override
  MyColors copyWith({
    Color? customColor,
    Color? registerNewAccount,
    Color? grey,
    Color? black,
  }) {
    return MyColors(
      customColor: customColor ?? this.customColor,
      registerNewAccount: registerNewAccount ?? this.registerNewAccount,
      grey: grey ?? this.grey,
      black: black ?? this.black,
    );
  }

  @override
  MyColors lerp(ThemeExtension<MyColors>? other, double t) {
    if (other is! MyColors) {
      return this;
    }
    return MyColors(
      customColor:
          Color.lerp(customColor, other.customColor, t) ?? Colors.black,
      registerNewAccount:
          Color.lerp(registerNewAccount, other.registerNewAccount, t) ??
              Colors.black,
      grey: Color.lerp(grey, other.grey, t) ?? Colors.grey,
      black: Color.lerp(black, other.black, t) ?? Colors.black,
    );
  }

  // Optional
  @override
  String toString() =>
      'MyColors(customColor: $customColor, registerNewAccount: $registerNewAccount , grey: $grey, black: $black)';
}

@immutable
class MyTextStyles extends ThemeExtension<MyTextStyles> {
  const MyTextStyles({
    required this.error,
    required this.loginButton,
    required this.didYouForgotYourPassword,
    required this.loginTitle,
  });

  const MyTextStyles.defaultTextStyles({
    this.error = const TextStyle(
        fontSize: 20.0, color: Colors.red, fontWeight: FontWeight.bold),
    this.loginButton = const TextStyle(
        fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
    this.didYouForgotYourPassword = const TextStyle(
      fontSize: 20.0,
      color: Colors.black,
    ),
    this.loginTitle = const TextStyle(
      fontSize: 15.0,
      color: Colors.white,
    ),
  });

  final TextStyle? error;
  final TextStyle? loginButton;
  final TextStyle? loginTitle;
  final TextStyle? didYouForgotYourPassword;

  @override
  MyTextStyles copyWith(
      {TextStyle? error,
      TextStyle? loginButton,
      TextStyle? loginTitle,
      TextStyle? didYouForgotYourPassword}) {
    return MyTextStyles(
      error: error ?? this.error,
      loginButton: loginButton ?? this.loginButton,
      loginTitle: loginTitle ?? this.loginTitle,
      didYouForgotYourPassword:
          didYouForgotYourPassword ?? this.didYouForgotYourPassword,
    );
  }

  @override
  MyTextStyles lerp(ThemeExtension<MyTextStyles>? other, double t) {
    if (other is! MyTextStyles) {
      return this;
    }
    return MyTextStyles(
      error: TextStyle.lerp(error, other.error, t),
      loginButton: TextStyle.lerp(loginButton, other.loginButton, t),
      loginTitle: TextStyle.lerp(loginTitle, other.loginTitle, t),
      didYouForgotYourPassword: TextStyle.lerp(
          didYouForgotYourPassword, other.didYouForgotYourPassword, t),
    );
  }

  // Optional
  @override
  String toString() => 'MyTextStyles(error: $error, loginButton: $loginButton)';
}

@immutable
class CustomInputDecoration {
  static InputDecoration getInputDecoration(String? labelText) {
    return InputDecoration(
      labelText: labelText ?? 'default',
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
    );
  }
}

class AppTheme {
  final _darkTheme = ThemeData.dark().copyWith(
    extensions: <ThemeExtension<dynamic>>[
      const MyColors.dark(),
      const MyTextStyles.defaultTextStyles(),
    ],
  );

  final _lightTheme = ThemeData.light().copyWith(extensions: [
    const MyColors.light(),
    const MyTextStyles.defaultTextStyles(),
  ]);

  final appThemeStream = BehaviorSubject<ThemeData>(sync: true);

  //Add screen whe user can switch theme and watch on the value
  ThemeData getTheme() => appThemeStream.value;

  AppTheme() {
    //add initial value
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
