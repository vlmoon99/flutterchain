import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/evm/evm_account_info_request.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_mpc_account_info.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/xrp/xrp_account_info_request.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/aurora_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/avalanche_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/bitcoin_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/bnb_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/ethereum_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/polygon_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/xrp_blockchain_service.dart';
import 'package:flutterchain_example/modules/home/components/chains/near/near_action_text_field.dart';
import 'package:flutterchain_example/modules/home/components/core/crypto_actions_card.dart';
import 'package:flutterchain_example/modules/home/vms/chains/near/near_vm.dart';
import 'package:flutterchain_example/theme/app_theme.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ChainSignatureFunctions extends StatefulWidget {
  const ChainSignatureFunctions({super.key});

  @override
  State<ChainSignatureFunctions> createState() =>
      _ChainSignatureFunctionsState();
}

class _ChainSignatureFunctionsState extends State<ChainSignatureFunctions> {
  late String currentBlockChainForChainSignatureFunctions =
      BlockChains.supportedBlockChainsForNearMPC.first;

  final List<String> supportedBlockChainsForEVMContracts = [
    BlockChains.ethereum,
    BlockChains.bnb,
    BlockChains.aurora,
    BlockChains.polygon,
    BlockChains.avalanche,
  ];

  final TextEditingController mpcContractController = TextEditingController()
    ..text = "v2.multichain-mpc.testnet";
  final TextEditingController pathController = TextEditingController()
    ..text = "flutterchain";
  MPCAccountInfo? mpcAccountInfo;
  final TextEditingController sendToController = TextEditingController();
  final TextEditingController amountController = TextEditingController()
    ..text = "0.01";

  final TextEditingController smartContractFunctionController =
      TextEditingController();

  final TextEditingController smartContractArgumentsController =
      TextEditingController();

  String txHash = "";

  bool loadingMpcAccountInfo = false;
  bool executingMpcTransaction = false;

