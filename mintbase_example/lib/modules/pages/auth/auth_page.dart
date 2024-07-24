import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/modules/models/models.dart';
import 'package:mintbase_example/modules/pages/auth/widgets/create_collection_dialog.dart';
import 'package:mintbase_example/modules/services/auth_controller.dart';
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
  Future<String>? balance;

  final nearService = Modular.get<NearBlockChainService>();

  Future<String> getWalletBalance({required String account_id}) async {
    return await nearService
        .getWalletBalance(NearTransferRequest(accountID: account_id));
  }

  void getInfoStream() {
    final AuthInfo info =
        Modular.get<AuthController>(key: "AuthController").state;
    setState(() {
      accountId = info.accountId;
      privateKey = info.privateKey;
      publicKey = info.publicKey;
    });
  }

  @override
  void initState() {
    getInfoStream();
    balance = getWalletBalance(account_id: accountId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Column(
          children: [
            IconButton(
                icon: Icon(Icons.keyboard_double_arrow_left),
                onPressed: () => Modular.to.navigate(CoreRoutes.home)),
            Container(
              child: const Text(
                "Mintbase integration",
                style: TextStyle(fontSize: 25, color: Colors.red),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  // key: UniqueKey(),
                  children: [
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          children: [
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
                                    balance == null
                                        ? Text(
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
                            ] else ...[
                              const Text('Some gone wrong, please try again')
                            ]
                          ],
                        )),
                    SizedBox(
                      height: 13,
                    ),
                    CreateCollectionDialog(),
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
