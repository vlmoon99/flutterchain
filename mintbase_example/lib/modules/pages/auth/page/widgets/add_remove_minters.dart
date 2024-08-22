import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/thems/thems.dart';
import 'package:mintbase_example/modules/controllers/auth_controller.dart';

class AddRemoveMinters extends StatefulWidget {
  const AddRemoveMinters({super.key});

  @override
  State<AddRemoveMinters> createState() => _AddRemoveMintersState();
}

class _AddRemoveMintersState extends State<AddRemoveMinters> {
  final nearService = Modular.get<NearBlockChainService>();
  final nftCollectionController = TextEditingController();
  final nameController = TextEditingController();
  Future<List<dynamic>>? nameMinters;
  Future<bool>? response;
  bool? _isAdd;

  Future<List<dynamic>> getMinters() async {
    final infocrypto = Modular.get<AuthController>(key: "AuthController").state;
    if (nftCollectionController.text.isEmpty) {
      throw Exception("Input name collection");
    }

    return await nearService.getMinters(
        accountId: infocrypto.accountId,
        publicKey: infocrypto.publicKey,
        privateKey: infocrypto.privateKey,
        nftCollectionContract: nftCollectionController.text);
  }

  Future<bool> addDeleteMinters({
    required String nftCollectionContract,
    required String name,
    required bool isAdd,
  }) async {
    final infocrypto = Modular.get<AuthController>(key: "AuthController").state;

    return await nearService.addDeleteMinters(
        accountId: infocrypto.accountId,
        publicKey: infocrypto.publicKey,
        privateKey: infocrypto.privateKey,
        nftCollectionContract: nftCollectionContract,
        name: name,
        isAdd: isAdd);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Thems.padding,
      decoration: Thems.boxDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Add or delete minters",
            style:
                TextStyle(fontSize: 17, color: Color.fromARGB(255, 245, 79, 1)),
          ),
          SizedBox(height: 10),
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Input account id'),
          ),
          TextField(
            controller: nftCollectionController,
            decoration: const InputDecoration(
                labelText: 'Input name collection(full name contract)'),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isAdd = true;
                    response = addDeleteMinters(
                        nftCollectionContract: nftCollectionController.text,
                        name: nameController.text,
                        isAdd: true);
                  });
                },
                child: const Text('ADD',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.primary)),
              ),
              SizedBox(width: 45),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    _isAdd = false;
                    response = addDeleteMinters(
                        nftCollectionContract: nftCollectionController.text,
                        name: nameController.text,
                        isAdd: false);
                  });
                },
                child: const Text('DELETE',
                    style: TextStyle(color: Colors.white, fontSize: 15)),
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                        Theme.of(context).colorScheme.primary)),
              ),
            ],
          ),
          response == null
              ? const Text("There was no interaction")
              : Flexible(
                  child: FutureBuilder<bool>(
                    future: response,
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return SelectableText('Error: ${snapshot.error}');
                      } else {
                        if (_isAdd == true) {
                          return const Text(
                            "Minters was add",
                            style: TextStyle(fontSize: 16),
                          );
                        } else {
                          return const Text(
                            "Minters was delete",
                            style: TextStyle(fontSize: 16),
                          );
                        }
                      }
                    },
                  ),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              nameMinters == null
                  ? const Center(
                      child: Text(
                          "Data about minters not loaded,\nfor interaction add name collection",
                          softWrap: true),
                    )
                  : Flexible(
                      child: FutureBuilder<List<dynamic>>(
                        future: nameMinters,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<dynamic>> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return const Text(
                              'Error:',
                              overflow: TextOverflow.ellipsis,
                            );
                          } else if (snapshot.hasData &&
                              snapshot.data!.isNotEmpty) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Your minters:',
                                  style: TextStyle(fontSize: 16),
                                ),
                                ...snapshot.data!.map((minters) {
                                  return Text(
                                    softWrap: true,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: null,
                                    '${minters}',
                                    style: const TextStyle(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 16),
                                  );
                                }).toList(),
                              ],
                            );
                          } else {
                            return const Text('You do not have minters');
                          }
                        },
                      ),
                    ),
              IconButton(
                icon: Icon(Icons.replay_outlined),
                onPressed: () => setState(() {
                  nameMinters = getMinters();
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
