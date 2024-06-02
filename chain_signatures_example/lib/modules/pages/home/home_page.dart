import 'dart:convert';

import 'package:chain_signatures_example/constants/routs.dart';
import 'package:chain_signatures_example/constants/storage_keys.dart';
import 'package:chain_signatures_example/modules/pages/home/widgets/blockchain_actions_block/blockchain_actions_block.dart';
import 'package:chain_signatures_example/modules/pages/home/widgets/home_load_banner.dart';
import 'package:chain_signatures_example/modules/pages/home/widgets/near_account_information_block.dart';
import 'package:chain_signatures_example/modules/vms/auth_controller.dart';
import 'package:chain_signatures_example/modules/vms/models/auth_info.dart';
import 'package:chain_signatures_example/modules/vms/models/authorization_credentials.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void didChangeDependencies() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authController = Modular.get<AuthController>();
      if (authController.state.status == AuthInfoStatus.unauthenticated) {
        final authRawData = await context
            .read<FlutterSecureStorage>()
            .read(key: SecureStorageKeys.authInfo);
        final authInfo =
            AuthorizationCredentials.fromJson(jsonDecode(authRawData!));
        await authController.login(
          accountId: authInfo.accountId,
          secretKey: authInfo.secretKey,
          networkType: authInfo.networkType,
        );
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Modular.get<AuthController>();
    return StreamBuilder(
      stream: authController.stream,
      builder: (context, snapshot) {
        if (authController.state.status == AuthInfoStatus.unauthenticated) {
          return const HomeLoadingBanner();
        } else {
          return const HomeMainBody();
        }
      },
    );
  }
}

class HomeMainBody extends StatelessWidget {
  const HomeMainBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              "assets/near-protocol-near-logo.svg",
              width: 25.w,
              height: 25.w,
            ),
            SizedBox(width: 10.w),
            Text(
              "Near Chain Signatures",
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12).r,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: "Sign Out",
                  child: Text("Sign Out", style: TextStyle(fontSize: 16.sp)),
                ),
              ];
            },
            onSelected: (value) {
              if (value == "Sign Out") {
                context.read<AuthController>().logout().then((_) {
                  Modular.to.navigate(".${MainRoutes.auth}");
                });
              }
            },
          ),
        ],
      ),
      body: ListView(
        children: const [
          NearAccountInformationBlock(),
          BlockChainActionsBlock(),
        ],
      ),
    );
  }
}
