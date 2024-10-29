import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/thems/thems.dart';
import 'package:mintbase_example/modules/controllers/auth_controller.dart';

class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  final nearService = Modular.get<NearBlockChainService>();

  final nftCollectionController = TextEditingController();
  final tokenIdController = TextEditingController();
  final priceBidController = TextEditingController();
  final timeoutInHoursController = TextEditingController();

  Future<BlockchainResponse>? isOffering;
  Future<Map<String, String>>? pricesOffers;

  Future<BlockchainResponse> offersToRollingAuction(
      {required String nameNFTCollection,
      required int tokenId,
      required String priceBid,
      required int? timeoutInHours}) async {
    final infocrypto = Modular.get<AuthController>(key: "AuthController").state;

    return await nearService.offersToRollingAuction(
        accountId: infocrypto.accountId,
        publicKey: infocrypto.publicKey,
        nameNFTCollection: nameNFTCollection,
        privateKey: infocrypto.privateKey,
        tokenId: tokenId,
        priceBid: priceBid,
        timeoutInHours: timeoutInHours);
  }

  Future<Map<String, String>> checkMaxPriceBidNFT(
      {required String nftContractId, required int tokenId}) async {
    return await nearService.checkMaxPriceBidNFT(
        nftContractId: nftContractId, tokenId: tokenId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Thems.boxDecoration,
      padding: Thems.padding,
      child: Column(
        children: [
          const Text('Offers to rolling auction NFT',
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
            controller: priceBidController,
            decoration: const InputDecoration(labelText: 'Price bid(Near)'),
          ),
          TextField(
            controller: timeoutInHoursController,
            decoration:
                const InputDecoration(labelText: 'Time out(hour, option)'),
          ),
          SizedBox(height: 10),
          FilledButton(
            onPressed: () {
              setState(() {
                isOffering = offersToRollingAuction(
                  nameNFTCollection: nftCollectionController.text,
                  tokenId: int.parse(tokenIdController.text),
                  priceBid: priceBidController.text,
                  timeoutInHours: timeoutInHoursController.text.isNotEmpty
                      ? int.parse(timeoutInHoursController.text)
                      : null,
                );
              });
            },
            child: const Text('Make offer NFT',
                style: TextStyle(color: Colors.white, fontSize: 15)),
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primary)),
          ),
          isOffering == null
              ? const Text("No action on rolling")
              : FutureBuilder<BlockchainResponse>(
                  future: isOffering,
                  builder: (BuildContext context,
                      AsyncSnapshot<BlockchainResponse> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return SelectableText('Error: ${snapshot.error}');
                    } else {
                      return const SelectableText(
                        "Offer was create successful",
                        style: TextStyle(fontSize: 16),
                      );
                    }
                  },
                ),
          SizedBox(height: 10),
          Text("Beffor starting you can check max price bid"),
          FilledButton(
            onPressed: () {
              setState(() {
                pricesOffers = checkMaxPriceBidNFT(
                    nftContractId: nftCollectionController.text,
                    tokenId: int.parse(tokenIdController.text));
              });
            },
            child: const Text('Check price NFT',
                style: TextStyle(color: Colors.white, fontSize: 15)),
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primary)),
          ),
          pricesOffers == null
              ? const Text("No action on checking")
              : FutureBuilder<Map<String, String>>(
                  future: pricesOffers,
                  builder: (BuildContext context,
                      AsyncSnapshot<Map<String, String>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return SelectableText('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      String maxBid = snapshot.data!["maxbid"]!;
                      String minBid = snapshot.data!["minbid"]!;
                      return Text('Max bid: $maxBid\n Min bid: $minBid',
                          style: TextStyle(fontSize: 16));
                    } else {
                      return const Text(
                        'This not exist offer',
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
