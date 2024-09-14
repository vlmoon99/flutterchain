import 'package:chain_signatures_example/constants/avaliable_blockchains_info.dart';
import 'package:chain_signatures_example/constants/theme.dart';
import 'package:chain_signatures_example/modules/vms/auth_controller.dart';
import 'package:chain_signatures_example/modules/vms/models/auth_info.dart';
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
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/bitcoin/bitcoin_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/evm/evm_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/evm/evm_transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/xrp/xrp_transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/aurora_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/avalanche_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/bitcoin_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/bnb_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/ethereum_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/polygon_blockchain_service.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/xrp_blockchain_service.dart';

class ChainBalanceInfo extends StatefulWidget {
  const ChainBalanceInfo({
    super.key,
    required this.chain,
    required this.chainAddress,
  });

  final String chainAddress;
  final String chain;

  @override
  State<ChainBalanceInfo> createState() => _ChainBalanceInfoState();
}

class _ChainBalanceInfoState extends State<ChainBalanceInfo>
    with SingleTickerProviderStateMixin {
  late final AnimationController balanceAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 600),
  );

  double? balance;

  Future<void> updateBalance(String accountId) async {
    final currentNetwork = context.read<AuthController>().state.networkType;
    try {
      balanceAnimationController.repeat();
      late final String balanceInString;

      switch (widget.chain) {
        case BlockChains.ethereum:
          {
            final EthereumBlockChainService ethereumBlockChainService =
                EthereumBlockChainService.defaultInstance()
                  ..setBlockchainNetworkEnvironment(
                    EvmNetworkEnvironmentSettings(
                      chainUrl: currentNetwork == NearNetworkType.testnet
                          ? EthereumBlockChainNetworkUrls.listOfUrls.first
                          : EthereumBlockChainNetworkUrls.listOfUrls.last,
                    ),
                  );
            balanceInString = await ethereumBlockChainService
                .getWalletBalance(EVMTransferRequest(
              accountID: widget.chainAddress,
            ));
          }
        case BlockChains.bitcoin:
          {
            final BitcoinBlockChainService bitcoinBlockChainService =
                BitcoinBlockChainService.defaultInstance()
                  ..setBlockchainNetworkEnvironment(
                      BitcoinNetworkEnvironmentSettings(
                    chainUrl: currentNetwork == NearNetworkType.testnet
                        ? BitcoinBlockChainNetworkUrls.listOfUrls.first
                        : BitcoinBlockChainNetworkUrls.listOfUrls.last,
                  ));
            balanceInString = await bitcoinBlockChainService.bitcoinRpcClient
                .getAccountBalanceWithAdress(widget.chainAddress);
          }
        case BlockChains.bnb:
          {
            final BNBBlockChainService bnbBlockChainService =
                BNBBlockChainService.defaultInstance()
                  ..setBlockchainNetworkEnvironment(
                    EvmNetworkEnvironmentSettings(
                      chainUrl: currentNetwork == NearNetworkType.testnet
                          ? BNBBlockChainNetworkUrls.listOfUrls.first
                          : BNBBlockChainNetworkUrls.listOfUrls.last,
                    ),
                  );
            balanceInString =
                await bnbBlockChainService.getWalletBalance(EVMTransferRequest(
              accountID: widget.chainAddress,
            ));
          }
        case BlockChains.aurora:
          {
            final AuroraBlockChainService auroraBlockChainService =
                AuroraBlockChainService.defaultInstance()
                  ..setBlockchainNetworkEnvironment(
                    EvmNetworkEnvironmentSettings(
                      chainUrl: currentNetwork == NearNetworkType.testnet
                          ? AuroraBlockChainNetworkUrls.listOfUrls.first
                          : AuroraBlockChainNetworkUrls.listOfUrls.last,
                    ),
                  );
            balanceInString = await auroraBlockChainService.getWalletBalance(
              EVMTransferRequest(
                accountID: widget.chainAddress,
              ),
            );
          }
        case BlockChains.polygon:
          {
            final PolygonBlockChainService polygonBlockChainService =
                PolygonBlockChainService.defaultInstance()
                  ..setBlockchainNetworkEnvironment(
                    EvmNetworkEnvironmentSettings(
                      chainUrl: currentNetwork == NearNetworkType.testnet
                          ? PolygonBlockChainNetworkUrls.listOfUrls.first
                          : PolygonBlockChainNetworkUrls.listOfUrls.last,
                    ),
                  );
            balanceInString = await polygonBlockChainService.getWalletBalance(
              EVMTransferRequest(
                accountID: widget.chainAddress,
              ),
            );
          }
        case BlockChains.avalanche:
          {
            final AvalancheBlockChainService avalancheBlockChainService =
                AvalancheBlockChainService.defaultInstance()
                  ..setBlockchainNetworkEnvironment(
                    EvmNetworkEnvironmentSettings(
                      chainUrl: currentNetwork == NearNetworkType.testnet
                          ? AvalancheBlockChainNetworkUrls.listOfUrls.first
                          : AvalancheBlockChainNetworkUrls.listOfUrls.last,
                    ),
                  );
            balanceInString = await avalancheBlockChainService
                .getWalletBalance(EVMTransferRequest(
              accountID: widget.chainAddress,
            ));
          }
        case BlockChains.xrp:
          {
            final XRPBlockChainService xrpBlockChainService =
                XRPBlockChainService.defaultInstance()
                  ..setBlockchainNetworkEnvironment(
                    EvmNetworkEnvironmentSettings(
                      chainUrl: currentNetwork == NearNetworkType.testnet
                          ? XRPBlockChainNetworkUrls.listOfUrls.first
                          : XRPBlockChainNetworkUrls.listOfUrls.last,
                    ),
                  );
            balanceInString =
                await xrpBlockChainService.getWalletBalance(XRPTransferRequest(
              accountID: widget.chainAddress,
            ));
          }
        default:
          {
            throw Exception("Incorrect chain: ${widget.chain}");
          }
      }
      if (!mounted) return;
      setState(() {
        balance = double.parse(balanceInString);
      });
    } catch (err) {
      rethrow;
    } finally {
      balanceAnimationController.fling();
    }
  }

  @override
  void didUpdateWidget(covariant ChainBalanceInfo oldWidget) {
    if (oldWidget.chain != widget.chain) {
      Future.delayed(const Duration(milliseconds: 500), () {
        updateBalance(widget.chainAddress);
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    balanceAnimationController.stop();
    balanceAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (balance == null) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) async {
          await updateBalance(widget.chainAddress);
        },
      );
    }
    return Column(
      children: [
        Text(
          "Balance",
          style: TextStyle(fontSize: 16.sp, color: AppColors.greyTextColor),
        ),
        SizedBox(height: 4.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                balance != null
                    ? "$balance ${AvaliableBlockchainsInfo.chainsCurrencyNames[widget.chain]}"
                    : "Loading...",
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                if (balanceAnimationController.isAnimating) {
                  return;
                }
                await updateBalance(widget.chainAddress);
              },
              icon: RotationTransition(
                turns: balanceAnimationController,
                child: const Icon(
                  Icons.refresh,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
