import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/near_vm.dart';

class LoginWithMyNearWallets extends StatelessWidget {
  const LoginWithMyNearWallets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final nearVM = Modular.get<NearVM>();

        final randomWallet = await nearVM.cryptoLibrary.blockchainService
            .generateNewWallet(walletName: "Random Wallet");
        final nearBlockchainService = nearVM.cryptoLibrary.blockchainService
            .blockchainServices[BlockChains.near] as NearBlockChainService;

        final randomNearBlockchainData =
            await nearBlockchainService.getBlockChainDataFromMnemonic(
          randomWallet.mnemonic,
          '',
        );

        final nearAPIJsPrivateKey =
            await nearBlockchainService.exportPrivateKeyToTheNearApiJsFormat(
                currentBlockchainData: randomNearBlockchainData);

        log("nearAPIJsPrivateKey $nearAPIJsPrivateKey");
        if (kIsWeb) {
          // ignore: use_build_context_synchronously
          nearBlockchainService.authWithNearWalletsWeb(nearAPIJsPrivateKey);
          return;
        }
        // ignore: use_build_context_synchronously
        nearBlockchainService
            .authWithNearWallets(context, nearAPIJsPrivateKey)
            .then((addedAccountId) {
          log("addedAccountId $addedAccountId was added sucsessfuly");
          log("nearAPIJsPrivateKey $nearAPIJsPrivateKey was added sucsessfuly");
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.width * 0.2,
        margin: const EdgeInsets.only(
          top: 10,
          bottom: 30,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.amber,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          "Login with Near",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
