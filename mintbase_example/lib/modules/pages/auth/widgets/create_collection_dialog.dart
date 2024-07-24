import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/modules/services/auth_controller.dart';

class CreateCollectionDialog extends StatefulWidget {
  const CreateCollectionDialog({super.key});

  @override
  State<CreateCollectionDialog> createState() => _CreateCollectionDialogState();
}

class _CreateCollectionDialogState extends State<CreateCollectionDialog> {
  final symbolController = TextEditingController();
  final nameController = TextEditingController();
  final ownerIdController = TextEditingController();
  final iconController = TextEditingController();
  final baseUriController = TextEditingController();
  final referenceController = TextEditingController();
  final referenceHashController = TextEditingController();

  final nearService = Modular.get<NearBlockChainService>();
  Future<BlockchainResponse>? responseCollection;

  Future<BlockchainResponse> deployNFTCollection(
      {required String symbol,
      required String name,
      required String ownerId,
      String? icon,
      String? baseUri,
      String? reference,
      String? referenceHash}) async {
    final AuthController infoAccount = Modular.get(key: "AuthController");
    final Map<String, dynamic> args = {
      "owner_id": ownerId,
      "metadata": {
        "name": name,
        "spec": "nft-1.0.0",
        "symbol": symbol,
        "icon": icon,
        "baseUri": baseUri,
        "reference": reference,
        "referenceHash": referenceHash
      }
    };

    return await nearService.deployNFTCollection(
        accountId: infoAccount.state.accountId,
        publicKey: infoAccount.state.publicKey,
        privateKey: infoAccount.state.privateKey,
        args: args);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
        padding: EdgeInsets.all(10),
        child: Column(children: [
          const Text(
            "Create collection",
            style: TextStyle(fontSize: 17),
          ),
          TextField(
            controller: symbolController,
            decoration: const InputDecoration(labelText: 'Input symbol'),
          ),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Input name'),
          ),
          TextField(
            controller: ownerIdController,
            decoration: const InputDecoration(labelText: 'Input owner'),
          ),
          TextField(
            controller: iconController,
            decoration:
                const InputDecoration(labelText: 'Input icon(variably)'),
          ),
          TextField(
            controller: baseUriController,
            decoration: const InputDecoration(labelText: 'Input uri(variably)'),
          ),
          TextField(
            controller: referenceController,
            decoration:
                const InputDecoration(labelText: 'Input reference(variably)'),
          ),
          TextField(
            controller: referenceHashController,
            decoration: const InputDecoration(
                labelText: 'Input reference hash(variably)'),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                responseCollection = deployNFTCollection(
                    symbol: symbolController.text,
                    name: nameController.text,
                    ownerId: ownerIdController.text,
                    icon: iconController.text,
                    baseUri: baseUriController.text,
                    reference: referenceController.text,
                    referenceHash: referenceHashController.text);
              });
            },
            child: const Text('Create collection'),
          ),
          responseCollection == true
              ? Text("Collection was create successful")
              : Text("Collection was not created"),
        ]));
  }
}
