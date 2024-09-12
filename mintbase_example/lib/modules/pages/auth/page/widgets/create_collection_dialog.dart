import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/thems/thems.dart';
import 'package:mintbase_example/modules/controllers/auth_controller.dart';

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
    final infoAccount =
        Modular.get<AuthController>(key: "AuthController").state;
    String? iconConvert;
    if (icon != null && icon.length > 0) {
      File iconFile = File(icon);
      List<int> imageBytes = await iconFile.readAsBytes();
      iconConvert = base64Encode(imageBytes);
      iconConvert = "data:image/png;base64,${iconConvert}";
    }

    return await nearService.deployNFTCollection(
        accountId: infoAccount.accountId,
        publicKey: infoAccount.publicKey,
        privateKey: infoAccount.privateKey,
        symbol: symbol,
        name: name,
        ownerId: ownerId,
        icon: iconConvert,
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
          const Text(
            "On your account must be more then 3.7 Near. And name collection characters must be in lower case.",
            style: TextStyle(fontSize: 16),
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
            decoration: const InputDecoration(
                labelText: 'Input uri(variably, arweave default)'),
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
          FilledButton(
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
            child: const Text('Create collection',
                style: TextStyle(color: Colors.white, fontSize: 15)),
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primary)),
          ),
          responseCollection == null
              ? const Text("There were no interactions")
              : FutureBuilder<bool>(
                  future: responseCollection,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return SelectableText('Error: ${snapshot.error}');
                    } else {
                      return const SelectableText(
                        "Your collection was created",
                        style: TextStyle(fontSize: 16),
                      );
                    }
                  },
                ),
        ]));
  }
}
