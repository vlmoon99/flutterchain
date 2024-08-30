import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mintbase_example/consts/secure_storage_keys.dart';
import 'package:mintbase_example/modules/models/authorized_model/authorized.dart';
import 'package:mintbase_example/modules/models/auth_info_model/auth_info.dart';
import 'package:mintbase_example/modules/controllers/auth_controller.dart';
import 'package:mintbase_example/widget/rounded_text_field.dart';

class NearAccountImportActionDialogDefault extends StatefulWidget {
  const NearAccountImportActionDialogDefault({
    super.key,
    required this.networkType,
  });

  final NearNetworkType networkType;

  @override
  State<NearAccountImportActionDialogDefault> createState() =>
      _NearAccountImportActionDialogDefaultState();
}

class _NearAccountImportActionDialogDefaultState
    extends State<NearAccountImportActionDialogDefault> {
  bool loading = false;

  final TextEditingController accountIdController = TextEditingController();
  final TextEditingController privateKeyController = TextEditingController();

  void accountCredentialsValidation() {
    if (accountIdController.text.isEmpty) {
      throw Exception('Account ID is required');
    }
    if (accountIdController.text.length < 6) {
      throw Exception('Account ID isn\'t valid');
    }

    if (privateKeyController.text.isEmpty) {
      throw Exception('Private key is required');
    }

    if (privateKeyController.text.startsWith('ed25519:')) {
      throw Exception('Private key isn\'t valid');
    }
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
          RoundedTextField(
            textEditingController: accountIdController,
            labelText: "Account ID",
          ),
          SizedBox(height: 25.h),
          RoundedTextField(
            textEditingController: privateKeyController,
            labelText: "Private Key",
          ),
          SizedBox(height: 30.h),
          if (!loading)
            FilledButton(
              onPressed: () async {
                accountCredentialsValidation();
                setState(() {
                  loading = true;
                });

                await Modular.get<AuthController>(key: "AuthController")
                    .loginDefault(
                        accountId: accountIdController.text,
                        secretKey: privateKeyController.text,
                        networkType: widget.networkType);

                final FlutterSecureStorage secureStorage =
                    Modular.get<FlutterSecureStorage>();
                await secureStorage.write(
                  key: SecureStorageKeys.info,
                  value: jsonEncode(
                    Authorized(
                      accountIdController.text,
                      privateKeyController.text,
                      widget.networkType,
                    ),
                  ),
                );

                if (!mounted) return;
                setState(() {
                  loading = false;
                });

                Modular.to.pushNamed("//home/auth");
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
  }
}
