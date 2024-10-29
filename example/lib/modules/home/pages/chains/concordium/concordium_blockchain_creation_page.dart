import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_derivation_path.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/identity_provider.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/concordium_blockchain_service.dart';
import 'package:flutterchain_example/modules/home/vms/chains/concordium_vm.dart';
import 'package:flutterchain_example/routes/routes.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class ConcordiumBlockchainCreationPage extends StatefulWidget {
  const ConcordiumBlockchainCreationPage(
      {super.key, required this.identityCaught});

  final bool identityCaught;

  @override
  State<ConcordiumBlockchainCreationPage> createState() =>
      _ConcordiumBlockchainCreationPageState();
}

class _ConcordiumBlockchainCreationPageState
    extends State<ConcordiumBlockchainCreationPage> {
  String mnemonic = "";
  List<IdentityProvider> identityProviders = [];
  IdentityProvider? selectedIdentityProvider;

  bool isLoading = true;
  String currentStatus = "Loading";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final ConcordiumBlockChainService concordiumBlockChainService =
          Modular.get<ConcordiumBlockChainService>();
      final FlutterSecureStorage storage = Modular.get<FlutterSecureStorage>();
      if (widget.identityCaught) {
        final savedIdentityUrl = await storage.read(key: "code_uri");
        createCredential(savedIdentityUrl!);
      } else {
        final generatedMnemonic =
            await concordiumBlockChainService.generateMnemonic();
        final loadedIdentityProviders =
            await concordiumBlockChainService.getIdentityProviders();
        setState(() {
          mnemonic = generatedMnemonic;
          identityProviders = loadedIdentityProviders;
          selectedIdentityProvider = loadedIdentityProviders.first;
          isLoading = false;
        });
      }
    });
  }

  Future<void> createCredential(String identityInfoUrl) async {
    final ConcordiumBlockChainService concordiumBlockChainService =
        Modular.get<ConcordiumBlockChainService>();
    final ConcordiumVm concordiumVm = Modular.get<ConcordiumVm>();

    setState(() {
      currentStatus = "Receiving identity info";
    });
    if (kIsWeb) {
      await concordiumVm.loadStateFromStorage();
    }

    final identityInfo =
        await concordiumBlockChainService.getIdentityInfo(identityInfoUrl);

    final identityProvider =
        (await concordiumBlockChainService.getIdentityProviders()).firstWhere(
      (element) {
        return element.ipInfo["ipIdentity"] ==
            concordiumVm.state.identityProviderIndex;
      },
    );

    const int credsNumber =
        0; // always with index 0 when creating first credential for identity

    setState(() {
      currentStatus = "Creating account";
    });

    final resultOfOperation = await concordiumBlockChainService.createAccount(
      mnemonic: concordiumVm.state.mnemonic,
      derivationPath: ConcordiumDerivationPath(
        identityProviderIndex: concordiumVm.state.identityProviderIndex,
        identityIndex: 0,
        credentialIndex: credsNumber,
      ),
      identityInfo: identityInfo,
      identityProviderInfo: identityProvider,
    );

    setState(() {
      currentStatus = "Success";
    });

    concordiumVm.updateState(
      blockchainsData: [
        await concordiumBlockChainService.getBlockChainData(
          mnemonic: concordiumVm.state.mnemonic,
          derivationPath: ConcordiumDerivationPath(
            identityProviderIndex: concordiumVm.state.identityProviderIndex,
            identityIndex: 0,
            credentialIndex: credsNumber,
          ),
        ) as ConcordiumBlockChainData,
      ],
    ).then(
      (_) {
        concordiumVm.saveStateToStorage();
      },
    );

    showDialog(
      context: Modular.routerDelegate.navigatorKey.currentContext!,
      builder: (context) {
        return AlertDialog(
          title: const Text("Success"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectableText(
                  "Address: ${resultOfOperation.data["accountAddress"]}"),
              const SizedBox(height: 20),
              SelectableText(
                  "Transaction hash: ${resultOfOperation.data["txHash"]}"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Modular.to.navigate(".${Routes.home.concordiumActions}");
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ConcordiumBlockChainService concordiumBlockChainService =
        Modular.get<ConcordiumBlockChainService>();
    final ConcordiumVm concordiumVm = Modular.get<ConcordiumVm>();
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Concordium Wallet Creation"),
        centerTitle: true,
        backgroundColor: nearColors.nearPurple,
      ),
      body: isLoading
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20).r,
                  child: Text("$currentStatus..."),
                )
              ],
            ))
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20).r,
                    child: SelectableText("Mnemonic: $mnemonic"),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Provider: ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(width: 20),
                      DropdownButton<IdentityProvider>(
                        value: selectedIdentityProvider,
                        items: identityProviders
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.ipInfo["ipDescription"]["name"]),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedIdentityProvider = value;
                            // value!.ipInfo["ipIdentity"];
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                        currentStatus = "Creating Identity";
                      });
                      await concordiumVm.updateState(
                        mnemonic: mnemonic,
                        identityProviderIndex:
                            selectedIdentityProvider!.ipInfo["ipIdentity"],
                      );

                      final createIdentityRequestParams =
                          await concordiumBlockChainService
                              .getCreateIdentityRequestParams(
                        mnemonic: mnemonic,
                        identityProvider: selectedIdentityProvider!,
                        identityIndex:
                            0, // we always create the first identity with index 0
                      );

                      setState(() {
                        currentStatus =
                            "Creating Identity register request. Redirecting after few seconds";
                      });
                      await Future.delayed(const Duration(seconds: 3));

                      // for web we use redirect to return here later
                      if (kIsWeb) {
                        await Modular.to.pushNamed(
                          ".${Routes.home.redirect}",
                          arguments: {
                            "identityProvider": selectedIdentityProvider ??
                                identityProviders.first,
                            "createIdentityRequestParams":
                                createIdentityRequestParams
                          },
                        );
                      } else {
                        // for another platforms we can use integrated method with iframe
                        final creationUrl = await concordiumBlockChainService
                            .getIdentityCreateRequestUrl(
                          identityProvider: identityProviders.first,
                          createIdentityRequestParams:
                              createIdentityRequestParams,
                        );
                        final urlForIdentityInfo =
                            await concordiumBlockChainService
                                .createIdentityDialog(
                          context: Modular
                              .routerDelegate.navigatorKey.currentContext!,
                          creationUrl: creationUrl,
                        );
                        createCredential(urlForIdentityInfo!);
                      }
                    },
                    child: const Text("Create Account"),
                  ),
                ],
              ),
            ),
    );
  }
}
