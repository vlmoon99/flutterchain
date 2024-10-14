import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/thems/thems.dart';
import 'package:mintbase_example/modules/controllers/auth_controller.dart';

class RollingAuctionNft extends StatefulWidget {
  const RollingAuctionNft({super.key});

  @override
  State<RollingAuctionNft> createState() => _RollingAuctionNftState();
}

class _RollingAuctionNftState extends State<RollingAuctionNft> {
  final nearService = Modular.get<NearBlockChainService>();

  final nftCollectionController = TextEditingController();
  final tokenIdController = TextEditingController();
  final priceController = TextEditingController();

  Future<BlockchainResponse>? isRolling;

  Future<BlockchainResponse> rollingAuctionNft(
      {required String nameNFTCollection,
      required int tokenId,
      required String price}) async {
    final infocrypto = Modular.get<AuthController>(key: "AuthController").state;
    return await nearService.rollingAuctionNft(
        accountId: infocrypto.accountId,
        publicKey: infocrypto.publicKey,
        nameNFTCollection: nameNFTCollection,
        privateKey: infocrypto.privateKey,
        tokenId: tokenId,
        price: price);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Thems.boxDecoration,
      padding: Thems.padding,
      child: Column(
        children: [
          const Text('Rolling auction NFT',
              style: TextStyle(
                  fontSize: 17, color: Color.fromARGB(255, 245, 79, 1))),
          TextField(
            controller: nftCollectionController,
            decoration: const InputDecoration(
                labelText: 'Input name collection(full name contract)'),
          ),
          TextField(
            controller: tokenIdController,
            decoration: const InputDecoration(labelText: 'Input token id'),
          ),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(labelText: 'Minimum bid(Near)'),
          ),
          SizedBox(height: 10),
          FilledButton(
            onPressed: () {
              setState(() {
                isRolling = rollingAuctionNft(
                    nameNFTCollection: nftCollectionController.text,
                    tokenId: int.parse(tokenIdController.text),
                    price: priceController.text);
              });
            },
            child: const Text('Rolling NFT',
                style: TextStyle(color: Colors.white, fontSize: 15)),
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primary)),
          ),
          isRolling == null
              ? const Text("No action on rolling")
              : FutureBuilder<BlockchainResponse>(
                  future: isRolling,
                  builder: (BuildContext context,
                      AsyncSnapshot<BlockchainResponse> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return SelectableText('Error: ${snapshot.error}');
                    } else {
                      return const SelectableText(
                        "NFT was rolling successful",
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
