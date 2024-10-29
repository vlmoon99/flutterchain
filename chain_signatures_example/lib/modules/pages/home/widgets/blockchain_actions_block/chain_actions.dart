import 'dart:convert';

import 'package:chain_signatures_example/constants/avaliable_blockchains_info.dart';
import 'package:chain_signatures_example/constants/theme.dart';
import 'package:chain_signatures_example/modules/vms/auth_controller.dart';
import 'package:chain_signatures_example/modules/vms/models/auth_info.dart';
import 'package:chain_signatures_example/widgets/custom_loading_indicator.dart';
import 'package:chain_signatures_example/widgets/rounded_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/aurora_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/avalanche_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/bitcoin_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/bnb_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/ethereum_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/polygon_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/constants/chains/xrp_blockchain_network_urls.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/bitcoin/bitcoin_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/evm/evm_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_mpc_account_info.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/xrp/xrp_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/aurora_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/avalanche_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/bitcoin_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/bnb_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/ethereum_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/polygon_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/xrp_blockchain_service.dart';
import 'package:url_launcher/url_launcher.dart';

enum ChainAction { transfer, smartContractCall }

class ChainActions extends StatefulWidget {
  const ChainActions({
    super.key,
    required this.accountInfo,
    required this.chain,
    required this.derivationPath,
  });

  final MPCAccountInfo accountInfo;
  final String chain;
  final String derivationPath;

  @override
  State<ChainActions> createState() => _ChainActionsState();
}

class _ChainActionsState extends State<ChainActions> {
  ChainAction selectedAction = ChainAction.transfer;

  final TextEditingController receiverAddressController =
      TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController smartContractFunctionController =
      TextEditingController();
  final TextEditingController smartContractArgsController =
      TextEditingController();

  bool txSending = false;
  String txSendingStatus = "";

  String txHash = "";

