import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/see_tx_in_explorer.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class TransactionResult extends StatefulWidget {
  const TransactionResult(
      {super.key, required this.response, required this.txHash});
  final String response;
  final String txHash;

  @override
  State<TransactionResult> createState() => _TransactionResultState();
}

class _TransactionResultState extends State<TransactionResult> {
  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            'Result: ${(widget.response.toString().length) > 50 ? "${widget.response.toString().substring(0, 50)}..." : widget.response.toString()}',
            style: nearTextStyles.headline!.copyWith(
              fontWeight: FontWeight.bold,
              color: nearColors.nearBlack,
              fontSize: 13.sp,
            ),
          ),
          const SizedBox(height: 20),
          SeeTransactionInfoNearBlockchain(
            tx: widget.txHash.toString(),
          ),
        ],
      ),
    );
  }
}
