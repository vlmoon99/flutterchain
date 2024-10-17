import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

Widget walletPageQrCodeButton() {
  {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
      child: AlertDialog(
        title: const Text('Qr Code'),
        content: const Text('this a QrCode '),
        actions: [
          TextButton(
            onPressed: () {
              Modular.to.pop();
            },
            child: const Text('Закрыть'),
          ),
        ],
      ),
    );
  }
}
