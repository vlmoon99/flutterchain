import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/formaters/chains/near_formater.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
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
    makeActionWithInjectedPrivateKey.text = 'ed25519:your_secret_key';
    makeActionWithInjectedAccountId.text = "your.testnet";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    final nearVM = Modular.get<NearVM>();
    final currentState = nearVM.nearState.value as SuccessNearBlockchainState;
    return CryptoActionCard(
      title:
          'Make Transfer with injected private key\n(from near api js format)',
      height: 650,
      icon: Icons.key_rounded,
      color: nearColors.nearGreen,
      onTap: () async {
        final privateKey = makeActionWithInjectedPrivateKey.text;
        final recipient = recipientEditingController.text;
        final amount = transferDepositController.text;
        final accountIdOfInjectedKey = makeActionWithInjectedAccountId.text;
        final nearService = nearVM.cryptoLibrary.blockchainService
            .blockchainServices[BlockChains.near] as NearBlockChainService;
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
          TextFormField(
            controller: makeActionWithInjectedPrivateKey,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Injected Private Key',
              labelStyle: nearTextStyles.bodyCopy!.copyWith(
                color: nearColors.nearBlack,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: makeActionWithInjectedAccountId,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Public ID in near blockchain',
              labelStyle: nearTextStyles.bodyCopy!.copyWith(
                color: nearColors.nearBlack,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: recipientEditingController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Recipient',
              labelStyle: nearTextStyles.bodyCopy!.copyWith(
                color: nearColors.nearBlack,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: transferDepositController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: 'Amount',
              labelStyle: nearTextStyles.bodyCopy!.copyWith(
                color: nearColors.nearBlack,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
