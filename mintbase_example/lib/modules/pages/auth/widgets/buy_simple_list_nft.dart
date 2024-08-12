import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/modules/pages/thems/thems.dart';
import 'package:mintbase_example/modules/services/auth_controller.dart';

class BuySimpleListNft extends StatefulWidget {
  const BuySimpleListNft({super.key});

  @override
  State<BuySimpleListNft> createState() => _BuySimpleListNftState();
}

class _BuySimpleListNftState extends State<BuySimpleListNft> {
  final nearService = Modular.get<NearBlockChainService>();

  final nftCollectionController = TextEditingController();
  final tokenIdController = TextEditingController();
  final referrerIdController = TextEditingController();

  Future<bool>? isBuy;

  Future<bool> buySimpleListNft(
      {required String nameNFTCollection,
      required int tokenId,
      String? referrer_id}) async {
    final infocrypto = Modular.get<AuthController>(key: "AuthController").state;

    return await nearService.buySimpleListNFT(
        accountId: infocrypto.accountId,
        publicKey: infocrypto.publicKey,
        nameNFTCollection: nameNFTCollection,
        privateKey: infocrypto.privateKey,
        tokenId: tokenId,
        referrer_id: referrer_id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Thems.boxDecoration,
      padding: Thems.padding,
      child: Column(
        children: [
          const Text('Buy simple list NFT',
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
          TextField(
            controller: referrerIdController,
            decoration:
                const InputDecoration(labelText: 'Input referrer id(optional)'),
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                isBuy = buySimpleListNft(
                    nameNFTCollection: nftCollectionController.text,
                    tokenId: int.parse(tokenIdController.text),
                    referrer_id: referrerIdController.text);
              });
            },
            child: const Text('Buy NFT'),
          ),
          isBuy == null
              ? const Text("There were no interactions")
              : FutureBuilder<bool>(
                  future: isBuy,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return SelectableText('Error: ${snapshot.error}');
                    } else {
                      final data = snapshot.data!;
                      return const SelectableText(
                        "The NFT has been bought",
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
