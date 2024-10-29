import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/thems/thems.dart';
import 'package:mintbase_example/modules/controllers/auth_controller.dart';

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

  Future<BlockchainResponse>? isBuy;
  Future<String>? price;

  Future<BlockchainResponse> buySimpleListNft(
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

  Future<String> checkPrice(
      {required String nftContractId, required int tokenId}) async {
    String priceNotFormat = await nearService.getPriceForBuySimpleListNFT(
        nftContractId: nftContractId, tokenId: tokenId);
    return priceNotFormat;
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
          const SizedBox(height: 10),
          FilledButton(
            onPressed: () async {
              setState(() {
                isBuy = buySimpleListNft(
                    nameNFTCollection: nftCollectionController.text,
                    tokenId: int.parse(tokenIdController.text),
                    referrer_id: referrerIdController.text);
              });
            },
            child: const Text('Buy NFT',
                style: TextStyle(color: Colors.white, fontSize: 15)),
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primary)),
          ),
          isBuy == null
              ? const Text("There were no interactions")
              : FutureBuilder<BlockchainResponse>(
                  future: isBuy,
                  builder: (BuildContext context,
                      AsyncSnapshot<BlockchainResponse> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return SelectableText('Error: ${snapshot.error}');
                    } else {
                      return const SelectableText(
                        "The NFT has been bought",
                        style: TextStyle(fontSize: 16),
                      );
                    }
                  },
                ),
          const SizedBox(height: 10),
          const Text(
            "You can check price nft",
            style: TextStyle(fontSize: 16),
          ),
          FilledButton(
            onPressed: () async {
              setState(() {
                price = checkPrice(
                    nftContractId: nftCollectionController.text,
                    tokenId: int.parse(tokenIdController.text));
              });
            },
            child: const Text('Check price',
                style: TextStyle(color: Colors.white, fontSize: 15)),
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primary)),
          ),
          price == null
              ? const Text("There were no interactions")
              : FutureBuilder<String>(
                  future: price,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return SelectableText('Error: ${snapshot.error}');
                    } else {
                      return SelectableText(
                        "Price: ${snapshot.data}",
                        style: const TextStyle(fontSize: 16),
                      );
                    }
                  },
                ),
        ],
      ),
    );
  }
}
