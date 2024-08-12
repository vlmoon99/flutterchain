import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/modules/pages/thems/thems.dart';
import 'package:mintbase_example/modules/services/auth_controller.dart';

class SimpleSale extends StatefulWidget {
  const SimpleSale({super.key});

  @override
  State<SimpleSale> createState() => _SimpleSaleState();
}

class _SimpleSaleState extends State<SimpleSale> {
  final nftCollectionContractController = TextEditingController();
  final tokenIDController = TextEditingController();
  final priceController = TextEditingController();
  final nearService = Modular.get<NearBlockChainService>();

  Future<bool>? isList;

  Future<bool> simpleSaleNFT(
      {required String nameNFTCollection,
      required String tokenId,
      required String price}) async {
    final infocrypto = Modular.get<AuthController>(key: "AuthController").state;
    return await nearService.simpleListNFT(
        nameNFTCollection: nameNFTCollection,
        tokenId: tokenId,
        price: price,
        accountId: infocrypto.accountId,
        publicKey: infocrypto.publicKey,
        privateKey: infocrypto.privateKey);
  }

  @override
  void initState() {
    priceController.text = "1";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Thems.boxDecoration,
      padding: Thems.padding,
      child: Column(
        children: [
          const Text(
            "Simple sale NFT",
            style:
                TextStyle(fontSize: 17, color: Color.fromARGB(255, 245, 79, 1)),
          ),
          const Text(
            "Price in Near",
            style: TextStyle(fontSize: 16),
          ),
          TextField(
            controller: nftCollectionContractController,
            decoration: const InputDecoration(
                labelText: 'Input name collection(full name contract)'),
          ),
          TextField(
            controller: tokenIDController,
            decoration: const InputDecoration(labelText: 'Input token id'),
          ),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(labelText: 'Input price'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isList = simpleSaleNFT(
                    nameNFTCollection: nftCollectionContractController.text,
                    tokenId: tokenIDController.text,
                    price: priceController.text);
              });
            },
            child: const Text('List NFT'),
          ),
          isList == null
              ? const Text("No action on listing")
              : FutureBuilder<bool>(
                  future: isList,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return SelectableText('Error: ${snapshot.error}');
                    } else {
                      return const SelectableText(
                        "NFT was listing successful",
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
