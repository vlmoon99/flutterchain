import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:mintbase_example/modules/controllers/auth_controller.dart';
import 'package:mintbase_example/thems/thems.dart';

class ListingActivate extends StatefulWidget {
  const ListingActivate({super.key});

  @override
  State<ListingActivate> createState() => _ListingActivateState();
}

class _ListingActivateState extends State<ListingActivate> {
  final nearService = Modular.get<NearBlockChainService>();
  Future<bool>? isActivate;

  Future<bool> storageListingActivate() async {
    final infocrypto = Modular.get<AuthController>(key: "AuthController").state;

    return await nearService.ListingActivate(
        accountId: infocrypto.accountId,
        publicKey: infocrypto.publicKey,
        privateKey: infocrypto.privateKey);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Thems.boxDecoration,
      padding: Thems.padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Storage Listing Activate',
              style: TextStyle(
                  fontSize: 17, color: Color.fromARGB(255, 245, 79, 1))),
          SizedBox(height: 10),
          const Text(
              'If this listing your first, activate your profile for listing',
              style: TextStyle(
                fontSize: 17,
              )),
          FilledButton(
            onPressed: () {
              setState(() {
                isActivate = storageListingActivate();
              });
            },
            child: const Text('Activate',
                style: TextStyle(color: Colors.white, fontSize: 15)),
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.primary)),
          ),
          isActivate == null
              ? const Text("No action on listing")
              : FutureBuilder<bool>(
                  future: isActivate,
                  builder:
                      (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return SelectableText('Error: ${snapshot.error}');
                    } else {
                      return const SelectableText(
                        "Activate successful",
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
