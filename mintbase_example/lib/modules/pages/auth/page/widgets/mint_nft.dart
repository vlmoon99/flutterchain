import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/mintbase_category_nft.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/thems/thems.dart';
import 'package:mintbase_example/modules/controllers/auth_controller.dart';

class Mintnft extends StatefulWidget {
  const Mintnft({super.key});

  @override
  State<Mintnft> createState() => _MintnftState();
}

class _MintnftState extends State<Mintnft> {
  final nearService = Modular.get<NearBlockChainService>();

  Future<bool>? isMint;

  final nftCollectionContractController = TextEditingController();
  final ownerIDController = TextEditingController();
  final referenceHashController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final numToMintController = TextEditingController();
  final tagsController = TextEditingController();

  final pickMediaController = TextEditingController();
  final pickDocumentController = TextEditingController();
  final pickAnimationController = TextEditingController();

  CategoryNFT? categoryNFT;

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

  final List<TextEditingController> _customNameControllers = [
    TextEditingController()
  ];
  final List<TextEditingController> _customValueControllers = [
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

  List<dynamic> convertExtra(
      {required List<TextEditingController> namecontrollers,
      required List<TextEditingController> valueControllers}) {
    List<dynamic> extra = [];

    for (var i = 0; i < namecontrollers.length; i++) {
      extra.add({
        "trait_type": namecontrollers[i].text,
        "display_type": namecontrollers[i].text,
        "value": valueControllers[i].text
      });
    }

    return extra;
  }

  Future<bool> mintNFT(
      {required String nftCollectionContract,
      required String owner_id,
      required int num_to_mint,
      required String title,
      required String mediaPath,
      required String description,
      Map<String, int>? split_between,
      Map<String, int>? split_owners,
      String? tags,
      List<dynamic>? extra,
      CategoryNFT? category,
      String? documentPath,
      String? animationPath}) async {
    final infoAccount =
        Modular.get<AuthController>(key: "AuthController").state;
    List<String>? tagsList;
    if (tags != null) {
      tagsList = tags.split(",").map((tag) => tag.trim()).toList();
    }

    return await nearService.mintNFT(
      accountId: infoAccount.accountId,
      publicKey: infoAccount.publicKey,
      privateKey: infoAccount.privateKey,
      nftCollectionContract: nftCollectionContract,
      owner_id: owner_id,
      title: title,
      media: mediaPath,
      animation: animationPath,
      description: description,
      num_to_mint: num_to_mint,
      split_between: split_between,
      split_owners: split_owners,
      tags: tagsList,
      extra: extra,
      category: category,
      document: documentPath,
    );
  }

  Future<String?> pickFile({required TextEditingController controller}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        controller.text = result.files.single.path!;
      });
    } else {
      return null;
    }
  }

  @override
  void initState() {
    numToMintController.text = "1";
    super.initState();
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
    for (var name in _customNameControllers) {
      name.dispose();
    }
    for (var value in _customValueControllers) {
      value.dispose();
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
          SizedBox(height: 10),
          Column(
            children: [
              FilledButton(
                onPressed: () => pickFile(controller: pickMediaController),
                child: const Text('Pick media File**',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.primary)),
              ),
              pickMediaController.text.isNotEmpty
                  ? Text(
                      'Selected File: ${pickMediaController.text.split("/").toList().last}')
                  : Text('No file selected.'),
            ],
          ),
          SizedBox(height: 10),
          Column(
            children: [
              FilledButton(
                onPressed: () => pickFile(controller: pickAnimationController),
                child: const Text('Pick animation File',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.primary)),
              ),
              Text(
                pickAnimationController.text.isNotEmpty
                    ? 'Selected File: ${pickAnimationController.text.split("/").toList().last}'
                    : 'No file selected.',
              ),
            ],
          ),
          SizedBox(height: 10),
          Column(
            children: [
              FilledButton(
                onPressed: () => pickFile(controller: pickDocumentController),
                child: Text('Pick document File',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.primary)),
              ),
              Text(
                pickDocumentController.text.isNotEmpty
                    ? 'Selected File: ${pickDocumentController.text.split("/").toList().last}'
                    : 'No file selected.',
              ),
            ],
          ),
          SizedBox(height: 10),
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
                hint: const Text("Choose category"),
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
                const Text(
                  "Input Forever Royalties",
                  style: TextStyle(fontSize: 16),
                ),
                const Text(
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
                const Text(
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
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Color.fromARGB(255, 240, 158, 50),
                  width: 2.0,
                )),
            padding: Thems.padding,
            child: Column(
              children: [
                const Text(
                  "Input Custom parameters",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: _customNameControllers.length * 60,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _customNameControllers.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Flexible(
                              child: TextField(
                                controller: _customNameControllers[index],
                                decoration: const InputDecoration(
                                    labelText: 'Input name'),
                              ),
                            ),
                            SizedBox(width: 10),
                            Flexible(
                              child: TextField(
                                controller: _customValueControllers[index],
                                decoration: const InputDecoration(
                                    labelText: 'Input value'),
                              ),
                            ),
                            IconButton(
                                onPressed: () => _removeField(
                                    index: index,
                                    percentControllers: _customNameControllers,
                                    accountIdControllers:
                                        _customValueControllers),
                                icon: Icon(Icons.remove))
                          ],
                        );
                      }),
                ),
                IconButton(
                    onPressed: () => addNewField(
                        percentControllers: _customNameControllers,
                        accountIdControllers: _customValueControllers),
                    icon: Icon(Icons.add)),
              ],
            ),
          ),
          SizedBox(height: 10),
          FilledButton(
            onPressed: () {
              Map<String, int>? split_owners;
              Map<String, int>? split_between;
              List<dynamic>? extra;
              if (_customNameControllers.first.text.isNotEmpty) {
                extra = convertExtra(
                    namecontrollers: _customNameControllers,
                    valueControllers: _customValueControllers);
              }
              if (_percentOwnersControllers.first.text.isNotEmpty) {
                split_owners = convertToSplit(
                    percentControllers: _percentOwnersControllers,
                    accountIdControllers: _accountIdOwnersControllers,
                    isRoyalties: false);
              }
              if (_percentRoyaltiesControllers.first.text.isNotEmpty) {
                split_between = convertToSplit(
                    percentControllers: _percentRoyaltiesControllers,
                    accountIdControllers: _accountIdRoyaltiesControllers,
                    isRoyalties: true);
              }
              setState(() {
                isMint = mintNFT(
                    nftCollectionContract: nftCollectionContractController.text,
                    owner_id: ownerIDController.text,
                    num_to_mint: int.tryParse(numToMintController.text) ?? 1,
                    title: titleController.text,
                    mediaPath: pickMediaController.text,
                    description: descriptionController.text,
                    split_between: split_between,
                    split_owners: split_owners,
                    tags: tagsController.text,
                    category: categoryNFT,
                    documentPath: pickDocumentController.text,
                    animationPath: pickAnimationController.text,
                    extra: extra);
              });
            },
            child: const Text('Mint NFT',
                style: TextStyle(color: Colors.white, fontSize: 15)),
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primary)),
          ),
          isMint == null
              ? const Text("No action on minting")
              : FutureBuilder<bool>(
                  future: isMint,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return SelectableText('Error: ${snapshot.error}');
                    } else {
                      return const SelectableText(
                        "NFT was minting successful",
                        style: TextStyle(fontSize: 16),
                      );
                    }
                  },
                )
        ],
      ),
    );
  }
}
