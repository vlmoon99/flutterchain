import 'dart:convert';

import 'package:chain_signatures_example/constants/routs.dart';
import 'package:chain_signatures_example/constants/storage_keys.dart';
import 'package:chain_signatures_example/modules/vms/models/auth_info.dart';
import 'package:chain_signatures_example/modules/vms/models/authorization_credentials.dart';
import 'package:chain_signatures_example/widgets/custom_loading_indicator.dart';
import 'package:chain_signatures_example/widgets/rounded_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NearAccountImportActionDialog extends StatefulWidget {
  const NearAccountImportActionDialog({
    super.key,
    required this.networkType,
  });

  final NearNetworkType networkType;

  @override
  State<NearAccountImportActionDialog> createState() =>
      _NearAccountImportActionDialogState();
}

class _NearAccountImportActionDialogState
    extends State<NearAccountImportActionDialog> {
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

                final FlutterSecureStorage secureStorage =
                    context.read<FlutterSecureStorage>();
                await secureStorage.write(
                  key: SecureStorageKeys.authInfo,
                  value: jsonEncode(
                    AuthorizationCredentials(
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

                Modular.to.navigate(".${MainRoutes.home}");
              },
              child: Text(
                'Import Near account',
                style: TextStyle(
                  fontSize: 16.sp,
                ),
              ),
            )
          else
            const CustomLoadingIndicator()
        ],
      ),
    );
  }
}
