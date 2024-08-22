import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/modules/models/auth_info_model/auth_info.dart';
import 'package:mintbase_example/modules/pages/auth/page/widgets/add_remove_minters.dart';
import 'package:mintbase_example/modules/pages/auth/page/widgets/buy_simple_list_nft.dart';
import 'package:mintbase_example/modules/pages/auth/page/widgets/check_nft_info.dart';
import 'package:mintbase_example/modules/pages/auth/page/widgets/create_collection_dialog.dart';
import 'package:mintbase_example/modules/pages/auth/page/widgets/mint_nft.dart';
import 'package:mintbase_example/modules/pages/auth/page/widgets/multiply.dart';
import 'package:mintbase_example/modules/pages/auth/page/widgets/offers.dart';
import 'package:mintbase_example/modules/pages/auth/page/widgets/rolling_auction_nft.dart';
import 'package:mintbase_example/modules/pages/auth/page/widgets/simple_sale_nft.dart';
import 'package:mintbase_example/modules/pages/auth/page/widgets/listing_activate.dart';
import 'package:mintbase_example/modules/pages/auth/page/widgets/transfer_collection_dialog.dart';
import 'package:mintbase_example/modules/pages/auth/page/widgets/transfet_nft.dart';
import 'package:mintbase_example/modules/pages/auth/page/widgets/unlist_delist_nft.dart';
import 'package:mintbase_example/thems/thems.dart';
import 'package:mintbase_example/modules/controllers/auth_controller.dart';
import 'package:mintbase_example/routes/routes.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String? accountId;
  String? privateKey;
  String? publicKey;
  NearNetworkType? networkType;
  Future<String>? balance;
  Future<List<dynamic>>? nameOwnerCollections;
  Future<List<dynamic>>? nameMinterCollections;

  final nearService = Modular.get<NearBlockChainService>();

  Future<String> getWalletBalance({required String account_id}) async {
    return await nearService
        .getWalletBalance(NearTransferRequest(accountID: account_id));
  }

  void getInfoStream() async {
    final AuthInfo info =
        Modular.get<AuthController>(key: "AuthController").state;
    setState(() {
      accountId = info.accountId;
      privateKey = info.privateKey;
      publicKey = info.publicKey;
      networkType = info.networkType;
    });
  }

  Future<List<dynamic>> checkOwnerCollection() async {
    if (accountId == null) {
      throw Exception("AccountId is not defined");
    }
    return await nearService.checkOwnerCollection(owner_id: accountId!);
  }

  Future<List<dynamic>> checkMinterCollection() async {
    return await nearService.checkMinterCollection(owner_id: accountId!);
  }

  @override
  void initState() {
    getInfoStream();
    balance = getWalletBalance(account_id: accountId!);
    nameOwnerCollections = checkOwnerCollection();
    nameMinterCollections = checkMinterCollection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Mintbase integration",
          style:
              TextStyle(fontSize: 25, color: Color.fromARGB(255, 219, 85, 85)),
        ),
        centerTitle: true,
        foregroundColor: Color.fromARGB(255, 219, 85, 85),
        backgroundColor: Color.fromARGB(225, 167, 167, 167),
        shadowColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  // key: UniqueKey(),
                  children: [
                    Container(
                        padding: Thems.padding,
                        decoration: Thems.boxDecoration,
                        child: Column(
                          children: [
                            const Text(
                              "Main info",
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Color.fromARGB(255, 219, 85, 85)),
                            ),
                            if (accountId != null &&
                                privateKey != null &&
                                publicKey != null) ...[
                              SelectableText(
                                "AccountId: ${accountId}",
                                style: TextStyle(fontSize: 16),
                              ),
                              SelectableText(
                                'PrivateKey: ${privateKey}',
                                style: TextStyle(fontSize: 16),
                              ),
                              SelectableText(
                                "PublicKey: ${publicKey}",
                                style: TextStyle(fontSize: 16),
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Your balance: ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    balance == null
                                        ? const Text(
                                            "The balance hasn't been loaded yet")
                                        : Flexible(
                                            child: FutureBuilder<String>(
                                              future: balance,
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<String>
                                                      snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return const Center(
                                                      child:
                                                          CircularProgressIndicator());
                                                } else if (snapshot.hasError) {
                                                  return SelectableText(
                                                      'Error: ${snapshot.error}');
                                                } else {
                                                  final data = snapshot.data!;
                                                  return SelectableText(
                                                    data,
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                    IconButton(
                                      icon: Icon(Icons.replay_outlined),
                                      onPressed: () => setState(() {
                                        balance = getWalletBalance(
                                            account_id: accountId!);
                                      }),
                                    ),
                                  ]),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  nameOwnerCollections == null
                                      ? const Text(
                                          "Data about owner collections not loaded")
                                      : Flexible(
                                          child: FutureBuilder<List<dynamic>>(
                                            future: nameOwnerCollections,
                                            builder: (BuildContext context,
                                                AsyncSnapshot<List<dynamic>>
                                                    snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const CircularProgressIndicator();
                                              } else if (snapshot.hasError) {
                                                return const Text(
                                                  'Error:',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                );
                                              } else if (snapshot.hasData &&
                                                  snapshot.data!.isNotEmpty) {
                                                return Column(
                                                  children: [
                                                    const Text(
                                                      'Your owner collections:',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    ...snapshot.data!
                                                        .map((collection) {
                                                      return SelectableText(
                                                        collection,
                                                        style: const TextStyle(
                                                            color: const Color
                                                                .fromARGB(
                                                                255, 0, 0, 0),
                                                            fontSize: 16),
                                                      );
                                                    }).toList(),
                                                  ],
                                                );
                                              } else {
                                                return const Text(
                                                    'You do not have collection');
                                              }
                                            },
                                          ),
                                        ),
                                  IconButton(
                                    icon: Icon(Icons.replay_outlined),
                                    onPressed: () => setState(() {
                                      nameOwnerCollections =
                                          checkOwnerCollection();
                                    }),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  nameMinterCollections == null
                                      ? const Text(
                                          "Data about minter collections not loaded")
                                      : Flexible(
                                          child: FutureBuilder<List<dynamic>>(
                                            future: nameMinterCollections,
                                            builder: (BuildContext context,
                                                AsyncSnapshot<List<dynamic>>
                                                    snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const CircularProgressIndicator();
                                              } else if (snapshot.hasError) {
                                                return Text(
                                                  'Error: ${snapshot.error}',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                );
                                              } else if (snapshot.hasData &&
                                                  snapshot.data!.isNotEmpty) {
                                                return Column(
                                                  children: [
                                                    const Text(
                                                      'Your minter collections:',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                    ...snapshot.data!
                                                        .map((collection) {
                                                      return SelectableText(
                                                        '${collection}',
                                                        style: const TextStyle(
                                                            color: const Color
                                                                .fromARGB(
                                                                255, 0, 0, 0),
                                                            fontSize: 16),
                                                      );
                                                    }).toList(),
                                                  ],
                                                );
                                              } else {
                                                return const Text(
                                                    'You do not have collection');
                                              }
                                            },
                                          ),
                                        ),
                                  IconButton(
                                    icon: Icon(Icons.replay_outlined),
                                    onPressed: () => setState(() {
                                      nameMinterCollections =
                                          checkMinterCollection();
                                    }),
                                  ),
                                ],
                              ),
                            ] else ...[
                              const Text('Some gone wrong, please try again')
                            ]
                          ],
                        )),
                    SizedBox(height: 13),
                    CheckInfo(),
                    SizedBox(height: 13),
                    CreateCollectionDialog(),
                    SizedBox(height: 13),
                    TransferCollectionDialog(),
                    SizedBox(height: 13),
                    AddRemoveMinters(),
                    SizedBox(height: 13),
                    Mintnft(),
                    SizedBox(height: 13),
                    TransfetNft(),
                    SizedBox(height: 13),
                    MultiplyNFT(),
                    SizedBox(height: 13),
                    ListingActivate(),
                    SizedBox(height: 13),
                    SimpleSale(),
                    SizedBox(height: 13),
                    UnlistDelistNFT(),
                    SizedBox(height: 13),
                    BuySimpleListNft(),
                    SizedBox(height: 13),
                    RollingAuctionNft(),
                    SizedBox(height: 13),
                    Offers(),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
