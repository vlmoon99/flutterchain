import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/modules/pages/thems/thems.dart';
import 'package:mintbase_example/modules/services/auth_controller.dart';

class MultiplyNFT extends StatefulWidget {
  const MultiplyNFT({super.key});

  @override
  State<MultiplyNFT> createState() => _MultiplyNFTState();
}

class _MultiplyNFTState extends State<MultiplyNFT> {
  final nameNFTCollectionController = TextEditingController();
  final nameNFTController = TextEditingController();
  final numToMultiplyController = TextEditingController();

  final nearService = Modular.get<NearBlockChainService>();

  Future<bool>? isMint;

  Future<bool> multiplyNFT(
      {required String nameNFTCollection,
      required String nameNFT,
      required int numToMint}) {
    final AuthController infoAccount = Modular.get(key: "AuthController");

    return nearService.multiplyNFT(
        nameNFTCollection: nameNFTCollection,
        nameNFT: nameNFT,
        accountId: infoAccount.state.accountId,
        publicKey: infoAccount.state.publicKey,
        privateKey: infoAccount.state.privateKey,
        numToMint: numToMint);
  }

  @override
  void initState() {
    numToMultiplyController.text = "1";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Thems.boxDecoration,
      padding: Thems.padding,
      child: Column(
        children: [
          const Text('Multiply NFT',
              style: TextStyle(
                  fontSize: 17, color: Color.fromARGB(255, 245, 79, 1))),
          const Text('You must be owner this NFT',
              style: TextStyle(
                fontSize: 16,
              )),
          SizedBox(height: 10),
          TextField(
            controller: nameNFTCollectionController,
            decoration:
                const InputDecoration(labelText: 'Input name NFT collection'),
          ),
          TextField(
            controller: nameNFTController,
            decoration: const InputDecoration(labelText: 'Input name NFT'),
          ),
          TextField(
            controller: numToMultiplyController,
            decoration:
                const InputDecoration(labelText: 'Input num to multiply'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                isMint = multiplyNFT(
                    nameNFTCollection: nameNFTCollectionController.text,
                    nameNFT: nameNFTController.text,
                    numToMint: int.tryParse(numToMultiplyController.text)!);
              });
            },
            child: const Text('Multiply NFT'),
          ),
          isMint == null
              ? const Text("No action on multiply minting")
              : FutureBuilder<bool>(
                  future: isMint,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return SelectableText('Error: ${snapshot.error}');
                    } else {
                      return const SelectableText(
                        "NFT was multiply successful",
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
