import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/bitcoin_blockchain_service.dart';
import 'package:flutterchain_example/modules/home/components/chains/bitcoin/bitcoin_crypto_action_header.dart';
import 'package:flutterchain_example/modules/home/components/chains/bitcoin/bitcoin_transfer_action.dart';
import 'package:flutterchain_example/modules/home/vms/chains/bitcoin/bitcoin_vm.dart';
import 'package:flutterchain_example/modules/home/vms/chains/bitcoin/ui_state_bitcoin.dart';

class BitcoinBlockchainPage extends StatefulWidget {
  const BitcoinBlockchainPage({super.key});

  @override
  State<BitcoinBlockchainPage> createState() => _BitcoinBlockchainPageState();
}

class _BitcoinBlockchainPageState extends State<BitcoinBlockchainPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    final nearVM = Modular.get<BitcoinVM>();
    String? accountId = (nearVM.cryptoLibrary.blockchainService
                    .blockchainServices[BlockChains.bitcoin]
                as BitcoinBlockChainService)
            .getAccountIdFromWalletRedirectOnTheWeb() ??
        '';

    if (accountId.isNotEmpty) {
      log("accountId was successfully added $accountId from The Flutter WEB Environment");
    }
  }

  @override
  Widget build(BuildContext context) {
    final bitcoinVM = Modular.get<BitcoinVM>();

    return StreamBuilder<BitcoinState>(
      stream: bitcoinVM.bitcoinState,
      builder: (context, snapshot) {
        final state = snapshot.data;

        if (state is ErrorBitcoinBlockchainState) {
          return Text('Error, error message ${state.message}');
        }
        if (state is SuccessBitcoinBlockchainState) {
          final isPortrait =
              MediaQuery.of(context).orientation == Orientation.portrait;
          log("isPortrait $isPortrait");
          return isPortrait
              ? SingleChildScrollView(
                  child: Column(
                    // key: UniqueKey(),
                    children: [
                      BitcoinCryptoActionHeader(),
                      BitcoinTransferAction(),
                    ],
                  ),
                )
              : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1,
                  child: GridView.count(
                    crossAxisCount: isPortrait ? 1 : 2,
                    children: [
                      BitcoinCryptoActionHeader(),
                      BitcoinTransferAction(),
                    ],
                  ),
                );
        }
        return const Text("Undefined  state");
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
