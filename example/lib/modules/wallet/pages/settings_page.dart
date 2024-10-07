import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/routes/routes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
          child: TextButton(
              onPressed: () => Modular.to
                  .navigate(Routes.wallet.getRoute(Routes.wallet.home)),
              child: const Text('go back')),
        ));
  }
}
