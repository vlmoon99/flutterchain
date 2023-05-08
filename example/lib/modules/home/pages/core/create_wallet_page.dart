import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/modules/home/components/core/create_wallet_component.dart';
import 'package:flutterchain_example/routes/routes.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class CreateWalletPage extends StatefulWidget {
  const CreateWalletPage({Key? key, this.onLoginAction}) : super(key: key);
  final VoidCallback? onLoginAction;
  @override
  State<CreateWalletPage> createState() => _CreateWalletPageState();
}

class _CreateWalletPageState extends State<CreateWalletPage> {
  final TextEditingController mnemonicTextEditingController =
      TextEditingController();
  final TextEditingController walletNameTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    mnemonicTextEditingController.addListener(() {
      setState(() {});
    });
    walletNameTextEditingController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;

    final inputDecorationOfTheWalletName = getInputDecoration(
      nearColors: nearColors,
      hintText: 'Write your multi-wallet name',
    );
    final inputDecorationOfTheMnemonic = getInputDecoration(
      nearColors: nearColors,
      hintText: 'Write your mnemonic using space as a separator',
    );

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: width * 0.8,
                margin: EdgeInsets.only(
                  bottom: width * 0.045,
                  top: height * 0.026,
                ),
                child: TextField(
                  controller: walletNameTextEditingController,
                  decoration: inputDecorationOfTheWalletName,
                ),
              ),
              CreateWalletComponent(
                mnemonic: mnemonicTextEditingController.text,
                title: "Create new wallet with mnemonic phrase",
                walletName: walletNameTextEditingController.text,
                isActive: walletNameTextEditingController.text.isNotEmpty &&
                    mnemonicTextEditingController.text.isEmpty,
                onLoginAction: widget.onLoginAction ??
                    () {
                      Modular.to.navigate(Routes.home.getModule());
                    },
              ),
              Padding(
                padding: EdgeInsets.only(top: width * 0.045),
                child: Column(
                  children: [
                    CreateWalletComponent(
                      title: 'Import wallet with mnemonic phrase',
                      walletName: walletNameTextEditingController.text,
                      isActive:
                          walletNameTextEditingController.text.isNotEmpty &&
                              mnemonicTextEditingController.text.isNotEmpty,
                      onLoginAction: widget.onLoginAction ??
                          () {
                            Modular.to.navigate(Routes.home.getModule());
                          },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: width * 0.05),
                      width: width * 0.8,
                      child: Column(
                        children: [
                          TextField(
                            controller: mnemonicTextEditingController,
                            decoration: inputDecorationOfTheMnemonic,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 15),
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
      ),
    );
  }

  InputDecoration getInputDecoration({
    required NearColors nearColors,
    required String hintText,
  }) {
    return InputDecoration(
      filled: true,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: nearColors.nearGray,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: nearColors.nearGray,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: nearColors.nearBlue,
        ),
      ),
      hintText: hintText,
      hintStyle: TextStyle(
        color: nearColors.nearGray,
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w500,
        letterSpacing: 0.02,
      ),
      labelStyle: TextStyle(
        color: nearColors.nearGray,
        fontFamily: 'Manrope',
        fontWeight: FontWeight.w500,
        letterSpacing: 0.02,
      ),
    );
  }
}
