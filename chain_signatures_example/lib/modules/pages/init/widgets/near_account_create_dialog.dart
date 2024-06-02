import 'dart:convert';
import 'dart:developer';

import 'package:chain_signatures_example/constants/routs.dart';
import 'package:chain_signatures_example/constants/storage_keys.dart';
import 'package:chain_signatures_example/modules/vms/auth_controller.dart';
import 'package:chain_signatures_example/modules/vms/models/auth_info.dart';
import 'package:chain_signatures_example/modules/vms/models/authorization_credentials.dart';
import 'package:chain_signatures_example/widgets/custom_loading_indicator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/near_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/bitcoin_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/core/crypto_service.dart';
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/platforms_implementations/webview_js_engine.dart';

class NearAccountCreationActionDialog extends StatefulWidget {
  const NearAccountCreationActionDialog({
    super.key,
    required this.networkType,
  });

  final NearNetworkType networkType;

  @override
  State<NearAccountCreationActionDialog> createState() =>
      _NearAccountCreationActionDialogState();
}

class _NearAccountCreationActionDialogState
    extends State<NearAccountCreationActionDialog> {
  String currentActionLog = '';

  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      setState(() {
        currentActionLog = 'Creating Near account...';
      });

      final nearBlockChainService = context.read<NearBlockChainService>();
      nearBlockChainService.setBlockchainNetworkEnvironment(
        newUrl: widget.networkType == NearNetworkType.mainnet
            ? NearBlockChainNetworkUrls.listOfUrls.elementAt(1)
            : NearBlockChainNetworkUrls.listOfUrls.first,
      );

      final flutterChainService = FlutterChainService(
        jsVMService: getJsVM(),
        nearBlockchainService: nearBlockChainService,
        bitcoinBlockchainService: BitcoinBlockChainService.defaultInstance(),
      );

      final generatedWallet = await flutterChainService.generateNewWallet(
          walletName: "GeneratedRandom ${DateTime.now()}");

      const derivationPathOfNewGeneratedAccount = DerivationPath(
        purpose: "44'",
        coinType: "397'",
        accountNumber: "0'",
        change: "0'",
        address: "1'",
      );

      final NearBlockChainData nearBlockChainData =
          await nearBlockChainService.getBlockChainDataByDerivationPath(
        mnemonic: generatedWallet.mnemonic,
        passphrase: "",
        derivationPath: derivationPathOfNewGeneratedAccount,
      );

      final privateKeyInNearApiJsFormat =
          await nearBlockChainService.exportPrivateKeyToTheNearApiJsFormat(
        currentBlockchainData: nearBlockChainData,
      );

      log("TestNet account public key: ${nearBlockChainData.publicKey}");
      log("TestNet account secret key: $privateKeyInNearApiJsFormat");

      if (!mounted) return;
      setState(() {
        currentActionLog = "Funding it...";
      });

      final fundRequest = await Dio().post(
        "https://server-for-account-creation.onrender.com/create-account",
        data: {
          "accountId": nearBlockChainData.publicKey,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      log(fundRequest.data['message']);

      if (!mounted) return;
      setState(() {
        currentActionLog = "Few more steps...";
      });

      await context.read<AuthController>().login(
            accountId: nearBlockChainData.publicKey,
            secretKey: privateKeyInNearApiJsFormat,
            networkType: widget.networkType,
          );

      await context.read<FlutterSecureStorage>().write(
            key: SecureStorageKeys.authInfo,
            value: jsonEncode(
              AuthorizationCredentials(
                nearBlockChainData.publicKey,
                privateKeyInNearApiJsFormat,
                widget.networkType,
              ),
            ),
          );
      Modular.to.navigate(".${MainRoutes.home}");
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 40.h),
        const CustomLoadingIndicator(),
        SizedBox(height: 20.h),
        Text(
          currentActionLog,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}
