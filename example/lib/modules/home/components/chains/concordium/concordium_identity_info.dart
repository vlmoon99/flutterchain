import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/identity_info.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/concordium_blockchain_service.dart';
import 'package:flutterchain_example/modules/home/components/core/crypto_actions_card.dart';
import 'package:flutterchain_example/modules/home/vms/chains/concordium_vm.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class ConcordiumIdentityInfo extends StatelessWidget {
  const ConcordiumIdentityInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final ConcordiumBlockChainService concordiumBlockChainService =
        Modular.get<ConcordiumBlockChainService>();
    final ConcordiumVm concordiumVm = Modular.get<ConcordiumVm>();
    final FlutterSecureStorage storage = Modular.get<FlutterSecureStorage>();
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    return CryptoActionCard(
      title: "Identity Info",
      icon: Icons.person,
      color: nearColors.nearPurple,
      height: 300.h,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder(future: Future(
              () async {
                if (kIsWeb) {
                  final savedIdentityUrl = await storage.read(key: "code_uri");
                  return concordiumBlockChainService
                      .getIdentityInfo(savedIdentityUrl!);
                } else {
                  final identityProvider =
                      (await concordiumBlockChainService.getIdentityProviders())
                          .firstWhere(
                    (element) {
                      return element.ipInfo["ipIdentity"] ==
                          concordiumVm.state.identityProviderIndex;
                    },
                  );

                  // we dont have to store all time url to get identity info. we can recover it anytime
                  return concordiumBlockChainService.recoverExistingIdentity(
                    mnemonic: concordiumVm.state.mnemonic,
                    identityProvider: identityProvider,
                    identityIndex:
                        0, // hardcoded to 0 but can be any number from existing identitys
                  );
                }
              },
            ), builder: (context, snapshot) {
              if (snapshot.hasData) {
                final IdentityInfo identity = snapshot.data!;
                return Column(
                  children: [
                    Text(
                      "First Name: " +
                          identity.attributeList["chosenAttributes"]
                              ["firstName"],
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(
                        "Last Name: " +
                            identity.attributeList["chosenAttributes"]
                                ["lastName"],
                        style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text(
                        "Nationality: " +
                            identity.attributeList["chosenAttributes"]
                                ["nationality"],
                        style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text(
                      "Country of residence: " +
                          identity.attributeList["chosenAttributes"]
                              ["countryOfResidence"],
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10),
                    Text(
                        "Account created at: " +
                            identity.attributeList["createdAt"],
                        style: TextStyle(fontSize: 20)),
                    SizedBox(height: 10),
                    Text(
                        "Account valid to: " +
                            identity.attributeList["validTo"],
                        style: TextStyle(fontSize: 20)),
                  ],
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
          ],
        ),
      ),
    );
  }
}
