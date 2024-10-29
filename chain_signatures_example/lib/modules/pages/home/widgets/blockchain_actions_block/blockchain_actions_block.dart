import 'dart:developer';

import 'package:chain_signatures_example/constants/avaliable_blockchains_info.dart';
import 'package:chain_signatures_example/constants/theme.dart';
import 'package:chain_signatures_example/modules/pages/home/widgets/blockchain_actions_block/chain_actions.dart';
import 'package:chain_signatures_example/modules/pages/home/widgets/blockchain_actions_block/chain_balance_card.dart';
import 'package:chain_signatures_example/modules/vms/auth_controller.dart';
import 'package:chain_signatures_example/modules/vms/models/auth_info.dart';
import 'package:chain_signatures_example/widgets/rounded_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_mpc_account_info.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';

class BlockChainActionsBlock extends StatefulWidget {
  const BlockChainActionsBlock({
    super.key,
  });

  @override
  State<BlockChainActionsBlock> createState() => _BlockChainActionsBlockState();
}

class _BlockChainActionsBlockState extends State<BlockChainActionsBlock> {
  String selectedBlockchain = BlockChains.ethereum;
  final TextEditingController derivationPathController = TextEditingController()
    ..text = "flutterchain";
  late String derivationPath = derivationPathController.text;

  MPCAccountInfo? mpcAccountInfo;

  @override
  void didChangeDependencies() async {
    updateMpcAccountInfo();
    super.didChangeDependencies();
  }

  void updateMpcAccountInfo() async {
    final authController = Modular.get<AuthController>();
    context
        .read<NearBlockChainService>()
        .getMPCAccount(
          accountId: authController.state.accountId,
          typeOfNetwork:
              authController.state.networkType == NearNetworkType.testnet
                  ? "testnet"
                  : "mainnet",
          chain: selectedBlockchain,
          path: derivationPath,
        )
        .then((value) {
      setState(() {
        mpcAccountInfo = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20).r,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 2,
            spreadRadius: 0,
          )
        ],
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ).r,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          chainSelector(context),
          SizedBox(height: 19.h),
          Center(
            child: ExpansionTile(
              title: Text(
                "Derivation path settings",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              backgroundColor: AppColors.darkGrey,
              collapsedBackgroundColor: AppColors.darkGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16).r,
              ),
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16).r,
              ),
              childrenPadding: const EdgeInsets.all(20).r,
              children: [
                RoundedTextField(
                  textEditingController: derivationPathController,
                  labelText: "Derivation path",
                  fontSize: 17,
                ),
                SizedBox(height: 10.h),
                FilledButton(
                  onPressed: () {
                    derivationPath = derivationPathController.text;
                    updateMpcAccountInfo();
                  },
                  child: Text(
                    "Change",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 19.h),
          if (mpcAccountInfo != null)
            ChainAccountInfoAndActions(
              accountInfo: mpcAccountInfo!,
              chain: selectedBlockchain,
              derivationPath: derivationPath,
            ),
        ],
      ),
    );
  }

  Widget chainSelector(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Blockchain: ",
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              width: 3.0,
              style: BorderStyle.solid,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12).r,
            ),
          ),
          onPressed: () async {
            // FocusManager.instance.primaryFocus?.unfocus();
            FocusScope.of(context).unfocus();

            final String? newChain = await showDialog(
              context: context,
              builder: (_) {
                return Dialog(
                  backgroundColor: AppColors.darkGrey,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 19, bottom: 16).r,
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        ...AvaliableBlockchainsInfo.availableChains.map(
                          (chain) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 3).r,
                              child: DecoratedBox(
                                decoration: const BoxDecoration(
                                  color: AppColors.white,
                                ),
                                child: ListTile(
                                  leading: SvgPicture.asset(
                                    AvaliableBlockchainsInfo.chainsLogos[chain],
                                    height: 30.h,
                                    width: 30.h,
                                  ),
                                  title: Text(
                                    chain,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onTap: () {
                                    Modular.to.pop(chain);
                                  },
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            );
            FocusScope.of(context).requestFocus(FocusNode());

            if (newChain != null) {
              setState(() {
                selectedBlockchain = newChain;
              });
              updateMpcAccountInfo();
            }
            log("Selected blockchain: $selectedBlockchain");
          },
          child: Text(
            selectedBlockchain,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class ChainAccountInfoAndActions extends StatefulWidget {
  const ChainAccountInfoAndActions({
    super.key,
    required this.accountInfo,
    required this.chain,
    required this.derivationPath,
  });

  final String chain;
  final MPCAccountInfo accountInfo;
  final String derivationPath;

  @override
  State<ChainAccountInfoAndActions> createState() =>
      _ChainAccountInfoAndActionsState();
}

class _ChainAccountInfoAndActionsState
    extends State<ChainAccountInfoAndActions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SelectableText.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.greyTextColor,
            ),
            text: "Address: ",
            children: [
              TextSpan(
                text: widget.accountInfo.address,
                style: const TextStyle(color: AppColors.black),
              ),
            ],
          ),
        ),
        SizedBox(height: 19.h),
        ChainBalanceInfo(
          chainAddress: widget.accountInfo.address,
          chain: widget.chain,
        ),
        SizedBox(height: 19.h),
        ChainActions(
          accountInfo: widget.accountInfo,
          chain: widget.chain,
          derivationPath: widget.derivationPath,
        ),
      ],
    );
  }
}