  Future<String> encodeSmartContractArgs(String function, String args) async {
    final argsArray = jsonDecode(args);
    final EthereumBlockChainService ethereumBlockChainService =
        EthereumBlockChainService.defaultInstance();

    final encodedRequest = ethereumBlockChainService.encodeSmartContractCall(
      functionSignature: function,
      parameters: argsArray,
    );

    return encodedRequest;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearColors = theme.getTheme().extension<NearColors>()!;
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    final nearVM = Modular.get<NearVM>();
    final walletID = nearVM.userStore.walletIdStream.value;
    final currentDerivationPath =
        nearVM.nearBlockchainStore.currentDerivationPath.value;
    final currentWallet = nearVM.cryptoLibrary.walletsStream.value
        .firstWhere((element) => element.id == walletID);
    final currentBlockchainData =
        currentWallet.blockchainsData?[BlockChains.near]?.firstWhere(
            (element) => element.derivationPath == currentDerivationPath);
    final NearBlockChainService nearBlockChainService = nearVM
        .cryptoLibrary
        .blockchainService
        .blockchainServices[BlockChains.near] as NearBlockChainService;
    final accountId = currentBlockchainData?.publicKey;
    final privateKey = currentBlockchainData?.privateKey;

    return CryptoActionCard(
      title: "Chain Signature Functions",
      height: 750.w,
      icon: Icons.account_tree_rounded,
      color: nearColors.nearPurple,
      onTap: () async {
        if (sendToController.text.isEmpty ||
            amountController.text.isEmpty ||
            executingMpcTransaction) {
          return;
        }

        setState(() {
          executingMpcTransaction = true;
        });

        try {
          String? smartContractData;
          if (smartContractFunctionController.text.isNotEmpty &&
              smartContractArgumentsController.text.isNotEmpty) {
            smartContractData = await encodeSmartContractArgs(
              smartContractFunctionController.text,
              smartContractArgumentsController.text,
            );
          }

          if (currentBlockChainForChainSignatureFunctions ==
              BlockChains.ethereum) {
            final EthereumBlockChainService ethereumBlockChainService =
                EthereumBlockChainService.defaultInstance();
            log("Getting transaction info...");

            final transactionInfo =
                await ethereumBlockChainService.getTransactionInfo(
              from: mpcAccountInfo!.adress,
              to: sendToController.text,
              data: smartContractData,
              amountInEth: double.parse(amountController.text),
            );

            log("Creating payload...");
            final unsignedTx =
                await ethereumBlockChainService.createPayloadForNearMPC(
              receiverAddress: sendToController.text,
              amount: double.parse(amountController.text),
              transactionInfo: transactionInfo,
              smartContractCallEncoded: smartContractData,
            );

            log("Signing transaction...");
            final signedTX =
                await nearBlockChainService.signEVMTransationWithMPC(
              accountId: accountId!,
              publicKey: currentBlockchainData?.publicKey ?? accountId,
              privateKey: privateKey!,
              mpcTransactionInfo: unsignedTx,
              senderAdress: mpcAccountInfo!.adress,
              path: pathController.text,
              mpcContract: mpcContractController.text,
            );
            log("Sending transaction...");

            final txSendInfo =
                await ethereumBlockChainService.sendTransaction(signedTX);

            if (txSendInfo.status == BlockchainResponses.success) {
              setState(() {
                txHash = txSendInfo.data['txHash'];
              });
            } else {
              print(txSendInfo.data);
            }
          } else if (currentBlockChainForChainSignatureFunctions ==
              BlockChains.bitcoin) {
            final BitcoinBlockChainService bitcoinBlockChainService =
                BitcoinBlockChainService.defaultInstance();

            log("Creating payload...");
            final unsignedTransaction =
                await bitcoinBlockChainService.createPayloadForNearMPC(
              senderAddress: mpcAccountInfo!.adress,
              receiverAddress: sendToController.text,
              amountOfBTC: amountController.text,
            );

            log("Signing transaction...");
            final signedTx =
                await nearBlockChainService.signBTCTransactionWithMPC(
              accountId: accountId!,
              publicKey: currentBlockchainData?.publicKey ?? accountId,
              privateKey: privateKey!,
              mpcSenderPublicKey: mpcAccountInfo!.publicKey,
              transactionInfo: unsignedTransaction,
              mpcContract: mpcContractController.text,
            );

            log("Sending transaction...");
            final txSendInfo =
                await bitcoinBlockChainService.sendTransaction(signedTx);

            if (txSendInfo.status == BlockchainResponses.success) {
              setState(() {
                txHash = txSendInfo.data['data']['tx']['hash'];
              });
            } else {
              print(txSendInfo.data);
            }
          } else if (currentBlockChainForChainSignatureFunctions ==
              BlockChains.bnb) {
            final BNBBlockChainService bnbBlockChainService =
                BNBBlockChainService.defaultInstance();

            log("Getting transaction info...");

            final transactionInfo =
                await bnbBlockChainService.getTransactionInfo(
              from: mpcAccountInfo!.adress,
              to: sendToController.text,
              amountInEth: double.parse(amountController.text),
              data: smartContractData,
            );

            log("Creating payload...");

            final unsignedTx =
                await bnbBlockChainService.createPayloadForNearMPC(
              transactionInfo: transactionInfo,
              receiverAddress: sendToController.text,
              amount: double.parse(amountController.text),
              smartContractCallEncoded: smartContractData,
            );

            log("Signing transaction...");
            final signedTx =
                await nearBlockChainService.signEVMTransationWithMPC(
              accountId: accountId!,
              publicKey: accountId,
              privateKey: privateKey!,
              mpcTransactionInfo: unsignedTx,
              senderAdress: mpcAccountInfo!.adress,
              mpcContract: mpcContractController.text,
            );

            log("Sending transaction...");
            final txSendInfo =
                await bnbBlockChainService.sendTransaction(signedTx);
            if (txSendInfo.status == BlockchainResponses.success) {
              setState(() {
                txHash = txSendInfo.data['txHash'];
              });
              print(txSendInfo.data);
            } else {
              print(txSendInfo.data);
            }
          } else if (currentBlockChainForChainSignatureFunctions ==
              BlockChains.aurora) {
            final AuroraBlockChainService auroraBlockChainService =
                AuroraBlockChainService.defaultInstance();

            log("Getting transaction info...");

            final transactionInfo =
                await auroraBlockChainService.getTransactionInfo(
              from: mpcAccountInfo!.adress,
              to: sendToController.text,
              amountInEth: double.parse(amountController.text),
              data: smartContractData,
            );

            log("Creating payload...");

            final unsignedTx =
                await auroraBlockChainService.createPayloadForNearMPC(
              transactionInfo: transactionInfo,
              receiverAddress: sendToController.text,
              amount: double.parse(amountController.text),
              smartContractCallEncoded: smartContractData,
            );

            log("Signing transaction...");
            final signedTx =
                await nearBlockChainService.signEVMTransationWithMPC(
              accountId: accountId!,
              publicKey: accountId,
              privateKey: privateKey!,
              mpcTransactionInfo: unsignedTx,
              senderAdress: mpcAccountInfo!.adress,
              mpcContract: mpcContractController.text,
            );

            log("Sending transaction...");
            final txSendInfo =
                await auroraBlockChainService.sendTransaction(signedTx);
            if (txSendInfo.status == BlockchainResponses.success) {
              setState(() {
                txHash = txSendInfo.data['txHash'];
              });
              print(txSendInfo.data);
            } else {
              print(txSendInfo.data);
            }
          } else if (currentBlockChainForChainSignatureFunctions ==
              BlockChains.polygon) {
            final PolygonBlockChainService polygonBlockChainService =
                PolygonBlockChainService.defaultInstance();

            log("Getting transaction info...");

            final transactionInfo =
                await polygonBlockChainService.getTransactionInfo(
              from: mpcAccountInfo!.adress,
              to: sendToController.text,
              amountInMatic: double.parse(amountController.text),
              data: smartContractData,
            );

            log("Creating payload...");

            final unsignedTx =
                await polygonBlockChainService.createPayloadForNearMPC(
              transactionInfo: transactionInfo,
              receiverAddress: sendToController.text,
              amount: double.parse(amountController.text),
              smartContractCallEncoded: smartContractData,
            );

            log("Signing transaction...");
            final signedTx =
                await nearBlockChainService.signEVMTransationWithMPC(
              accountId: accountId!,
              publicKey: accountId,
              privateKey: privateKey!,
              mpcTransactionInfo: unsignedTx,
              senderAdress: mpcAccountInfo!.adress,
              mpcContract: mpcContractController.text,
            );

            log("Sending transaction...");
            final txSendInfo =
                await polygonBlockChainService.sendTransaction(signedTx);
            if (txSendInfo.status == BlockchainResponses.success) {
              setState(() {
                txHash = txSendInfo.data['txHash'];
              });
              print(txSendInfo.data);
            } else {
              print(txSendInfo.data);
            }
          } else if (currentBlockChainForChainSignatureFunctions ==
              BlockChains.avalanche) {
            final AvalancheBlockChainService avalancheBlockChainService =
                AvalancheBlockChainService.defaultInstance();

            log("Getting transaction info...");

            final transactionInfo =
                await avalancheBlockChainService.getTransactionInfo(
              from: mpcAccountInfo!.adress,
              to: sendToController.text,
              amountInAvax: double.parse(amountController.text),
              data: smartContractData,
            );

            log("Creating payload...");

            final unsignedTx =
                await avalancheBlockChainService.createPayloadForNearMPC(
              transactionInfo: transactionInfo,
              receiverAddress: sendToController.text,
              amount: double.parse(amountController.text),
              smartContractCallEncoded: smartContractData,
            );

            log("Signing transaction...");
            final signedTx =
                await nearBlockChainService.signEVMTransationWithMPC(
              accountId: accountId!,
              publicKey: accountId,
              privateKey: privateKey!,
              mpcTransactionInfo: unsignedTx,
              senderAdress: mpcAccountInfo!.adress,
              mpcContract: mpcContractController.text,
            );

            log("Sending transaction...");
            final txSendInfo =
                await avalancheBlockChainService.sendTransaction(signedTx);
            if (txSendInfo.status == BlockchainResponses.success) {
              setState(() {
                txHash = txSendInfo.data['txHash'];
              });
              print(txSendInfo.data);
            } else {
              print(txSendInfo.data);
            }
          } else if (currentBlockChainForChainSignatureFunctions ==
              BlockChains.xrp) {
            final XRPBlockChainService xrpBlockChainService =
                XRPBlockChainService.defaultInstance();

            final txInfo = await xrpBlockChainService.getTransactionInfo(
              senderAdress: mpcAccountInfo!.adress,
            );

            final mpcTransactionInfo =
                await xrpBlockChainService.createPayloadForNearMPC(
              mpcAccountInfo: mpcAccountInfo!,
              receiverAddress: sendToController.text,
              amount: double.parse(amountController.text),
              transactionInfo: txInfo,
            );

            final signedTx =
                await nearBlockChainService.signXRPTransactionWithMPC(
              accountId: accountId!,
              publicKey: accountId,
              privateKey: privateKey!,
              mpcTransactionInfo: mpcTransactionInfo,
            );

            final txSendInfo =
                await xrpBlockChainService.sendTransaction(signedTx);

            if (txSendInfo.status == BlockchainResponses.success) {
              setState(() {
                txHash = txSendInfo.data['txHash'];
              });
              print(txSendInfo.data);
            } else {
              print(txSendInfo.data);
            }
          }
        } catch (err) {
          print(err.toString());
        } finally {
          setState(() {
            executingMpcTransaction = false;
          });
        }
      },
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Chain: ",
                    style: nearTextStyles.label?.copyWith(fontSize: 16.sp)),
                SizedBox(width: 20.w),
                DropdownButton<String>(
                  dropdownColor: Colors.white,
                  iconEnabledColor: nearColors.nearPurple,
                  items: BlockChains.supportedBlockChainsForNearMPC
                      .map((blockChain) => DropdownMenuItem<String>(
                          value: blockChain, child: Text(blockChain)))
                      .toList(),
                  value: currentBlockChainForChainSignatureFunctions.isNotEmpty
                      ? currentBlockChainForChainSignatureFunctions
                      : null,
                  onChanged: (model) {
                    setState(() {
                      currentBlockChainForChainSignatureFunctions = model!;
                      mpcAccountInfo = null;
                    });
                    sendToController.clear();
                    amountController.text = "0.01";
                    smartContractFunctionController.clear();
                    smartContractArgumentsController.clear();
                  },
                ),
              ],
            ),
            SizedBox(height: 20.h),
            NearActionTextField(
              labelText: 'MPC Contract',
              textEditingController: mpcContractController,
            ),
            SizedBox(height: 20.h),
            NearActionTextField(
              labelText: 'Derivation Path',
              textEditingController: pathController,
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
                onPressed: () async {
                  setState(() {
                    loadingMpcAccountInfo = true;
                  });
                  final mpcPublicKey =
                      (await nearBlockChainService.callViewMethod(
                              contractId: mpcContractController.text,
                              method: "public_key"))
                          .data['response'];

                  final mpcAccInfo = await nearBlockChainService.getMPCAccount(
                    accountId: accountId!,
                    mpcPublicKey: mpcPublicKey,
                    chain: currentBlockChainForChainSignatureFunctions,
                    path: pathController.text,
                  );
                  setState(() {
                    mpcAccountInfo = mpcAccInfo;
                    loadingMpcAccountInfo = false;
                  });
                },
                child: const Text("Get Account / Update Info")),
            SizedBox(height: 15.h),
            if (loadingMpcAccountInfo)
              const CircularProgressIndicator()
            else ...[
              if (mpcAccountInfo != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: SelectableText(
                            "Adress: ${mpcAccountInfo!.adress}",
                            style:
                                nearTextStyles.label?.copyWith(fontSize: 16.sp),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: FittedBox(
                                    child: QrImageView(
                                      data: mpcAccountInfo!.adress,
                                      version: QrVersions.auto,
                                      size: 200.0,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(Icons.qr_code),
                        )
                      ],
                    ),
                    FutureBuilder(
                      future: Future.delayed(Duration.zero, () async {
                        switch (currentBlockChainForChainSignatureFunctions) {
                          case BlockChains.ethereum:
                            {
                              final EthereumBlockChainService
                                  ethereumBlockChainService =
                                  EthereumBlockChainService.defaultInstance();
                              return ethereumBlockChainService
                                  .getWalletBalance(EvmAccountInfoRequest(
                                accountId: mpcAccountInfo!.adress,
                              ));
                            }
                          case BlockChains.bitcoin:
                            {
                              final BitcoinBlockChainService
                                  bitcoinBlockChainService =
                                  BitcoinBlockChainService.defaultInstance();
                              return bitcoinBlockChainService.bitcoinRpcClient
                                  .getAccountBalanceWithAdress(
                                      mpcAccountInfo!.adress);
                            }
                          case BlockChains.bnb:
                            {
                              final BNBBlockChainService bnbBlockChainService =
                                  BNBBlockChainService.defaultInstance();
                              return bnbBlockChainService
                                  .getWalletBalance(EvmAccountInfoRequest(
                                accountId: mpcAccountInfo!.adress,
                              ));
                            }
                          case BlockChains.aurora:
                            {
                              final AuroraBlockChainService
                                  auroraBlockChainService =
                                  AuroraBlockChainService.defaultInstance();
                              return auroraBlockChainService
                                  .getWalletBalance(EvmAccountInfoRequest(
                                accountId: mpcAccountInfo!.adress,
                              ));
                            }
                          case BlockChains.polygon:
                            {
                              final PolygonBlockChainService
                                  polygonBlockChainService =
                                  PolygonBlockChainService.defaultInstance();
                              return polygonBlockChainService.getWalletBalance(
                                EvmAccountInfoRequest(
                                  accountId: mpcAccountInfo!.adress,
                                ),
                              );
                            }
                          case BlockChains.avalanche:
                            {
                              final AvalancheBlockChainService
                                  avalancheBlockChainService =
                                  AvalancheBlockChainService.defaultInstance();
                              return avalancheBlockChainService
                                  .getWalletBalance(EvmAccountInfoRequest(
                                accountId: mpcAccountInfo!.adress,
                              ));
                            }
                          case BlockChains.xrp:
                            {
                              final XRPBlockChainService xrpBlockChainService =
                                  XRPBlockChainService.defaultInstance();
                              return xrpBlockChainService
                                  .getWalletBalance(XrpAccountInfoRequest(
                                accountId: mpcAccountInfo!.adress,
                              ));
                            }
                          default:
                            {
                              return Future.delayed(
                                  Duration.zero, () => "Unimplemented");
                            }
                        }
                      }),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return const CircularProgressIndicator();
                        }
                        return Text("Balance: ${snapshot.data}");
                      },
                    ),
                    SizedBox(height: 20.h),
                    NearActionTextField(
                      labelText: 'Send to address',
                      textEditingController: sendToController,
                    ),
                    SizedBox(height: 20.h),
                    NearActionTextField(
                      labelText: 'Amount',
                      textEditingController: amountController,
                    ),
                    SizedBox(height: 20.h),
                    if (supportedBlockChainsForEVMContracts.contains(
                        currentBlockChainForChainSignatureFunctions)) ...[
                      Text(
                          "Optional arguments if you want to call a smart contract function:",
                          style:
                              nearTextStyles.label?.copyWith(fontSize: 16.sp)),
                      SizedBox(height: 10.h),
                      const Text(
                          "Format: functionName(typeOfArg1, typeOfArg2, ...)"),
                      SizedBox(height: 5.h),
                      NearActionTextField(
                        labelText: 'Smart Contract Fuction',
                        textEditingController: smartContractFunctionController,
                      ),
                      SizedBox(height: 20.h),
                      const Text("Format: [Arg1, Arg2, ...]"),
                      SizedBox(height: 5.h),
                      NearActionTextField(
                        labelText: 'Smart Contract Arguments',
                        textEditingController: smartContractArgumentsController,
                      ),
                      SizedBox(height: 15.h),
                    ],
                    if (executingMpcTransaction)
                      Row(
                        children: [
                          const Text("Executing MPC Contract"),
                          SizedBox(width: 10.w),
                          const CircularProgressIndicator(),
                        ],
                      ),
                    if (txHash != "") SelectableText("Tx Hash: $txHash"),
                  ],
                )
              ]
            ]
          ],
        ),
      ),
    );
  }
}
