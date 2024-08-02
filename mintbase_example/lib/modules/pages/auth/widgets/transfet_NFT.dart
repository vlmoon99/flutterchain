import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/modules/pages/thems/thems.dart';
import 'package:mintbase_example/modules/services/auth_controller.dart';

class TransfetNft extends StatefulWidget {
  const TransfetNft({super.key});

  @override
  State<TransfetNft> createState() => _TransfetNftState();
}

class _TransfetNftState extends State<TransfetNft> {
  final nearService = Modular.get<NearBlockChainService>();

  final accountIdCollectionController = TextEditingController();

  final List<TextEditingController> _idNFTControllers = [
    TextEditingController()
  ];
  final List<TextEditingController> _accountIdControllers = [
    TextEditingController()
  ];

  Future<bool>? isAdd;

  List<List<String>> convertToTokenIds(
      {required List<TextEditingController> idNFTControllers,
      required List<TextEditingController> accountIdControllers}) {
    List<List<String>> finalTokenIds = [];
    for (int row = 0; row < idNFTControllers.length; row++) {
      List<String> oneTranfer = [];
      oneTranfer.add(idNFTControllers[row].text);
      oneTranfer.add(accountIdControllers[row].text);
      finalTokenIds.add(oneTranfer);
    }
    return finalTokenIds;
  }

  Future<bool> transferNFT(
      {required String nftCollectionContract,
      required List<List<String>> tokenIds}) async {
    final infocrypto = Modular.get<AuthController>(key: "AuthController").state;

    return await nearService.transferNFT(
        accountId: infocrypto.accountId,
        publicKey: infocrypto.publicKey,
        privateKey: infocrypto.privateKey,
        nftCollectionContract: nftCollectionContract,
        tokenIds: tokenIds);
  }

  void addNewField(
      {required List<TextEditingController> idNFTControllers,
      required List<TextEditingController> accountIdControllers}) {
    setState(() {
      idNFTControllers.add(TextEditingController());
      accountIdControllers.add(TextEditingController());
    });
  }

  void _removeField(
      {required int index,
      required List<TextEditingController> idNFTControllers,
      required List<TextEditingController> accountIdControllers}) {
    setState(() {
      idNFTControllers[index].dispose();
      accountIdControllers[index].dispose();
      idNFTControllers.removeAt(index);
      accountIdControllers.removeAt(index);
    });
  }

  @override
  void dispose() {
    for (var idNFT in _idNFTControllers) {
      idNFT.dispose();
    }
    for (var accountId in _accountIdControllers) {
      accountId.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Thems.boxDecoration,
      padding: Thems.padding,
      child: Column(
        children: [
          const Text('Transfer NFT',
              style: TextStyle(
                  fontSize: 17, color: Color.fromARGB(255, 245, 79, 1))),
          SizedBox(height: 10),
          TextField(
            controller: accountIdCollectionController,
            decoration: const InputDecoration(
                labelText: 'Input collection name (full name contract)'),
          ),
          SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Color.fromRGBO(85, 50, 240, 1),
                  width: 2.0,
                )),
            padding: Thems.padding,
            child: Column(
              children: [
                const Text(
                  "Input transfer instruction",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: _idNFTControllers.length * 60,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _idNFTControllers.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Flexible(
                              child: TextField(
                                controller: _idNFTControllers[index],
                                decoration: const InputDecoration(
                                    labelText: 'Input NFT ID'),
                              ),
                            ),
                            SizedBox(width: 10),
                            Flexible(
                              child: TextField(
                                controller: _accountIdControllers[index],
                                decoration: const InputDecoration(
                                    labelText: 'Input account ID'),
                              ),
                            ),
                            IconButton(
                                onPressed: () => _removeField(
                                    index: index,
                                    idNFTControllers: _idNFTControllers,
                                    accountIdControllers:
                                        _accountIdControllers),
                                icon: Icon(Icons.remove))
                          ],
                        );
                      }),
                ),
                IconButton(
                    onPressed: () => addNewField(
                        idNFTControllers: _idNFTControllers,
                        accountIdControllers: _accountIdControllers),
                    icon: Icon(Icons.add)),
              ],
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                final tokenIds = convertToTokenIds(
                    idNFTControllers: _idNFTControllers,
                    accountIdControllers: _accountIdControllers);
                setState(() {
                  isAdd = transferNFT(
                      nftCollectionContract: accountIdCollectionController.text,
                      tokenIds: tokenIds);
                });
              },
              child: const Text("Transfer NFT")),
          isAdd == null
              ? const Text("No action on transfer")
              : FutureBuilder<bool>(
                  future: isAdd,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return SelectableText('Error: ${snapshot.error}');
                    } else {
                      return const Text(
                        "NFT was transferred",
                        style: TextStyle(fontSize: 16),
                      );
                    }
                  },
                ),
        ],
      ),
    );
  }
}
