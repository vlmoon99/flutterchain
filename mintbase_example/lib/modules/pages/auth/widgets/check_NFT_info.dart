import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/modules/pages/thems/thems.dart';
import 'package:mintbase_example/modules/services/auth_controller.dart';

class CheckInfo extends StatefulWidget {
  const CheckInfo({super.key});

  @override
  State<CheckInfo> createState() => _CheckInfoState();
}

class _CheckInfoState extends State<CheckInfo> {
  final nearService = Modular.get<NearBlockChainService>();

  Future<List<dynamic>>? listInfo;

  Future<List<dynamic>> checkNFTInfo() async {
    final AuthController infoAccount = Modular.get(key: "AuthController");

    return await nearService.checkNFTInfo(
        owner_id: infoAccount.state.accountId, testnet: true);
  }

  @override
  void initState() {
    listInfo = checkNFTInfo();
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
                            'Your NFT:',
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
                                  color: const Color.fromARGB(255, 0, 0, 0),
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
          ElevatedButton(
            onPressed: () {
              setState(() {
                listInfo = checkNFTInfo();
              });
            },
            child: const Text('Check info'),
          ),
        ],
      ),
    );
  }
}
