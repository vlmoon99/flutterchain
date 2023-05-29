import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/near_vm.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class SeeTransactionInfoNearBlockchain extends StatefulWidget {
  const SeeTransactionInfoNearBlockchain({super.key, required this.tx});

  final String? tx;

  @override
  State<SeeTransactionInfoNearBlockchain> createState() =>
      _SeeTransactionInfoNearBlockchainState();
}

class _SeeTransactionInfoNearBlockchainState
    extends State<SeeTransactionInfoNearBlockchain> {
  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    final nearVM = Modular.get<NearVM>();

    return InkWell(
      onTap: () async {
        final currentEnvironment = await nearVM.cryptoLibrary.blockchainService
            .getBlockchainNetworkEnvironment(
          blockchainType: BlockChains.near,
        );

        if (widget.tx == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Please execute action \nAfter you can see the transaction',
              ),
            ),
          );

          return;
        }
        await nearVM.nearHelperService.launchInBrowser(
          Uri.parse(
              'https://explorer.${currentEnvironment.split('.').sublist(1).join('.')}/transactions/${widget.tx}'),
        );
      },
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.05,
        child: Text(
          'Tx: ${(widget.tx?.length ?? 0) > 50 ? "${widget.tx.toString().substring(0, 50)}..." : widget.tx.toString()}',
          style: nearTextStyles.headline!.copyWith(
            fontWeight: FontWeight.bold,
            color: nearColors.nearBlack,
            fontSize: 13.sp,
          ),
        ),
      ),
    );
  }
}
