import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Future<BlockchainResponse> deployNFTCollection(
      {required String accountId,
      required String publicKey,
      required String privateKey,
      required String symbol,
      String? icon,
      String? baseUri,
      String? reference,
      String? referenceHash}) async {
    final Map<String, dynamic> args = {
      "symbol": symbol,
      "icon": icon,
      "baseUri": baseUri,
      "reference": reference,
      "referenceHash": referenceHash
    };
    return await Modular.get<NearBlockChainService>().deployNFTCollection(
        accountId: accountId,
        publicKey: publicKey,
        privateKey: privateKey,
        args: args);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Text("hello")),
    );
  }
}
