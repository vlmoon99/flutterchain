import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';

class AppExceptions {
  String messageForUser;
  String messageForDev;
  AppExceptions({
    required this.messageForUser,
    required this.messageForDev,
  });

  @override
  String toString() => "messageForDev$messageForDev";
  factory AppExceptions.fromJson(Map<String, dynamic> json) => AppExceptions(
        messageForUser: json["messageForUser"],
        messageForDev: json["messageForDev"],
      );

  Map<String, dynamic> toJson() => {
        "messageForUser": messageForUser,
        "messageForDev": messageForDev,
      };
}

class Catcher {
  final FlutterSecureStorage secureStorage;
  Catcher(this.secureStorage) {
    exceptionsHandler.listen((value) {
      log("exceptionsHandler catch the exception --> ${value.toString()}");
      showDialogForError(value);
    });
  }

  final exceptionsHandler = BehaviorSubject<AppExceptions>();


  void showDialogForError(
    AppExceptions exception,
  ) {
    showDialog(
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(exception.messageForUser),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
      context: Modular.routerDelegate.navigatorKey.currentContext!,
    );
  }
}

