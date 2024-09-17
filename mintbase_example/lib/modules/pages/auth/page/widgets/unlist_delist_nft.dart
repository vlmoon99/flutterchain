import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/thems/thems.dart';
import 'package:mintbase_example/modules/controllers/auth_controller.dart';

class UnlistDelistNFT extends StatefulWidget {
  const UnlistDelistNFT({super.key});

  @override
  State<UnlistDelistNFT> createState() => _UnlistDelistNFTState();
}

class _UnlistDelistNFTState extends State<UnlistDelistNFT> {
  final nearService = Modular.get<NearBlockChainService>();

  final nftCollectionController = TextEditingController();
  final tokenIdController = TextEditingController();

  Future<bool>? response;

  String? output;

  Future<bool> unlistNFT(
      {required String nameNFTCollection, required int tokenId}) async {
    final infocrypto = Modular.get<AuthController>(key: "AuthController").state;

    return await nearService.unlistNFT(
        accountId: infocrypto.accountId,
        publicKey: infocrypto.publicKey,
        nameNFTCollection: nameNFTCollection,
        privateKey: infocrypto.privateKey,
        tokenId: tokenId);
  }

  Future<bool> delistNFT(
      {required String nameNFTCollection, required int tokenId}) async {
    final infocrypto = Modular.get<AuthController>(key: "AuthController").state;

    return await nearService.delistNFT(
        accountId: infocrypto.accountId,
        publicKey: infocrypto.publicKey,
        nameNFTCollection: nameNFTCollection,
        privateKey: infocrypto.privateKey,
        tokenId: tokenId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Thems.boxDecoration,
      padding: Thems.padding,
      child: Column(
        children: [
          const Text('Unlist simple sale and delist NFT',
              style: TextStyle(
                  fontSize: 17, color: Color.fromARGB(255, 245, 79, 1))),
          SizedBox(height: 7),
          const Text('Unlist - for simple sale\nDelist - for rolling',
              style: TextStyle(fontSize: 16)),
          TextField(
            controller: nftCollectionController,
            decoration: const InputDecoration(
                labelText: 'Input name collection(full name contract)'),
          ),
          TextField(
            controller: tokenIdController,
            decoration: const InputDecoration(labelText: 'Input token id NFT'),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () async {
                  setState(() {
                    response = unlistNFT(
                        nameNFTCollection: nftCollectionController.text,
                        tokenId: int.parse(tokenIdController.text));
                    output = "unlist";
                  });
                },
                child: const Text('Unlist NFT',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.primary)),
              ),
              SizedBox(width: 45),
              FilledButton(
                onPressed: () async {
                  setState(() {
                    response = delistNFT(
                        nameNFTCollection: nftCollectionController.text,
                        tokenId: int.parse(tokenIdController.text));
                    output = "delist";
                  });
                },
                child: const Text('Delist NFT',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.primary)),
              ),
            ],
          ),
          response == null
              ? const Text("There were no interactions")
              : FutureBuilder<bool>(
                  future: response,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return SelectableText('Error: ${snapshot.error}');
                    } else {
                      if (output == "unlist") {
                        return const SelectableText(
                          "NFT was unlisted",
                          style: TextStyle(fontSize: 16),
                        );
                      } else if (output == "delist") {
                        return const SelectableText(
                          "NFT was delisted",
                          style: TextStyle(fontSize: 16),
                        );
                      } else {
                        return const SelectableText(
                          "Error",
                          style: TextStyle(fontSize: 16),
                        );
                      }
                    }
                  },
                ),
        ],
      ),
    );
  }
}
