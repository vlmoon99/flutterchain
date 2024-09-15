import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/chain_signatures_functions.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/export_key_in_near_api_js_format_action.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/login_with_mynear_wallet.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/near_activate_testnet_account.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/near_add_key_action.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/near_delete_key_action.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/near_insert_new_blockchaindata_action.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/near_crypto_action_header.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/near_make_action_with_injected_private_key.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/near_smart_contract_call_action.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/near_transfer_action.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/ui_state.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/near_vm.dart';

class NearBlockchainPage extends StatefulWidget {
  const NearBlockchainPage({super.key});

  @override
  State<NearBlockchainPage> createState() => _NearBlockchainPageState();
}

class _NearBlockchainPageState extends State<NearBlockchainPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    final nearVM = Modular.get<NearVM>();
    String? accountId = (nearVM.cryptoLibrary.blockchainService
                .blockchainServices[BlockChains.near] as NearBlockChainService)
            .getAccountIdFromWalletRedirectOnTheWeb() ??
        '';

    if (accountId.isNotEmpty) {
      log("accountId was sucsessfuly added $accountId from The Flutter WEB Enviroment");
    }
  }

  @override
  Widget build(BuildContext context) {
    final nearVM = Modular.get<NearVM>();

    return StreamBuilder<NearState>(
      stream: nearVM.nearState,
      builder: (context, snapshot) {
        final state = snapshot.data;

        if (state is ErrorNearBlockchainState) {
          return Text('Error, error message ${state.message}');
        }
        if (state is SuccessNearBlockchainState) {
          final isPortrait =
              MediaQuery.of(context).orientation == Orientation.portrait;
          log("isPortrait $isPortrait");
          return isPortrait
              ? SingleChildScrollView(
                  child: Column(
                    // key: UniqueKey(),
                    children: [
                      LoginWithMyNearWallets(),
                      NearCryptoActionHeader(),
                      NearActivateTestNetAccount(),
                      NearInsertNewBlockchainDataInsideWallet(),
                      NearSmartContractCall(),
                      NearTransferAction(),
                      NearAddKeyAction(),
                      NearDeleteKeyAction(),
                      NearMakeActionWithInjectedPrivateKeyInNearApiJsFormat(),
                      ChainSignatureFunctions(),
                      ExportKeyInNearApiJsFormat(),
                    ],
                  ),
                )
              : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 1,
                  child: GridView.count(
                    crossAxisCount: isPortrait ? 1 : 2,
                    children: [
                      NearCryptoActionHeader(),
                      NearActivateTestNetAccount(),
                      NearInsertNewBlockchainDataInsideWallet(),
                      NearSmartContractCall(),
                      NearTransferAction(),
                      NearAddKeyAction(),
                      NearDeleteKeyAction(),
                      NearMakeActionWithInjectedPrivateKeyInNearApiJsFormat(),
                      ChainSignatureFunctions(),
                      ExportKeyInNearApiJsFormat(),
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
