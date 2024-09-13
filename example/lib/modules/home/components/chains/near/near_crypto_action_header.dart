import 'dart:developer';
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/near_vm.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class NearCryptoActionHeader extends StatefulWidget {
  const NearCryptoActionHeader({
    Key? key,
  }) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _NearCryptoActionHeaderState createState() => _NearCryptoActionHeaderState();
}

class _NearCryptoActionHeaderState extends State<NearCryptoActionHeader> {
  String selectedUrl = '';

  final TextEditingController _customUrlController = TextEditingController();

  final Set<String> networkUrls = {};

  void _handleCustomUrlChanged(String url) {
    setState(() {
      final nearVM = Modular.get<NearVM>();
      networkUrls.add(url);
      selectedUrl = url;
      nearVM.cryptoLibrary.blockchainService.setBlockchainNetworkEnvironment(
          blockchainType: BlockChains.near, newUrl: selectedUrl);
    });
  }

  @override
  void initState() {
    super.initState();
    final nearVM = Modular.get<NearVM>();
    final preDefinedUrls = nearVM
        .cryptoLibrary.blockchainService.blockchainServices[BlockChains.near]!
        .getBlockchainsUrlsByBlockchainType();
    networkUrls.addAll(preDefinedUrls);
    selectedUrl = networkUrls.first;
    nearVM.cryptoLibrary.blockchainService.setBlockchainNetworkEnvironment(
      blockchainType: BlockChains.near,
      newUrl: selectedUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    final nearVM = Modular.get<NearVM>();

    return StreamBuilder<DerivationPath>(
        stream: nearVM.nearBlockchainStore.currentDerivationPath,
        builder: (context, snapshot) {
          final derivationModel =
              nearVM.nearBlockchainStore.currentDerivationPath.value;
          final listOfBlockChainData = nearVM.cryptoLibrary.walletsStream.value
              .firstWhere((element) =>
                  element.id == nearVM.userStore.walletIdStream.value)
              .blockchainsData![BlockChains.near];
          final currentPublicAddress = nearVM.cryptoLibrary.walletsStream.value
              .firstWhere((element) =>
                  element.id == nearVM.userStore.walletIdStream.value)
              .blockchainsData![BlockChains.near]
              ?.firstWhereOrNull(
                  (element) => element.derivationPath == derivationModel)
              ?.publicKey;
          final currentPrivAddress = nearVM.cryptoLibrary.walletsStream.value
              .firstWhere((element) =>
                  element.id == nearVM.userStore.walletIdStream.value)
              .blockchainsData![BlockChains.near]
              ?.firstWhereOrNull(
                  (element) => element.derivationPath == derivationModel)
              ?.privateKey;

          final derivationPath = nearVM.cryptoLibrary.walletsStream.value
              .firstWhere((element) =>
                  element.id == nearVM.userStore.walletIdStream.value)
              .blockchainsData![BlockChains.near]
              ?.firstWhereOrNull((element) {
            if (element.derivationPath == derivationModel) {
              return true;
            } else {
              return false;
            }
          })?.derivationPath;
          log("currentPublicAddress $currentPublicAddress");
          log("currentPrivAddress $currentPrivAddress");
          log("mnemonic ${nearVM.cryptoLibrary.walletsStream.value.firstWhere((element) => element.id == nearVM.userStore.walletIdStream.value).mnemonic}");

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: nearColors.nearAqua,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 20,
                      ),
                      child: SelectableText(
                        'Your Derivation Path :$derivationPath',
                        style: nearTextStyles.headline!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: nearColors.nearBlack,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                    DropdownButton<DerivationPath>(
                      value: derivationModel,
                      onChanged: (DerivationPath? value) {
                        setState(() {
                          final nearVM = Modular.get<NearVM>();
                          nearVM.nearBlockchainStore.currentDerivationPath
                              .add(value!);
                        });
                      },
                      items: listOfBlockChainData
                          ?.map((blockChainData) =>
                              DropdownMenuItem<DerivationPath>(
                                value: blockChainData.derivationPath as DerivationPath,
                                child: SelectableText(
                                  blockChainData.derivationPath.toString(),
                                  style: nearTextStyles.bodyCopy!.copyWith(
                                    color: nearColors.nearGray,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: nearColors.nearAqua,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 20,
                      ),
                      child: SelectableText(
                        'Your Address :$currentPublicAddress',
                        style: nearTextStyles.headline!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: nearColors.nearBlack,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                    FutureBuilder(
                      future: nearVM.getBalanceByDerivationPath(
                          nearTransferRequest: NearTransferRequest(
                              walletId: nearVM.userStore.walletIdStream.value,
                              currentDerivationPath: derivationModel)),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SelectableText(
                              'Total Amount of ${BlockChains.near} :${double.parse(snapshot.data.toString()).toStringAsFixed(2)}',
                              style: nearTextStyles.headline!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: nearColors.nearBlack,
                                fontSize: 20,
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: nearColors.nearAqua,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    SelectableText(
                      'Network:',
                      style: nearTextStyles.bodyCopy!.copyWith(
                        color: nearColors.nearGray,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButton<String>(
                      value: selectedUrl,
                      onChanged: (String? value) {
                        setState(() {
                          selectedUrl = value!;
                          final nearVM = Modular.get<NearVM>();
                          nearVM.cryptoLibrary.blockchainService
                              .setBlockchainNetworkEnvironment(
                            blockchainType: BlockChains.near,
                            newUrl: selectedUrl,
                          );
                        });
                      },
                      items: networkUrls
                          .map((url) => DropdownMenuItem<String>(
                                value: url,
                                child: SelectableText(
                                  url,
                                  style: nearTextStyles.bodyCopy!.copyWith(
                                    color: nearColors.nearGray,
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 150,
                      child: TextField(
                        controller: _customUrlController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: nearColors.nearGray,
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: nearColors.nearPurple,
                              width: 2,
                            ),
                          ),
                          hintText: 'Custom URL',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 12,
                          ),
                          hintStyle: nearTextStyles.bodyCopy!.copyWith(
                            color: nearColors.nearGray,
                          ),
                        ),
                        style: nearTextStyles.bodyCopy!.copyWith(
                          color: nearColors.nearGray,
                        ),
                        onEditingComplete: () {
                          FocusScope.of(context).unfocus();
                          _handleCustomUrlChanged(_customUrlController.text);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        });
  }
}
