import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain_example/modules/home/components/core/crypto_actions_card.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/ui_state.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/near_vm.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class NearInsertNewBlockchainDataInsideWallet extends StatefulWidget {
  const NearInsertNewBlockchainDataInsideWallet({super.key});

  @override
  State<NearInsertNewBlockchainDataInsideWallet> createState() =>
      _NearInsertNewBlockchainDataInsideWalletState();
}

class _NearInsertNewBlockchainDataInsideWalletState
    extends State<NearInsertNewBlockchainDataInsideWallet> {
  final TextEditingController createBlockchainDataDerivationPath =
      TextEditingController();
  @override
  void initState() {
    super.initState();
    createBlockchainDataDerivationPath.text = "m/44'/397'/0'/0'/1'";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    final nearVM = Modular.get<NearVM>();

    final currentState = nearVM.nearState.value as SuccessNearBlockchainState;

    return CryptoActionCard(
      title: 'Create New BlockChainData by derivation path',
      height: 350,
      icon: Icons.wallet,
      color: nearColors.nearGreen,
      onTap: () {
        final walletID = nearVM.userStore.walletIdStream.value;
        final derivationPath = createBlockchainDataDerivationPath.text
            .replaceAll("'", "")
            .split('/')
            .toList();

        final derivationModel = DerivationPath(
          purpose: derivationPath[1],
          coinType: derivationPath[2],
          accountNumber: derivationPath[3],
          change: derivationPath[4],
          address: derivationPath[5],
        );
        nearVM
            .addBlockChainDataByDerivationPath(
          currentDerivationPath: derivationModel,
          walletID: walletID,
        )
            .then(
          (value) {
            nearVM.nearBlockchainStore.currentDerivationPath
                .add(value.derivationPath);
            nearVM.nearState.add(
              currentState.copyWith(
                blockchainsDataCreatedByDerivationPath:
                    value.toJson().toString(),
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  value.privateKey.isNotEmpty
                      ? 'Success added New BlockChain Data'
                      : 'Failed added New BlockChain Data',
                ),
              ),
            );
            // blockchainsDataCreatedByDerivationPath =
            //     value.toJson().toString();

            log("Generated blockchainData ${value.toJson()}");
          },
        );
      },
      child: Column(
        children: [
          const SizedBox(height: 20),
          TextField(
            controller: createBlockchainDataDerivationPath,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Derivation Path',
              labelStyle: nearTextStyles.bodyCopy!.copyWith(
                color: nearColors.nearBlack,
              ),
            ),
          ),
          SelectableText(
            currentState.blockchainsDataCreatedByDerivationPath ?? '',
          ),
        ],
      ),
    );
  }
}
