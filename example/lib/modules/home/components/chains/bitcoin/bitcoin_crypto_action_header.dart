import 'dart:developer';
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/bitcoin/bitcoin_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/bitcoin/bitcoin_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/bitcoin_blockchain_service.dart';
import 'package:flutterchain_example/modules/home/vms/chains/bitcoin/bitcoin_vm.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class BitcoinCryptoActionHeader extends StatefulWidget {
  const BitcoinCryptoActionHeader({
    Key? key,
  }) : super(key: key);

  @override
  _BitcoinCryptoActionHeaderState createState() =>
      _BitcoinCryptoActionHeaderState();
}

class _BitcoinCryptoActionHeaderState extends State<BitcoinCryptoActionHeader> {
  String selectedUrl = '';

  final TextEditingController _customUrlController = TextEditingController();

  final Set<String> networkUrls = {};

  void _handleCustomUrlChanged(String url) {
    setState(() {
      final bitcoinVM = Modular.get<BitcoinVM>();
      networkUrls.add(url);
      selectedUrl = url;
      bitcoinVM.cryptoLibrary.blockchainService.setBlockchainNetworkEnvironment(
        blockchainType: BlockChains.near,
        blockChainNetworkEnvironmentSettings:
            BitcoinNetworkEnvironmentSettings(chainUrl: selectedUrl),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    final bitcoinVM = Modular.get<BitcoinVM>();
    final preDefinedUrls = bitcoinVM.cryptoLibrary.blockchainService
        .blockchainServices[BlockChains.bitcoin]!
        .getBlockchainsUrlsByBlockchainType();
    networkUrls.addAll(preDefinedUrls);
    selectedUrl = networkUrls.first;
    bitcoinVM.cryptoLibrary.blockchainService.setBlockchainNetworkEnvironment(
      blockchainType: BlockChains.bitcoin,
      blockChainNetworkEnvironmentSettings:
          BitcoinNetworkEnvironmentSettings(chainUrl: selectedUrl),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    final bitcoinVM = Modular.get<BitcoinVM>();
    final bitcoinBlockChainService = bitcoinVM.cryptoLibrary.blockchainService
        .blockchainServices[BlockChains.bitcoin] as BitcoinBlockChainService;

    return StreamBuilder<DerivationPath>(
        stream: bitcoinVM.bitcoinBlockchainStore.currentDerivationPath,
        builder: (context, snapshot) {
          final derivationModel =
              bitcoinVM.bitcoinBlockchainStore.currentDerivationPath.value;
          final listOfBlockChainData = bitcoinVM
              .cryptoLibrary.walletsStream.value
              .firstWhere((element) =>
                  element.id == bitcoinVM.userStore.walletIdStream.value)
              .blockchainsData![BlockChains.bitcoin];
          final bitcoinBlockChainData = bitcoinVM
                  .cryptoLibrary.walletsStream.value
                  .firstWhere((element) =>
                      element.id == bitcoinVM.userStore.walletIdStream.value)
                  .blockchainsData![BlockChains.bitcoin]
                  ?.firstWhereOrNull(
                      (element) => element.derivationPath == derivationModel)
              as BitcoinBlockChainData;

          final currentPublicAddress = bitcoinBlockChainData.publicKey;

          final currentPrivAddress = bitcoinBlockChainData.privateKey;

          log("currentPublicAddress $currentPublicAddress");
          log("currentPrivAddress $currentPrivAddress");
          log("mnemonic ${bitcoinVM.cryptoLibrary.walletsStream.value.firstWhere((element) => element.id == bitcoinVM.userStore.walletIdStream.value).mnemonic}");

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
                        'Your Derivation Path :${bitcoinBlockChainData.derivationPath}',
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
                          final bitcoinVM = Modular.get<BitcoinVM>();
                          bitcoinVM.bitcoinBlockchainStore.currentDerivationPath
                              .add(value!);
                        });
                      },
                      items: listOfBlockChainData
                          ?.map((blockChainData) =>
                              DropdownMenuItem<DerivationPath>(
                                value: blockChainData.derivationPath
                                    as DerivationPath,
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
                        'Your Address : ${bitcoinBlockChainData.accountId}',
                        style: nearTextStyles.headline!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: nearColors.nearBlack,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                    FutureBuilder(
                      future: bitcoinVM.getBalanceByDerivationPath(
                        walletId: bitcoinVM.userStore.walletIdStream.value,
                        derivationPathData: derivationModel,
                      ),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SelectableText(
                              'Total Amount of ${BlockChains.bitcoin} :${double.parse(snapshot.data.toString()).toStringAsFixed(8)}',
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
                          final bitcoinVM = Modular.get<BitcoinVM>();
                          bitcoinVM.cryptoLibrary.blockchainService
                              .setBlockchainNetworkEnvironment(
                            blockchainType: BlockChains.bitcoin,
                            blockChainNetworkEnvironmentSettings:
                                BitcoinNetworkEnvironmentSettings(
                                    chainUrl: selectedUrl),
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
                        'This is price for Fee/Bayte',
                        style: nearTextStyles.headline!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: nearColors.nearBlack,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                    FutureBuilder(
                      future: bitcoinBlockChainService.getActualPriceFee(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = snapshot.data?.data.values.first as Map;
                          var interevlData = data.keys
                              .map((e) => "$e: ${data[e] + 7}\n")
                              .join(" ");
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: SelectableText(
                              interevlData,
                              style: const TextStyle(
                                fontSize: 16,
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
            ],
          );
        });
  }
}
