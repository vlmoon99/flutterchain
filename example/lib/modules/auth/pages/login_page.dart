import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/modules/auth/vm/auth_vm.dart';
import 'package:flutterchain_example/routes/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authVM = Modular.get<AuthVM>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppButton(
              title: "Create new wallet with mnemonic phrase",
              onPress: () async {
                authVM
                    .createWalletWithGeneratedMnemonic(
                        'New Wallet ${DateTime.now().toString()}')
                    .then(
                  (value) {
                    Modular.to.navigate(Routes.home.getModule());
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  AppButton(
                    title: "Import wallet with mnemonic phrase",
                    onPress: () {
                      final mnemonic = textEditingController.text.split(" ");
                      if (mnemonic.isEmpty || mnemonic.length < 12) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Your mnemonic is incorrect"),
                          ),
                        );
                      } else {
                        authVM
                            .createWallet(mnemonic.join(" "),
                                'New Wallet ${DateTime.now().toString()}')
                            .then(
                          (value) {
                            Modular.to.navigate(Routes.home.getModule());
                          },
                        );
                      }
                    },
                  ),
                  SizedBox(
                    width: 300,
                    height: 150,
                    child: Column(
                      children: [
                        TextField(
                          controller: textEditingController,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Text(
                              "Write you mnemonic using space as a separator"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.onPress,
  });

  final String title;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPress,
      child: Container(
        alignment: Alignment.center,
        width: 200,
        height: 90,
        color: Colors.blueAccent,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
