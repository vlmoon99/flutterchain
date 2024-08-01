import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/modules/models/models.dart';
import 'package:mintbase_example/modules/pages/thems/thems.dart';
import 'package:mintbase_example/modules/services/auth_controller.dart';
import 'package:image/image.dart' as img;

class Mintnft extends StatefulWidget {
  const Mintnft({super.key});

  @override
  State<Mintnft> createState() => _MintnftState();
}

class _MintnftState extends State<Mintnft> {
  final nearService = Modular.get<NearBlockChainService>();

  final nftCollectionContractController = TextEditingController();
  final ownerIDController = TextEditingController();
  final referenceHashController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final numToMintController = TextEditingController();
  final tagsController = TextEditingController();

  final pickMediaController = TextEditingController();
  final pickDocumentController = TextEditingController();

  CategoryNFT categoryNFT = CategoryNFT.art;

  final List<TextEditingController> _percentRoyaltiesControllers = [
    TextEditingController()
  ];
  final List<TextEditingController> _accountIdRoyaltiesControllers = [
    TextEditingController()
  ];

  final List<TextEditingController> _percentOwnersControllers = [
    TextEditingController()
  ];
  final List<TextEditingController> _accountIdOwnersControllers = [
    TextEditingController()
  ];

  void addNewField(
      {required List<TextEditingController> percentControllers,
      required List<TextEditingController> accountIdControllers}) {
    setState(() {
      percentControllers.add(TextEditingController());
      accountIdControllers.add(TextEditingController());
    });
  }

  Map<String, int> convertToSplit(
      {required List<TextEditingController> percentControllers,
      required List<TextEditingController> accountIdControllers,
      required bool isRoyalties}) {
    Map<String, int> data = {};
    for (int row = 0; row < percentControllers.length; row++) {
      String accountId = accountIdControllers[row].text;
      int percent = int.tryParse(percentControllers[row].text) ?? 0;
      data[accountId] = percent;
    }
    int sum = data.values.reduce((a, b) => a + b);

    if (sum > 50 && isRoyalties == true) {
      throw Exception("Royalties must be up to 50 percent");
    }
    return data;
  }

  void _removeField(
      {required int index,
      required List<TextEditingController> percentControllers,
      required List<TextEditingController> accountIdControllers}) {
    setState(() {
      percentControllers[index].dispose();
      accountIdControllers[index].dispose();
      percentControllers.removeAt(index);
      accountIdControllers.removeAt(index);
    });
  }

  Future<bool> mintNFT(
      {required String nftCollectionContract,
      required String owner_id,
      required int num_to_mint,
      required String title,
      required String media,
      required String description,
      Map<String, int>? split_between,
      Map<String, int>? split_owners,
      String? tags,
      List<dynamic>? extra,
      String? category,
      String? document}) async {
    final AuthController infoAccount = Modular.get(key: "AuthController");

    List<String>? tagsList;
    if (tags != null) {
      tagsList = tags.split(",").map((tag) => tag.trim()).toList();
    }

    final mediaNoComletie = await File(media);
    final imageBytes = await mediaNoComletie.readAsBytes();
    img.Image? originalImage = img.decodeImage(imageBytes);
    img.Image resizedImage =
        img.copyResize(originalImage!, width: 300, height: 300);
    final resizedImageBytes = img.encodePng(resizedImage);
    final mediaComletie = base64Encode(resizedImageBytes);

    return await nearService.mintNFT(
      accountId: infoAccount.state.accountId,
      publicKey: infoAccount.state.publicKey,
      privateKey: infoAccount.state.privateKey,
      nftCollectionContract: nftCollectionContract,
      owner_id: owner_id,
      title: title,
      media: mediaComletie,
      description: description,
      num_to_mint: num_to_mint,
      split_between: split_between,
      split_owners: split_owners,
      tags: tagsList,
      extra: extra,
      category: category,
      document: document,
    );
  }

