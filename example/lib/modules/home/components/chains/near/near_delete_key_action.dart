import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/blockchain_response.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/near_action_text_field.dart';
import 'package:flutterchain_example/modules/home/components/core/crypto_actions_card.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/ui_state.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/near_vm.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class NearDeleteKeyAction extends StatefulWidget {
  const NearDeleteKeyAction({super.key});

  @override
  State<NearDeleteKeyAction> createState() => _NearDeleteKeyActionState();
}

class _NearDeleteKeyActionState extends State<NearDeleteKeyAction> {
  //Delete key
  final TextEditingController deleteKeyPublicKeyAddressController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    deleteKeyPublicKeyAddressController.text =
        "c1cb858d5b6177be0f4847d310eddbb302a06c76dd2f464138ec8761d9fe1c54";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    final nearVM = Modular.get<NearVM>();
    final currentState = nearVM.nearState.value as SuccessNearBlockchainState;
    return CryptoActionCard(
      title: 'Delete Key',
      height: 350,
      icon: Icons.key_off,
      color: nearColors.nearGreen,
      onTap: () {
        final deleteKeyPublicKeyAddress =
            deleteKeyPublicKeyAddressController.text;
        final walletID = nearVM.userStore.walletIdStream.value;
        final currentDerivationPath =
            nearVM.nearBlockchainStore.currentDerivationPath.value;

        nearVM
            .deleteKeyNearBlockChain(
          walletID: walletID,
          currentDerivationPath: currentDerivationPath,
          publicKey: deleteKeyPublicKeyAddress,
        )
            .then(
          (value) {
            nearVM.nearState.add(
              currentState.copyWith(
                deleteKeyResult: value.toJson().toString(),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  value.status == BlockchainResponses.success
                      ? 'Success delete key action'
                      : 'Failed delete key action',
                ),
              ),
            );
            log("Result of deleteKeyNearBlockChain $value");
          },
        );
      },
      child: Column(
        children: [
          const SizedBox(height: 20),
          NearActionTextField(
            labelText: 'Delete Key',
            textEditingController: deleteKeyPublicKeyAddressController,
          ),
        ],
      ),
    );
  }
}
