import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/modules/pages/thems/thems.dart';
import 'package:mintbase_example/modules/services/auth_controller.dart';

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

  Future<bool>? isOffering;
  Future<double>? priceOffers;

  Future<bool> offersToRollingAuction(
      {required String nameNFTCollection,
      required int tokenId,
      required int priceBid,
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

  Future<double> checkMaxPriceBidNFT(
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
          ElevatedButton(
            onPressed: () {
              setState(() {
                isOffering = offersToRollingAuction(
                  nameNFTCollection: nftCollectionController.text,
                  tokenId: int.parse(tokenIdController.text),
                  priceBid: int.parse(priceBidController.text),
                  timeoutInHours: timeoutInHoursController.text.isNotEmpty
                      ? int.parse(timeoutInHoursController.text)
                      : null,
                );
              });
            },
            child: const Text('Rolling NFT'),
          ),
          isOffering == null
              ? const Text("No action on rolling")
              : FutureBuilder<bool>(
                  future: isOffering,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
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
          ElevatedButton(
            onPressed: () {
              setState(() {
                priceOffers = checkMaxPriceBidNFT(
                    nftContractId: nftCollectionController.text,
                    tokenId: int.parse(tokenIdController.text));
              });
            },
            child: const Text('Rolling NFT'),
          ),
          priceOffers == null
              ? const Text("No action on checking")
              : FutureBuilder<double>(
                  future: priceOffers,
                  builder:
                      (BuildContext context, AsyncSnapshot<double> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return SelectableText('Error: ${snapshot.error}');
                    } else {
                      return SelectableText(
                        "Max price bid: ${snapshot.data}",
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
