import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterchain/flutterchain_lib/formaters/chains/concordium_formatter.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/concordium_blockchain_service.dart';
import 'package:flutterchain_example/modules/home/components/core/crypto_actions_card.dart';
import 'package:flutterchain_example/modules/home/vms/chains/concordium_vm.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class ConcordiumCryptoActionHeader extends StatefulWidget {
  const ConcordiumCryptoActionHeader({super.key});

  @override
  State<ConcordiumCryptoActionHeader> createState() =>
      _ConcordiumCryptoActionHeaderState();
}

class _ConcordiumCryptoActionHeaderState
    extends State<ConcordiumCryptoActionHeader> {
  ConcordiumBlockchainData? concordiumBlockchainData;
  bool gettingTestNetMoney = false;
  late final Timer updateTimer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final ConcordiumVm concordiumVm = Modular.get<ConcordiumVm>();
    concordiumBlockchainData = concordiumVm.state.blockchainsData.firstWhere(
      (element) =>
          element.derivationPath.credentialIndex ==
          concordiumVm.state.currentBlockchainIndex,
    );
    updateTimer = Timer.periodic(
      Duration(seconds: 10),
      (timer) {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    updateTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ConcordiumBlockchainService concordiumBlockchainService =
        Modular.get<ConcordiumBlockchainService>();
    final ConcordiumVm concordiumVm = Modular.get<ConcordiumVm>();
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    return StreamBuilder(
        stream: concordiumVm.stream,
        builder: (context, snapshot) {
          return CryptoActionCard(
            title: "Accounts",
            icon: Icons.key,
            color: nearColors.nearPurple,
            height: 450.h,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Choosen Account: "),
                  FittedBox(
                    child: DropdownButton<ConcordiumBlockchainData>(
                      value: concordiumBlockchainData,
                      items: concordiumVm.state.blockchainsData
                          .map((ConcordiumBlockchainData value) {
                        return DropdownMenuItem<ConcordiumBlockchainData>(
                          value: value,
                          child: Text(
                            "${value.derivationPath.credentialIndex}: ${value.accountAddress}",
                          ),
                        );
                      }).toList(),
                      onChanged: (ConcordiumBlockchainData? newValue) async {
                        setState(() {
                          concordiumBlockchainData = newValue;
                        });
                        await concordiumVm.updateState(
                          currentBlockchainIndex:
                              newValue!.derivationPath.credentialIndex,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SelectableText(
                    "Account Address: ${concordiumBlockchainData!.accountAddress}",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  SelectableText(
                    "Public Key: ${concordiumBlockchainData!.publicKey}",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  SelectableText(
                    "Signing Key: ${concordiumBlockchainData!.signingKey}",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder(
                    future: concordiumBlockchainService.getAccountInfo(
                        accountAddress:
                            concordiumBlockchainData!.accountAddress),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          "Amount: ${ConcordiumFormatter.convertMicroCcdToCcd(int.parse(snapshot.data!.accountAmount))} CCD",
                          style: TextStyle(fontSize: 16),
                        );
                      } else {
                        return const Text("Loading...");
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  gettingTestNetMoney
                      ? const CircularProgressIndicator()
                      : FilledButton(
                          onPressed: () async {
                            try {
                              setState(() {
                                gettingTestNetMoney = true;
                              });
                              final Dio dio = Dio();
                              await dio.put(
                                  "https://wallet-proxy.testnet.concordium.com/v0/testnetGTUDrop/${concordiumBlockchainData!.accountAddress}");
                            } finally {
                              setState(() {
                                gettingTestNetMoney = false;
                              });
                            }
                          },
                          child: const Text(
                            "Get TestNet CCD",
                          ),
                        ),
                ],
              ),
            ),
          );
        });
  }
}
