import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/modules/pages/thems/thems.dart';
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
  Future<bool>? responseCollection;

  Future<bool> deployNFTCollection(
      {required String symbol,
      required String name,
      required String ownerId,
      String? icon,
      String? baseUri,
      String? reference,
      String? referenceHash}) async {
    final AuthController infoAccount = Modular.get(key: "AuthController");

    return await nearService.deployNFTCollection(
        accountId: infoAccount.state.accountId,
        publicKey: infoAccount.state.publicKey,
        privateKey: infoAccount.state.privateKey,
        symbol: symbol,
        name: name,
        ownerId: ownerId,
        icon: icon,
        baseUri: baseUri,
        reference: reference,
        referenceHash: referenceHash);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: Thems.boxDecoration,
        padding: Thems.padding,
        child: Column(children: [
          const Text(
            "Create collection",
            style:
                TextStyle(fontSize: 17, color: Color.fromARGB(255, 245, 79, 1)),
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
