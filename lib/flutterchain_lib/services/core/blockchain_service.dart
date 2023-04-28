import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';

abstract class BlockChainService {
  Future<BlockChainData> getBlockChainDataFromMnemonic(
    String mnemonic,
    String passphrase,
  );

  Future<BlockchainResponse> sendTransferNativeCoin(
    String toAdress,
    String fromAdress,
    String transferAmount,
    String privateKey,
  );

  Future<BlockchainResponse> callSmartContractFunction(
    String toAdress,
    String fromAdress,
    String transferAmount,
    String privateKey,
    String methodName,
    Map<String, dynamic> arguments,
  );

  Future<String> getWalletBalance(String accountId);

  Future<void> setBlockchainNetworkEnvironment({required String newUrl});

  Set<String> getBlockchainsUrlsByBlockchainType();

  Future<BlockChainData> getBlockChainDataByDerivationPath({
    required String mnemonic,
    required String? passphrase,
    required String derivationPath,
  });
}
