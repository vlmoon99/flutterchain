import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/modules/home/components/chains/concordium/concordium_add_account_action.dart';
import 'package:flutterchain_example/modules/home/components/chains/concordium/concordium_baker_tx.dart';
import 'package:flutterchain_example/modules/home/components/chains/concordium/concordium_crypto_action_header.dart';
import 'package:flutterchain_example/modules/home/components/chains/concordium/concordium_delegation_tx.dart';
import 'package:flutterchain_example/modules/home/components/chains/concordium/concordium_identity_info.dart';
import 'package:flutterchain_example/modules/home/components/chains/concordium/concrodium_transer_action.dart';
import 'package:flutterchain_example/modules/home/vms/chains/concordium_vm.dart';

class ConcordiumBlockchainPage extends StatefulWidget {
  const ConcordiumBlockchainPage({super.key});

  @override
  State<ConcordiumBlockchainPage> createState() =>
      _ConcordiumBlockchainPageState();
}

class _ConcordiumBlockchainPageState extends State<ConcordiumBlockchainPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Modular.get<ConcordiumVm>().loadStateFromStorage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final isPortrait =
              MediaQuery.of(context).orientation == Orientation.portrait;
          return Scaffold(
            body: SafeArea(
              child: isPortrait
                  ? const SingleChildScrollView(
                      child: Column(
                        children: [
                          ConcordiumCryptoActionHeader(),
                          ConcordiumIdentityInfo(),
                          ConcordiumAddAccountAction(),
                          ConcrodiumTransferAction(),
                          ConcordiumDelegationTx(),
                          ConcordiumBakerTx(),
                        ],
                      ),
                    )
                  : SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 1,
                      child: GridView.count(
                        crossAxisCount: isPortrait ? 1 : 2,
                        children: const [
                          ConcordiumCryptoActionHeader(),
                          ConcordiumIdentityInfo(),
                          ConcordiumAddAccountAction(),
                          ConcrodiumTransferAction(),
                          ConcordiumDelegationTx(),
                          ConcordiumBakerTx(),
                        ],
                      ),
                    ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