  Future<String?> pickMediaFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        pickMediaController.text = result.files.single.path!;
      });
    } else {
      return null;
    }
  }

  Future<String?> pickDocumentFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        pickDocumentController.text = result.files.single.path!;
      });
    } else {
      return null;
    }
  }

  @override
  void dispose() {
    for (var percent in _percentRoyaltiesControllers) {
      percent.dispose();
    }
    for (var accountId in _accountIdRoyaltiesControllers) {
      accountId.dispose();
    }
    for (var percent in _percentOwnersControllers) {
      percent.dispose();
    }
    for (var accountId in _accountIdOwnersControllers) {
      accountId.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Thems.padding,
      decoration: Thems.boxDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Mint NFT",
            style:
                TextStyle(fontSize: 17, color: Color.fromARGB(255, 245, 79, 1)),
          ),
          TextField(
            controller: nftCollectionContractController,
            decoration: const InputDecoration(
                labelText: 'Input name collection(full name contract)**'),
          ),
          TextField(
            controller: ownerIDController,
            decoration: const InputDecoration(labelText: 'Input owner id**'),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Input description**'),
          ),
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Input title**'),
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: pickMediaFile,
                child: const Text('Pick media File**'),
              ),
              SizedBox(height: 10),
              pickMediaController.text.isNotEmpty
                  ? Text('Selected File: ${pickMediaController.text}')
                  : Text('No file selected.'),
            ],
          ),
          Column(
            children: [
              ElevatedButton(
                onPressed: pickDocumentFile,
                child: Text('Pick document File'),
              ),
              SizedBox(height: 20),
              Text(
                pickDocumentController.text.isNotEmpty
                    ? 'Selected File: ${pickDocumentController.text}'
                    : 'No file selected.',
              ),
            ],
          ),
          TextField(
            controller: numToMintController,
            decoration:
                const InputDecoration(labelText: 'Input amount to mint'),
          ),
          TextField(
            controller: tagsController,
            decoration: const InputDecoration(
                labelText: 'Input tags (through the comma)'),
          ),
          SizedBox(height: 10),
          Text("Select category"),
          Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: Color.fromARGB(255, 0, 0, 0),
              width: 2.0,
            )),
            child: DropdownButton<CategoryNFT>(
                alignment: AlignmentDirectional.center,
                value: categoryNFT,
                items: CategoryNFT.values.map((CategoryNFT value) {
                  return DropdownMenuItem<CategoryNFT>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
                onChanged: (CategoryNFT? newvalue) {
                  setState(() {
                    categoryNFT = newvalue!;
                  });
                }),
          ),
          SizedBox(height: 13),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Color.fromARGB(255, 50, 240, 208),
                  width: 2.0,
                )),
            padding: Thems.padding,
            child: Column(
              children: [
                Text(
                  "Input Forever Royalties",
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  "Maximum Forever Royalties is 50%",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: _percentRoyaltiesControllers.length * 60,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _percentRoyaltiesControllers.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Flexible(
                              child: TextField(
                                controller: _percentRoyaltiesControllers[index],
                                decoration: const InputDecoration(
                                    labelText: 'Input percent %'),
                              ),
                            ),
                            SizedBox(width: 10),
                            Flexible(
                              child: TextField(
                                controller:
                                    _accountIdRoyaltiesControllers[index],
                                decoration: const InputDecoration(
                                    labelText: 'Input account ID'),
                              ),
                            ),
                            IconButton(
                                onPressed: () => _removeField(
                                    index: index,
                                    percentControllers:
                                        _percentRoyaltiesControllers,
                                    accountIdControllers:
                                        _accountIdRoyaltiesControllers),
                                icon: Icon(Icons.remove))
                          ],
                        );
                      }),
                ),
                IconButton(
                    onPressed: () => addNewField(
                        percentControllers: _percentRoyaltiesControllers,
                        accountIdControllers: _accountIdRoyaltiesControllers),
                    icon: Icon(Icons.add)),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Color.fromARGB(255, 240, 50, 183),
                  width: 2.0,
                )),
            padding: Thems.padding,
            child: Column(
              children: [
                Text(
                  "Input Split Revenue",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: _percentOwnersControllers.length * 60,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _percentOwnersControllers.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Flexible(
                              child: TextField(
                                controller: _percentOwnersControllers[index],
                                decoration: const InputDecoration(
                                    labelText: 'Input percent %'),
                              ),
                            ),
                            SizedBox(width: 10),
                            Flexible(
                              child: TextField(
                                controller: _accountIdOwnersControllers[index],
                                decoration: const InputDecoration(
                                    labelText: 'Input account ID'),
                              ),
                            ),
                            IconButton(
                                onPressed: () => _removeField(
                                    index: index,
                                    percentControllers:
                                        _percentOwnersControllers,
                                    accountIdControllers:
                                        _accountIdOwnersControllers),
                                icon: Icon(Icons.remove))
                          ],
                        );
                      }),
                ),
                IconButton(
                    onPressed: () => addNewField(
                        percentControllers: _percentOwnersControllers,
                        accountIdControllers: _accountIdOwnersControllers),
                    icon: Icon(Icons.add)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              if (_percentRoyaltiesControllers.first.text.isNotEmpty) {
                final royalties = convertToSplit(
                    percentControllers: _percentOwnersControllers,
                    accountIdControllers: _accountIdOwnersControllers,
                    isRoyalties: false);
              }
              await mintNFT(
                  nftCollectionContract: nftCollectionContractController.text,
                  owner_id: ownerIDController.text,
                  num_to_mint: int.tryParse(numToMintController.text) ?? 1,
                  title: titleController.text,
                  media: pickMediaController.text,
                  description: descriptionController.text);
            },
            child: const Text('Mint NFT'),
          ),
        ],
      ),
    );
  }
}
