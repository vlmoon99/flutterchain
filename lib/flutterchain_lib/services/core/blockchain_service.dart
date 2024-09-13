import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';

abstract class BlockChainService {
  Future<BlockChainData> getBlockChainData({
    required String mnemonic,
    String? passphrase,
    DerivationPathData? derivationPath,
  });

  Future<BlockchainResponse> sendTransferNativeCoin(
      TransferRequest transferRequest);

  Future<BlockchainResponse> callSmartContractFunction(
    TransferRequest transferRequest,
  );

  Future<String> getWalletBalance(TransferRequest transferRequest);

  Future<void> setBlockchainNetworkEnvironment({required String newUrl});

  Set<String> getBlockchainsUrlsByBlockchainType();

  Future<String> getBlockchainNetworkEnvironment();
}
