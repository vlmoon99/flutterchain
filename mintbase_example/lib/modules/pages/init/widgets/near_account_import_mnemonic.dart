import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/consts/secure_storage_keys.dart';
import 'package:mintbase_example/modules/models/authorized.dart';
import 'package:mintbase_example/modules/models/models.dart';
import 'package:mintbase_example/modules/services/auth_controller.dart';
import 'package:mintbase_example/routes/routes.dart';
import 'package:mintbase_example/widget/rounded_text_field.dart';

class NearAccountImportMnemonic extends StatefulWidget {
  final NearNetworkType networkType;

  const NearAccountImportMnemonic({
    super.key,
    required this.networkType,
  });

  @override
  State<NearAccountImportMnemonic> createState() =>
      _NearAccountImportMnemonicState();
}

class _NearAccountImportMnemonicState extends State<NearAccountImportMnemonic> {
  bool loading = false;

  final TextEditingController mnemonicController = TextEditingController();
  final TextEditingController acountIDController = TextEditingController();

  Future<NearBlockChainData> getAccountInfo({required String mnemonic}) async {
    if (mnemonicController.text == null) {
      throw Exception("Input mnemonic");
    }
    final passphrase = "";
    return await Modular.get<NearBlockChainService>()
        .getBlockChainDataFromMnemonic(mnemonic, passphrase);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 46,
      ).r,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 30.h),
          RoundedTextField(
            textEditingController: acountIDController,
            labelText: "AcountID",
          ),
          SizedBox(height: 30.h),
          SizedBox(height: 30.h),
          RoundedTextField(
            textEditingController: mnemonicController,
            labelText: "Mnemonic",
          ),
          SizedBox(height: 30.h),
          if (!loading)
            FilledButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                });

                final accountInfo =
                    await getAccountInfo(mnemonic: mnemonicController.text);

                Modular.get<AuthController>(key: "AuthController").login(
                    accountId: acountIDController.text,
                    secretKey: accountInfo.privateKey,
                    networkType: widget.networkType);

                final FlutterSecureStorage secureStorage =
                    Modular.get<FlutterSecureStorage>();
                await secureStorage.write(
                  key: SecureStorageKeys.info,
                  value: jsonEncode(
                    Authorized(
                      acountIDController.text,
                      accountInfo.privateKey,
                      widget.networkType,
                    ),
                  ),
                );

                if (!mounted) return;
                setState(() {
                  loading = false;
                });

                Modular.to.navigate("${CoreRoutes.auth}");
              },
              child: Text(
                'Import Near account',
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            )
          else
            const CircularProgressIndicator()
        ],
      ),
    );
    ;
  }
}
