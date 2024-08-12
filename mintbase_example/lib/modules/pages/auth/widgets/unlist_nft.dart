import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/modules/pages/thems/thems.dart';
import 'package:mintbase_example/modules/services/auth_controller.dart';

class UnlistNft extends StatefulWidget {
  const UnlistNft({super.key});

  @override
  State<UnlistNft> createState() => _UnlistNftState();
}

class _UnlistNftState extends State<UnlistNft> {
  final nearService = Modular.get<NearBlockChainService>();

  final nftCollectionController = TextEditingController();
  final tokenIdController = TextEditingController();

  Future<bool>? isUnlistNFT;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Thems.boxDecoration,
      padding: Thems.padding,
      child: Column(
        children: [
          const Text('Unlist NFT',
              style: TextStyle(
                  fontSize: 17, color: Color.fromARGB(255, 245, 79, 1))),
          TextField(
            controller: nftCollectionController,
            decoration: const InputDecoration(
                labelText: 'Input name collection(full name contract)'),
          ),
          TextField(
            controller: tokenIdController,
            decoration: const InputDecoration(labelText: 'Input token id NFT'),
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                isUnlistNFT = unlistNFT(
                    nameNFTCollection: nftCollectionController.text,
                    tokenId: int.parse(tokenIdController.text));
              });
            },
            child: const Text('Unlist NFT'),
          ),
          isUnlistNFT == null
              ? const Text("There were no interactions")
              : FutureBuilder<bool>(
                  future: isUnlistNFT,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return SelectableText('Error: ${snapshot.error}');
                    } else {
                      final data = snapshot.data!;
                      return const SelectableText(
                        "NFT was unlisted",
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
