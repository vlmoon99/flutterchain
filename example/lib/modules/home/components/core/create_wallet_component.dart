import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/modules/home/vms/core/home_vm.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

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
