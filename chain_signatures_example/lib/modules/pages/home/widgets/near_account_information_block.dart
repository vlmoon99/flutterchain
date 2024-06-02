import 'dart:developer';

import 'package:chain_signatures_example/constants/theme.dart';
import 'package:chain_signatures_example/modules/vms/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';

class NearAccountInformationBlock extends StatefulWidget {
  const NearAccountInformationBlock({
    super.key,
  });

  @override
  State<NearAccountInformationBlock> createState() =>
      _NearAccountInformationBlockState();
}

class _NearAccountInformationBlockState
    extends State<NearAccountInformationBlock>
    with SingleTickerProviderStateMixin {
  late final AnimationController balanceAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );

  double? balance;

  Future<void> updateBalance(String accountId) async {
    try {
      balanceAnimationController.repeat();
      final nearBlockChainService = context.read<NearBlockChainService>();
      final balanceInString = await nearBlockChainService
          .getWalletBalance(NearTransferRequest(accountID: accountId));
      setState(() {
        balance = double.parse(balanceInString);
      });
    } catch (err) {
      if (err is NoSuchMethodError) {
        await Future.delayed(const Duration(seconds: 5), () async {
          await updateBalance(accountId);
        });
      }
      log(err.toString());
    } finally {
      balanceAnimationController.fling();
    }
  }

  @override
  void dispose() {
    balanceAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Modular.get<AuthController>();
    if (balance == null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) async {
          await updateBalance(authController.state.accountId);
        },
      );
    }
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5).r,
            child: Text(
              "Your Near Account",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20).r,
          child: SelectableText.rich(
            TextSpan(
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.greyTextColor,
              ),
              text: "Address: ",
              children: [
                TextSpan(
                  text: authController.state.accountId,
                  style: const TextStyle(color: AppColors.black),
                ),
              ],
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.greyTextColor,
                    ),
                    text: "Balance: ",
                    children: [
                      TextSpan(
                        text: balance == null ? "Loading..." : "$balance NEAR",
                        style: const TextStyle(color: AppColors.black),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (balanceAnimationController.isAnimating) {
                      return;
                    }
                    await updateBalance(authController.state.accountId);
                  },
                  icon: RotationTransition(
                    turns: balanceAnimationController,
                    child: const Icon(
                      Icons.refresh,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
