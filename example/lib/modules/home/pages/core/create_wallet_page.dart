import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/modules/home/vms/core/home_vm.dart';
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
    // final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    final nearColors = theme.getTheme().extension<NearColors>()!;

    // final authVM = Modular.get<AuthVM>();
    final inputDecorationOfTheWalletName = getInputDecoration(
      nearColors: nearColors,
      hintText: 'Write your multi-wallet name',
    );
    final inputDecorationOfTheMnemonic = getInputDecoration(
      nearColors: nearColors,
      hintText: 'Write your mnemonic using space as a separator',
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                margin: const EdgeInsets.only(
                  bottom: 50,
                  top: 25,
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
                padding: const EdgeInsets.only(top: 50),
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
                      margin: const EdgeInsets.only(top: 15),
                      width: 300,
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

class CreateWalletComponent extends StatelessWidget {
  const CreateWalletComponent({
    super.key,
    this.mnemonic,
    required this.title,
    required this.walletName,
    this.isActive = false,
    required this.onLoginAction,
  });

  final String? mnemonic;
  final String title;
  final String walletName;
  final bool isActive;
  final VoidCallback onLoginAction;
  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;

    final homeVM = Modular.get<HomeVM>();

    return SizedBox(
      width: 200,
      height: 80,
      child: ElevatedButton(
        onPressed: isActive
            ? () async {
                homeVM.createWallet(mnemonic, walletName).then(
                  (value) {
                    // Modular.to.navigate(Routes.home.getModule());
                    onLoginAction();
                  },
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.getTheme().extension<NearColors>()!.nearPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: nearTextStyles.label!.fontSize,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