  @override
  void didUpdateWidget(covariant ChainActions oldWidget) {
    if (oldWidget.chain != widget.chain) {
      setState(() {
        selectedAction = ChainAction.transfer;
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  void validator() {
    if (receiverAddressController.text.isEmpty) {
      throw Exception('Receiver address is required');
    }

    if (amountController.text.isEmpty) {
      throw Exception('Amount is required');
    }

    if (selectedAction == ChainAction.smartContractCall) {
      if (smartContractFunctionController.text.isEmpty) {
        throw Exception('Smart contract function is required');
      }
      if (smartContractArgsController.text.isEmpty) {
        throw Exception('Smart contract args is required');
      }
    }
  }

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
  void dispose() {
    receiverAddressController.dispose();
    amountController.dispose();
    smartContractFunctionController.dispose();
    smartContractArgsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Modular.get<AuthController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Action to call: ",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            DropdownButton(
              value: selectedAction,
              borderRadius: BorderRadius.circular(12).r,
              alignment: Alignment.center,
              items: [ChainAction.transfer, ChainAction.smartContractCall]
                  .map(
                    (action) => DropdownMenuItem(
                      value: action,
                      enabled: action == ChainAction.transfer ||
                          AvaliableBlockchainsInfo.evmChains
                              .contains(widget.chain),
                      child: Text(
                        action == ChainAction.transfer
                            ? "Transfer"
                            : "Smart Contract Call",
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: action == ChainAction.transfer ||
                                  AvaliableBlockchainsInfo.evmChains
                                      .contains(widget.chain)
                              ? Theme.of(context).colorScheme.primary
                              : Colors.red,
                          decoration: action == ChainAction.transfer ||
                                  AvaliableBlockchainsInfo.evmChains
                                      .contains(widget.chain)
                              ? TextDecoration.none
                              : TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedAction = value!;
                });
                smartContractFunctionController.clear();
                smartContractArgsController.clear();
              },
            ),
          ],
        ),
        SizedBox(height: 19.h),
        RoundedTextField(
          textEditingController: receiverAddressController,
          labelText: "Receiver address",
          fontSize: 16.sp,
        ),
        SizedBox(height: 14.h),
        RoundedTextField(
          textEditingController: amountController,
          labelText: "Amount",
          fontSize: 16.sp,
        ),
        if (selectedAction == ChainAction.smartContractCall &&
            AvaliableBlockchainsInfo.evmChains.contains(widget.chain)) ...[
          SizedBox(height: 14.h),
          RoundedTextField(
            textEditingController: smartContractFunctionController,
            labelText: "Smart Contract Function",
            fontSize: 16.sp,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10).r,
            child: Text(
              "Format: function1(typeOfArgument1, typeOfArgument2)",
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.greyTextColor,
              ),
            ),
          ),
          SizedBox(height: 14.h),
          RoundedTextField(
            textEditingController: smartContractArgsController,
            labelText: "Smart Contract Args",
            fontSize: 16.sp,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10).r,
            child: Text(
              "Format: [arg1, arg2]",
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.greyTextColor,
              ),
            ),
          ),
        ],
        SizedBox(height: 25.h),
        Align(
          alignment: Alignment.center,
          child: !txSending
              ? FilledButton(
                  onPressed: () async {
                    validator();
                    setState(() {
                      txSending = true;
                    });
                    try {
                      String? smartContractData;
                      if (selectedAction == ChainAction.smartContractCall) {
                        setState(() {
                          txSendingStatus = "Encoding smart contract call...";
                        });

                        smartContractData = await encodeSmartContractArgs(
                          smartContractFunctionController.text,
                          smartContractArgsController.text,
                        );
                      }

                      if (widget.chain == BlockChains.ethereum) {
                        final EthereumBlockChainService
                            ethereumBlockChainService =
                            EthereumBlockChainService.defaultInstance()
                              ..setBlockchainNetworkEnvironment(
                                EvmNetworkEnvironmentSettings(
                                  chainUrl: authController.state.networkType ==
                                          NearNetworkType.testnet
                                      ? EthereumBlockChainNetworkUrls
                                          .listOfUrls.first
                                      : EthereumBlockChainNetworkUrls
                                          .listOfUrls.last,
                                ),
                              );

                        setState(() {
                          txSendingStatus =
                              "Getting transaction creation info...";
                        });

                        final transactionInfo =
                            await ethereumBlockChainService.getTransactionInfo(
                          from: widget.accountInfo.address,
                          to: receiverAddressController.text,
                          data: smartContractData,
                          amountInEth: double.parse(amountController.text),
                        );

                        setState(() {
                          txSendingStatus = "Creating transaction";
                        });

                        final unsignedTx = await ethereumBlockChainService
                            .createPayloadForNearMPC(
                          receiverAddress: receiverAddressController.text,
                          amount: double.parse(amountController.text),
                          transactionInfo: transactionInfo,
                          smartContractCallEncoded: smartContractData,
                        );

                        setState(() {
                          txSendingStatus =
                              "Signing transaction with Near MPC...";
                        });

                        final signedTX = await context
                            .read<NearBlockChainService>()
                            .signEVMTransactionWithMPC(
                              accountId: authController.state.accountId,
                              publicKey: authController.state.publicKey,
                              privateKey: authController.state.privateKey,
                              mpcTransactionInfo: unsignedTx,
                              senderAddress: widget.accountInfo.address,
                              path: widget.derivationPath,
                            );

                        setState(() {
                          txSendingStatus = "Sending transaction...";
                        });

                        final txSendInfo = await ethereumBlockChainService
                            .sendTransaction(signedTX);

                        if (txSendInfo.status == BlockchainResponses.success) {
                          setState(() {
                            txHash = txSendInfo.data['txHash'];
                          });
                        } else {
                          throw Exception(txSendInfo.data);
                        }
                      } else if (widget.chain == BlockChains.bitcoin) {
                        final BitcoinBlockChainService
                            bitcoinBlockChainService =
                            BitcoinBlockChainService.defaultInstance()
                              ..setBlockchainNetworkEnvironment(
                                BitcoinNetworkEnvironmentSettings(
                                  chainUrl: authController.state.networkType ==
                                          NearNetworkType.testnet
                                      ? BitcoinBlockChainNetworkUrls
                                          .listOfUrls.first
                                      : BitcoinBlockChainNetworkUrls
                                          .listOfUrls.last,
                                ),
                              );

                        setState(() {
                          txSendingStatus = "Creating transaction";
                        });

                        final unsignedTransaction =
                            await bitcoinBlockChainService
                                .createPayloadForNearMPC(
                          senderAddress: widget.accountInfo.address,
                          receiverAddress: receiverAddressController.text,
                          amountOfBTC: amountController.text,
                        );

                        setState(() {
                          txSendingStatus =
                              "Signing transaction with Near MPC...";
                        });

                        final signedTx = await context
                            .read<NearBlockChainService>()
                            .signBTCTransactionWithMPC(
                              accountId: authController.state.accountId,
                              publicKey: authController.state.publicKey,
                              privateKey: authController.state.privateKey,
                              mpcSenderPublicKey: widget.accountInfo.publicKey,
                              transactionInfo: unsignedTransaction,
                            );

                        setState(() {
                          txSendingStatus = "Sending transaction...";
                        });

                        final txSendInfo = await bitcoinBlockChainService
                            .sendTransaction(signedTx);

                        if (txSendInfo.status == BlockchainResponses.success) {
                          setState(() {
                            txHash = txSendInfo.data['data']['tx']['hash'];
                          });
                        } else {
                          throw Exception(txSendInfo.data);
                        }
                      } else if (widget.chain == BlockChains.bnb) {
                        final BNBBlockChainService bnbBlockChainService =
                            BNBBlockChainService.defaultInstance()
                              ..setBlockchainNetworkEnvironment(
                                EvmNetworkEnvironmentSettings(
                                  chainUrl: authController.state.networkType ==
                                          NearNetworkType.testnet
                                      ? BNBBlockChainNetworkUrls
                                          .listOfUrls.first
                                      : BNBBlockChainNetworkUrls
                                          .listOfUrls.last,
                                ),
                              );

                        setState(() {
                          txSendingStatus =
                              "Getting transaction creation info...";
                        });

                        final transactionInfo =
                            await bnbBlockChainService.getTransactionInfo(
                          from: widget.accountInfo.address,
                          to: receiverAddressController.text,
                          amountInEth: double.parse(amountController.text),
                          data: smartContractData,
                        );

                        setState(() {
                          txSendingStatus = "Creating transaction";
                        });

                        final unsignedTx =
                            await bnbBlockChainService.createPayloadForNearMPC(
                          transactionInfo: transactionInfo,
                          receiverAddress: receiverAddressController.text,
                          amount: double.parse(amountController.text),
                          smartContractCallEncoded: smartContractData,
                        );

                        setState(() {
                          txSendingStatus =
                              "Signing transaction with Near MPC...";
                        });

                        final signedTx = await context
                            .read<NearBlockChainService>()
                            .signEVMTransactionWithMPC(
                              accountId: authController.state.accountId,
                              publicKey: authController.state.publicKey,
                              privateKey: authController.state.privateKey,
                              mpcTransactionInfo: unsignedTx,
                              senderAddress: widget.accountInfo.address,
                            );

                        setState(() {
                          txSendingStatus = "Sending transaction...";
                        });

                        final txSendInfo = await bnbBlockChainService
                            .sendTransaction(signedTx);
                        if (txSendInfo.status == BlockchainResponses.success) {
                          setState(() {
                            txHash = txSendInfo.data['txHash'];
                          });
                        } else {
                          throw Exception(txSendInfo.data);
                        }
                      } else if (widget.chain == BlockChains.aurora) {
                        final AuroraBlockChainService auroraBlockChainService =
                            AuroraBlockChainService.defaultInstance()
                              ..setBlockchainNetworkEnvironment(
                                EvmNetworkEnvironmentSettings(
                                  chainUrl: authController.state.networkType ==
                                          NearNetworkType.testnet
                                      ? AuroraBlockChainNetworkUrls
                                          .listOfUrls.first
                                      : AuroraBlockChainNetworkUrls
                                          .listOfUrls.last,
                                ),
                              );

                        setState(() {
                          txSendingStatus =
                              "Getting transaction creation info...";
                        });

                        final transactionInfo =
                            await auroraBlockChainService.getTransactionInfo(
                          from: widget.accountInfo.address,
                          to: receiverAddressController.text,
                          amountInEth: double.parse(amountController.text),
                          data: smartContractData,
                        );

                        setState(() {
                          txSendingStatus = "Creating transaction";
                        });

                        final unsignedTx = await auroraBlockChainService
                            .createPayloadForNearMPC(
                          transactionInfo: transactionInfo,
                          receiverAddress: receiverAddressController.text,
                          amount: double.parse(amountController.text),
                          smartContractCallEncoded: smartContractData,
                        );

                        setState(() {
                          txSendingStatus =
                              "Signing transaction with Near MPC...";
                        });

                        final signedTx = await context
                            .read<NearBlockChainService>()
                            .signEVMTransactionWithMPC(
                              accountId: authController.state.accountId,
                              publicKey: authController.state.publicKey,
                              privateKey: authController.state.privateKey,
                              mpcTransactionInfo: unsignedTx,
                              senderAddress: widget.accountInfo.address,
                            );

                        setState(() {
                          txSendingStatus = "Sending transaction...";
                        });

                        final txSendInfo = await auroraBlockChainService
                            .sendTransaction(signedTx);
                        if (txSendInfo.status == BlockchainResponses.success) {
                          setState(() {
                            txHash = txSendInfo.data['txHash'];
                          });
                        } else {
                          throw Exception(txSendInfo.data);
                        }
                      } else if (widget.chain == BlockChains.polygon) {
                        final PolygonBlockChainService
                            polygonBlockChainService =
                            PolygonBlockChainService.defaultInstance()
                              ..setBlockchainNetworkEnvironment(
                                EvmNetworkEnvironmentSettings(
                                  chainUrl: authController.state.networkType ==
                                          NearNetworkType.testnet
                                      ? PolygonBlockChainNetworkUrls
                                          .listOfUrls.first
                                      : PolygonBlockChainNetworkUrls
                                          .listOfUrls.last,
                                ),
                              );

                        setState(() {
                          txSendingStatus =
                              "Getting transaction creation info...";
                        });

                        final transactionInfo =
                            await polygonBlockChainService.getTransactionInfo(
                          from: widget.accountInfo.address,
                          to: receiverAddressController.text,
                          amountInMatic: double.parse(amountController.text),
                          data: smartContractData,
                        );

                        setState(() {
                          txSendingStatus = "Creating transaction";
                        });

                        final unsignedTx = await polygonBlockChainService
                            .createPayloadForNearMPC(
                          transactionInfo: transactionInfo,
                          receiverAddress: receiverAddressController.text,
                          amount: double.parse(amountController.text),
                          smartContractCallEncoded: smartContractData,
                        );

                        setState(() {
                          txSendingStatus =
                              "Signing transaction with Near MPC...";
                        });

                        final signedTx = await context
                            .read<NearBlockChainService>()
                            .signEVMTransactionWithMPC(
                              accountId: authController.state.accountId,
                              publicKey: authController.state.publicKey,
                              privateKey: authController.state.privateKey,
                              mpcTransactionInfo: unsignedTx,
                              senderAddress: widget.accountInfo.address,
                            );

                        setState(() {
                          txSendingStatus = "Sending transaction...";
                        });

                        final txSendInfo = await polygonBlockChainService
                            .sendTransaction(signedTx);
                        if (txSendInfo.status == BlockchainResponses.success) {
                          setState(() {
                            txHash = txSendInfo.data['txHash'];
                          });
                        } else {
                          throw Exception(txSendInfo.data);
                        }
                      } else if (widget.chain == BlockChains.avalanche) {
                        final AvalancheBlockChainService
                            avalancheBlockChainService =
                            AvalancheBlockChainService.defaultInstance()
                              ..setBlockchainNetworkEnvironment(
                                EvmNetworkEnvironmentSettings(
                                  chainUrl: authController.state.networkType ==
                                          NearNetworkType.testnet
                                      ? AvalancheBlockChainNetworkUrls
                                          .listOfUrls.first
                                      : AvalancheBlockChainNetworkUrls
                                          .listOfUrls.last,
                                ),
                              );

                        setState(() {
                          txSendingStatus =
                              "Getting transaction creation info...";
                        });

                        final transactionInfo =
                            await avalancheBlockChainService.getTransactionInfo(
                          from: widget.accountInfo.address,
                          to: receiverAddressController.text,
                          amountInAvax: double.parse(amountController.text),
                          data: smartContractData,
                        );

                        setState(() {
                          txSendingStatus = "Creating transaction";
                        });

                        final unsignedTx = await avalancheBlockChainService
                            .createPayloadForNearMPC(
                          transactionInfo: transactionInfo,
                          receiverAddress: receiverAddressController.text,
                          amount: double.parse(amountController.text),
                          smartContractCallEncoded: smartContractData,
                        );

                        setState(() {
                          txSendingStatus =
                              "Signing transaction with Near MPC...";
                        });

                        final signedTx = await context
                            .read<NearBlockChainService>()
                            .signEVMTransactionWithMPC(
                              accountId: authController.state.accountId,
                              publicKey: authController.state.publicKey,
                              privateKey: authController.state.privateKey,
                              mpcTransactionInfo: unsignedTx,
                              senderAddress: widget.accountInfo.address,
                            );

                        setState(() {
                          txSendingStatus = "Sending transaction...";
                        });

                        final txSendInfo = await avalancheBlockChainService
                            .sendTransaction(signedTx);
                        if (txSendInfo.status == BlockchainResponses.success) {
                          setState(() {
                            txHash = txSendInfo.data['txHash'];
                          });
                        } else {
                          throw Exception(txSendInfo.data);
                        }
                      } else if (widget.chain == BlockChains.xrp) {
                        final XRPBlockChainService xrpBlockChainService =
                            XRPBlockChainService.defaultInstance()
                              ..setBlockchainNetworkEnvironment(
                                XrpNetworkEnvironmentSettings(
                                  chainUrl: authController.state.networkType ==
                                          NearNetworkType.testnet
                                      ? XRPBlockChainNetworkUrls
                                          .listOfUrls.first
                                      : XRPBlockChainNetworkUrls
                                          .listOfUrls.last,
                                ),
                              );
                        setState(() {
                          txSendingStatus =
                              "Getting transaction creation info...";
                        });

                        final txInfo =
                            await xrpBlockChainService.getTransactionInfo(
                          senderAddress: widget.accountInfo.address,
                        );

                        setState(() {
                          txSendingStatus = "Creating transaction";
                        });

                        final mpcTransactionInfo =
                            await xrpBlockChainService.createPayloadForNearMPC(
                          mpcAccountInfo: widget.accountInfo,
                          receiverAddress: receiverAddressController.text
                              .replaceAll(" ", ""),
                          amount: double.parse(amountController.text),
                          transactionInfo: txInfo,
                        );

                        setState(() {
                          txSendingStatus =
                              "Signing transaction with Near MPC...";
                        });

                        final signedTx = await context
                            .read<NearBlockChainService>()
                            .signXRPTransactionWithMPC(
                              accountId: authController.state.accountId,
                              publicKey: authController.state.publicKey,
                              privateKey: authController.state.privateKey,
                              mpcTransactionInfo: mpcTransactionInfo,
                            );

                        setState(() {
                          txSendingStatus = "Sending transaction...";
                        });

                        final txSendInfo = await xrpBlockChainService
                            .sendTransaction(signedTx);

                        if (txSendInfo.status == BlockchainResponses.success) {
                          setState(() {
                            txHash = txSendInfo.data['txHash'];
                          });
                        } else {
                          throw Exception(txSendInfo.data);
                        }
                      }
                    } catch (err) {
                      rethrow;
                    } finally {
                      setState(() {
                        txSending = false;
                        txSendingStatus = "";
                      });
                    }
                  },
                  child: Text(
                    "Sign and send transaction",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomLoadingIndicator(),
                    SizedBox(height: 17.h),
                    Text(
                      txSendingStatus,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.greyTextColor,
                      ),
                    ),
                  ],
                ),
        ),
        if (txHash.isNotEmpty) ...[
          SizedBox(height: 19.h),
          SelectableText.rich(
            TextSpan(
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.greyTextColor,
              ),
              text: "Tx hash: ",
              children: [
                TextSpan(
                  text: txHash,
                  style: const TextStyle(color: AppColors.black),
                ),
              ],
            ),
          ),
          SizedBox(height: 19.h),
          Align(
            alignment: Alignment.center,
            child: FilledButton(
              onPressed: () async {
                launchUrl(
                  Uri.parse(
                    AvaliableBlockchainsInfo.getExplorerUrlToTx(
                      blockchainType: widget.chain,
                      txHash: txHash,
                      networkType: authController.state.networkType ==
                              NearNetworkType.testnet
                          ? "testnet"
                          : "mainnet",
                    ),
                  ),
                );
              },
              child: Text(
                "View on explorer",
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
          )
        ]
      ],
    );
  }
}
