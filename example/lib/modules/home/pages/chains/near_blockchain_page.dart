import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/export_key_in_near_api_js_format_action.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/near_add_key_action.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/near_insert_new_blockchaindata_action.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/near_crypto_action_header.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/near_make_action_with_injected_private_key.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/near_transfer_action.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/ui_state.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/near_vm.dart';

class NearBlockchainPage extends StatelessWidget {
  const NearBlockchainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nearVM = Modular.get<NearVM>();

    return StreamBuilder<NearState>(
      stream: nearVM.nearState,
      builder: (context, snapshot) {
        return Column(
          key: UniqueKey(),
          children: const [
            NearCryptoActionHeader(),
            NearInsertNewBlockchainDataInsideWallet(),
            NearTransferAction(),
            NearAddKeyAction(),
            NearMakeActionWithInjectedPrivateKeyInNearApiJsFormat(),
            ExportKeyInNearApiJsFormat(),
          ],
        );
      },
    );
  }
}
