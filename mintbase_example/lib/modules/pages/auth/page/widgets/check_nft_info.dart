import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/thems/thems.dart';
import 'package:mintbase_example/modules/controllers/auth_controller.dart';

class CheckInfo extends StatefulWidget {
  const CheckInfo({super.key});

  @override
  State<CheckInfo> createState() => _CheckInfoState();
}

class _CheckInfoState extends State<CheckInfo> {
  final nearService = Modular.get<NearBlockChainService>();

  Future<List<dynamic>>? listInfo;
  Future<List<dynamic>>? listingNFTInfo;

  Future<List<dynamic>> checkNFTInfo() async {
    final infoAccount =
        Modular.get<AuthController>(key: "AuthController").state;

    return await nearService.checkNFTInfo(owner_id: infoAccount.accountId);
  }

  Future<List<dynamic>> checkListingNFT() async {
    final infoAccount =
        Modular.get<AuthController>(key: "AuthController").state;

    return await nearService.checkListingNFT(ownerId: infoAccount.accountId);
  }

  @override
  void initState() {
    listInfo = checkNFTInfo();
    listingNFTInfo = checkListingNFT();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Thems.boxDecoration,
      padding: Thems.padding,
      child: Column(
        children: [
          Text(
            "Check Info",
            style:
                TextStyle(fontSize: 17, color: Color.fromARGB(255, 245, 79, 1)),
          ),
          listInfo == null
              ? const Text("Data not found")
              : FutureBuilder<List<dynamic>>(
                  future: listInfo,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text(
                        'Error: ${snapshot.error}',
                        overflow: TextOverflow.ellipsis,
                      );
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return Column(
                        children: [
                          const Text(
                            'Your owner NFT:',
                            style: TextStyle(fontSize: 16),
                          ),
                          ...snapshot.data!.map((nftInfo) {
                            String burnedInfo;
                            print(nftInfo);
                            if (nftInfo["burned_timestamp"] == null) {
                              burnedInfo = "This is active nft";
                            } else {
                              burnedInfo =
                                  "This is inactive nft: time burned - ${nftInfo["burned_timestamp"]}";
                            }
                            return SelectableText(
                              'NFT ${nftInfo["title"]}: in ${nftInfo["nft_contract_id"]} collection whit NFT ID - ${nftInfo["token_id"]}. $burnedInfo',
                              maxLines: null,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 16),
                            );
                          }).toList(),
                        ],
                      );
                    } else {
                      return const Text('You do not have nft');
                    }
                  },
                ),
          FilledButton(
              onPressed: () {
                setState(() {
                  listInfo = checkNFTInfo();
                });
              },
              child: const Text('Check info owner',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                      Theme.of(context).colorScheme.primary))),
          SizedBox(height: 10),
          Text("Listing NFT:"),
          listingNFTInfo == null
              ? const Text("Data not found")
              : FutureBuilder<List<dynamic>>(
                  future: listingNFTInfo,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text(
                        'Error: ${snapshot.error}',
                        overflow: TextOverflow.ellipsis,
                      );
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return Column(
                        children: [
                          const Text(
                            'Your listing NFT:',
                            style: TextStyle(fontSize: 16),
                          ),
                          ...snapshot.data!.map((nftInfo) {
                            return SelectableText(
                              'NFT ${nftInfo["title"]}: in ${nftInfo["nft_contract_id"]} collection whit NFT ID - ${nftInfo["token_id"]}.',
                              maxLines: null,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 16),
                            );
                          }).toList(),
                        ],
                      );
                    } else {
                      return const Text('You do not have listing nft');
                    }
                  },
                ),
          FilledButton(
            onPressed: () {
              setState(() {
                listingNFTInfo = checkListingNFT();
              });
            },
            child: const Text('Check info listing',
                style: TextStyle(color: Colors.white, fontSize: 15)),
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primary)),
          ),
        ],
      ),
    );
  }
}
