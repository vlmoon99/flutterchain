import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_derivation_path.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/concordium_blockchain_service.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/near_action_text_field.dart';
import 'package:flutterchain_example/modules/home/components/core/crypto_actions_card.dart';
import 'package:flutterchain_example/modules/home/vms/chains/concordium_vm.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class ConcordiumAddAccountAction extends StatefulWidget {
  const ConcordiumAddAccountAction({super.key});

  @override
  State<ConcordiumAddAccountAction> createState() =>
      _ConcordiumAddAccountActionState();
}

class _ConcordiumAddAccountActionState
    extends State<ConcordiumAddAccountAction> {
  final TextEditingController newAccountIndexTextController =
      TextEditingController();

  String accountAdress = '';
  String txHash = '';
  bool creatingNewAccount = false;

  @override
  Widget build(BuildContext context) {
    final ConcordiumBlockchainService concordiumBlockchainService =
        Modular.get<ConcordiumBlockchainService>();
    final ConcordiumVm concordiumVm = Modular.get<ConcordiumVm>();
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    return CryptoActionCard(
      title: 'Add Account',
      icon: Icons.account_tree,
      color: nearColors.nearGreen,
      height: 350.h,
      onTap: () async {
        try {
          setState(() {
            creatingNewAccount = true;
          });

          final identityProvider =
              (await concordiumBlockchainService.getIdentityProviders())
                  .firstWhere(
            (element) {
              return element.ipInfo["ipIdentity"] ==
                  concordiumVm.state.identityProviderIndex;
            },
          );

          // we dont have to store all time url to get identity info. we can recover it anytime
          final identityInfo =
              await concordiumBlockchainService.recoverExistingIdentity(
            mnemonic: concordiumVm.state.mnemonic,
            identityProvider: identityProvider,
            identityIndex:
                0, // hardcoded to 0 but can be any number from existing identitys
          );

          final res = await concordiumBlockchainService.createAccount(
            mnemonic: concordiumVm.state.mnemonic,
            identityInfo: identityInfo,
            identityProviderInfo: identityProvider,
            derivationPath: ConcordiumDerivationPath(
              identityProviderIndex: concordiumVm.state.identityProviderIndex,
              identityIndex:
                  0, // hardcoded to 0 but can be any number from existing identitys
              credentialIndex: int.parse(newAccountIndexTextController.text),
            ),
          );

          await concordiumVm.updateState(
            blockchainsData: [
              ...concordiumVm.state.blockchainsData,
              await concordiumBlockchainService.getBlockChainData(
                mnemonic: concordiumVm.state.mnemonic,
                derivationPath: ConcordiumDerivationPath(
                  identityProviderIndex:
                      concordiumVm.state.identityProviderIndex,
                  identityIndex: 0,
                  credentialIndex: int.parse(
                    newAccountIndexTextController.text,
                  ),
                ),
              ) as ConcordiumBlockChainData,
            ],
          );

          setState(() {
            accountAdress = res.data["accountAddress"];
            txHash = res.data["txHash"];
          });
        } finally {
          setState(() {
            creatingNewAccount = false;
          });
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            NearActionTextField(
              labelText: 'Account index',
              textEditingController: newAccountIndexTextController,
            ),
            const SizedBox(height: 20),
            if (creatingNewAccount) ...[
              const CircularProgressIndicator(),
            ],
            if (txHash.isNotEmpty) ...[
              SelectableText(
                'Account address: $accountAdress',
                style: const TextStyle(fontSize: 16),
              ),
              SelectableText(
                'Transaction hash: $txHash',
                style: const TextStyle(fontSize: 16),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
