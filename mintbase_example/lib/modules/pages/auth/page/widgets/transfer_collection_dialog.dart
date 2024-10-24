import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/thems/thems.dart';
import 'package:mintbase_example/modules/controllers/auth_controller.dart';

class TransferCollectionDialog extends StatefulWidget {
  const TransferCollectionDialog({super.key});

  @override
  State<TransferCollectionDialog> createState() =>
      _TransferCollectionDialogState();
}

class _TransferCollectionDialogState extends State<TransferCollectionDialog> {
  final nearService = Modular.get<NearBlockChainService>();

  final nftCollectionController = TextEditingController();
  final newOwnerController = TextEditingController();

  bool keep_old_minters = true;

  Future<BlockchainResponse>? responseTransfer;

  Future<BlockchainResponse> transferNFTCollection(
      {required String nftCollectionContract,
      required String new_owner,
      required bool keep_old_minters}) async {
    final infocrypto = Modular.get<AuthController>(key: "AuthController").state;

    return await nearService.transferNFTCollection(
        accountId: infocrypto.accountId,
        publicKey: infocrypto.publicKey,
        privateKey: infocrypto.privateKey,
        nftCollectionContract: nftCollectionContract,
        new_owner: new_owner,
        keep_old_minters: keep_old_minters);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Thems.boxDecoration,
      padding: Thems.padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Transfer collection',
              style: TextStyle(
                  fontSize: 17, color: Color.fromARGB(255, 245, 79, 1))),
          SizedBox(height: 10),
          SelectableText(
              "Collection name mast end on:\ntestnet - {name}.mintspace2.testnet,\nmainnet - {name}.mintbase1.near",
              style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),
          TextField(
            controller: nftCollectionController,
            decoration: const InputDecoration(
                labelText: 'Input name collection(full name contract)'),
          ),
          TextField(
            controller: newOwnerController,
            decoration:
                const InputDecoration(labelText: 'Input name new owner'),
          ),
          SizedBox(
            height: 10,
          ),
          Text("Do you want keep old minters?", style: TextStyle(fontSize: 16)),
          Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: const Color.fromARGB(255, 0, 0, 0),
              width: 2.0,
            )),
            child: DropdownButton<bool>(
                alignment: AlignmentDirectional.center,
                value: keep_old_minters,
                items: <bool>[true, false].map((bool value) {
                  return DropdownMenuItem<bool>(
                    value: value,
                    child: value == true ? Text("Yes") : Text("No"),
                  );
                }).toList(),
                onChanged: (bool? newValue) {
                  setState(() {
                    keep_old_minters = newValue!;
                  });
                }),
          ),
          FilledButton(
            onPressed: () async {
              setState(() {
                responseTransfer = transferNFTCollection(
                    nftCollectionContract: nftCollectionController.text,
                    new_owner: newOwnerController.text,
                    keep_old_minters: keep_old_minters);
              });
            },
            child: const Text('Transfer collection',
                style: TextStyle(color: Colors.white, fontSize: 15)),
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primary)),
          ),
          responseTransfer == null
              ? const Text("There were no transfers")
              : Flexible(
                  child: FutureBuilder<BlockchainResponse>(
                    future: responseTransfer,
                    builder: (BuildContext context,
                        AsyncSnapshot<BlockchainResponse> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return SelectableText('Error: ${snapshot.error}');
                      } else {
                        return const SelectableText(
                          "Collection was transferred",
                          style: TextStyle(fontSize: 16),
                        );
                      }
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
