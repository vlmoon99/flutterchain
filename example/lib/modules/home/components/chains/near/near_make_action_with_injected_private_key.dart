import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/formaters/chains/near_formater.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/near_action_text_field.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/see_tx_in_explorer.dart';
import 'package:flutterchain_example/modules/home/components/core/crypto_actions_card.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/ui_state.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/near_vm.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class NearMakeActionWithInjectedPrivateKeyInNearApiJsFormat
    extends StatefulWidget {
  const NearMakeActionWithInjectedPrivateKeyInNearApiJsFormat({super.key});

  @override
  State<NearMakeActionWithInjectedPrivateKeyInNearApiJsFormat> createState() =>
      _NearMakeActionWithInjectedPrivateKeyInNearApiJsFormatState();
}

class _NearMakeActionWithInjectedPrivateKeyInNearApiJsFormatState
    extends State<NearMakeActionWithInjectedPrivateKeyInNearApiJsFormat> {
  final TextEditingController recipientEditingController =
      TextEditingController();
  final TextEditingController transferDepositController =
      TextEditingController();

  final TextEditingController makeActionWithInjectedPrivateKey =
      TextEditingController();
  final TextEditingController makeActionWithInjectedAccountId =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    recipientEditingController.text = "pay4result_business.testnet";
    transferDepositController.text = "1";
    makeActionWithInjectedPrivateKey.text =
        'ed25519:w6iUJ6uLt1crmMcYMqeWXk3UVAzXzmgTibcsno639PCUfAQtxvbysXyxeeKja6BuwcA7B8gcMDXm4WiHAo6UgfF';
    makeActionWithInjectedAccountId.text = "vladddddd.testnet";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearVM = Modular.get<NearVM>();
    final currentState = nearVM.nearState.value as SuccessNearBlockchainState;
    return CryptoActionCard(
      title:
          'Make Transfer with injected private key\n(from near api js format)',
      height: 700,
      icon: Icons.key_rounded,
      color: nearColors.nearGreen,
      onTap: () async {
        final privateKey = makeActionWithInjectedPrivateKey.text;
        final recipient = recipientEditingController.text;
        final amount = transferDepositController.text;
        final accountIdOfInjectedKey = makeActionWithInjectedAccountId.text;
        final nearService = NearBlockChainService.defaultInstance();
        final pubKeyFromSecretKeyNearApiJsFormat =
            await nearService.getPublicKeyFromSecretKeyFromNearApiJSFormat(
          privateKey.split(":").last,
        );
        log('pubKeyFromPrivateKey is $pubKeyFromSecretKeyNearApiJsFormat');
        final privKeyFromSecretKeyNearApiJsFormat =
            await nearService.getPrivateKeyFromSecretKeyFromNearApiJSFormat(
          privateKey.split(":").last,
        );
        log('privKeyFromSecretKeyNearApiJsFormat is $privKeyFromSecretKeyNearApiJsFormat');
        log('pubKeyBase58 ${await nearService.getBase58PubKeyFromHexValue(
          hexEncodedPubKey: pubKeyFromSecretKeyNearApiJsFormat,
        )}');
        final res = await nearService.sendTransferNativeCoin(
          recipient,
          accountIdOfInjectedKey,
          NearFormatter.nearToYoctoNear(amount),
          privKeyFromSecretKeyNearApiJsFormat,
          pubKeyFromSecretKeyNearApiJsFormat,
        );
        nearVM.nearState.add(
          currentState.copyWith(
            transferResult: res,
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              res.status == BlockchainResponses.success
                  ? 'Success action with injected private key'
                  : 'Failed action with injected private ',
            ),
          ),
        );
        log('Transfer is ${res.status}');
      },
      child: Column(
        children: [
          const SizedBox(height: 20),
          NearActionTextField(
            labelText: 'Injected Private Key',
            textEditingController: makeActionWithInjectedPrivateKey,
          ),
          // TextFormField(
          //   controller: makeActionWithInjectedPrivateKey,
          //   decoration: InputDecoration(
          //     border: const OutlineInputBorder(),
          //     labelText: 'Injected Private Key',
          //     labelStyle: nearTextStyles.bodyCopy!.copyWith(
          //       color: nearColors.nearBlack,
          //     ),
          //   ),
          // ),
          const SizedBox(height: 20),
          NearActionTextField(
            labelText: 'Public ID in near blockchain',
            textEditingController: makeActionWithInjectedAccountId,
          ),

          const SizedBox(height: 20),
          NearActionTextField(
            labelText: 'Recipient',
            textEditingController: recipientEditingController,
          ),

          const SizedBox(height: 20),
          NearActionTextField(
            labelText: 'Amount',
            textEditingController: transferDepositController,
          ),

          const SizedBox(height: 20),
          SeeTransactionInfoNearBlockchain(
            tx: currentState.transferResult?['txHash'].toString(),
          ),
        ],
      ),
    );
  }
}
