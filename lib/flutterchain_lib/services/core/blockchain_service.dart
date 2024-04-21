import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_smart_contract_arguments.dart';
import 'package:flutterchain/flutterchain_lib/models/core/transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';

abstract class BlockChainService {
  Future<BlockChainData> getBlockChainDataFromMnemonic(
    String mnemonic,
    String passphrase,
  );

  Future<BlockchainResponse> sendTransferNativeCoin(
      TransferRequest transferRequest);

  Future<BlockchainResponse> callSmartContractFunction(
    TransferRequest transferRequest,
  );

  Future<String> getWalletBalance(TransferRequest transferRequest);

  Future<void> setBlockchainNetworkEnvironment({required String newUrl});

  Set<String> getBlockchainsUrlsByBlockchainType();

  Future<BlockChainData> getBlockChainDataByDerivationPath({
    required String mnemonic,
    required String? passphrase,
    required DerivationPath derivationPath,
  });
  Future<String> getBlockchainNetworkEnvironment();
}
