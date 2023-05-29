import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/near_vm.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class SeeTheLastTxNearBlockchainComponent extends StatelessWidget {
  const SeeTheLastTxNearBlockchainComponent({
    super.key,
    required this.tx,
  });
  final String tx;

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    final nearVM = Modular.get<NearVM>();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () async {
        log("tx $tx");
        // final currentEnvironment = await nearVM.cryptoLibrary.blockchainService
        //     .getBlockchainNetworkEnvironment(
        //   blockchainType: BlockChains.near,
        // );

        // if (tx == null) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(
        //       content: Text(
        //         'Please execute action \nAfter you can see the transaction',
        //       ),
        //     ),
        //   );

        //   return;
        // }
        // await nearVM.nearHelperService.launchInBrowser(
        //   Uri.parse(
        //       'https://explorer.${currentEnvironment.split('.').sublist(1).join('.')}/transactions/$tx'),
        // );
      },
      child: Container(
        margin: const EdgeInsets.only(
          top: 70,
        ),
        alignment: Alignment.center,
        width: width * 0.85,
        height: height * 0.07,
        decoration: BoxDecoration(
          color: tx == null ? nearColors.nearGray : nearColors.nearAqua,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 1),
              blurRadius: 2,
              spreadRadius: -1,
            ),
          ],
        ),
        child: Text(
          "See last transaction info in the explorer",
          style: nearTextStyles.bodyCopy!.copyWith(
            color: nearColors.nearWhite,
            fontWeight: FontWeight.w600,
            fontSize: 15.sp,
          ),
        ),
      ),
    );
  }
}
