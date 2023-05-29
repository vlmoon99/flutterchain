import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/near_action_text_field.dart';
import 'package:flutterchain_example/modules/home/components/core/crypto_actions_card.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/ui_state.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/near_vm.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class NearActivateTestNetAccount extends StatefulWidget {
  const NearActivateTestNetAccount({super.key});

  @override
  State<NearActivateTestNetAccount> createState() =>
      _NearActivateTestNetAccountState();
}

class _NearActivateTestNetAccountState
    extends State<NearActivateTestNetAccount> {
  //Delete key
  final TextEditingController accountIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    accountIdController.text = "your_account_id";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    // final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    final nearVM = Modular.get<NearVM>();
    final currentState = nearVM.nearState.value as SuccessNearBlockchainState;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return CryptoActionCard(
      title: 'Activate Testnet Account',
      height: height * 0.4,
      icon: Icons.done,
      color: nearColors.nearGreen,
      onTap: () {
        final accountId = accountIdController.text;
        nearVM.activateAccount(accountId).then((status) {
          nearVM.nearState.add(currentState);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                status
                    ? 'Success account activation'
                    : 'Failed account activation',
              ),
            ),
          );
        });
      },
      child: Column(
        children: [
          const SizedBox(height: 20),
          NearActionTextField(
            labelText: 'Account ID',
            textEditingController: accountIdController,
          ),
        ],
      ),
    );
  }
}
