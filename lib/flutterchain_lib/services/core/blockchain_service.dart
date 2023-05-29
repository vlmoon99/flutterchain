import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_smart_contract_arguments.dart';
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
    String publicKey,
  );

  Future<BlockchainResponse> callSmartContractFunction(
    String toAddress,
    String fromAddress,
    String privateKey,
    String publicKey,
    BlockChainSmartContractArguments arguments,
  );

  Future<String> getWalletBalance(String accountId);

  Future<void> setBlockchainNetworkEnvironment({required String newUrl});

  Set<String> getBlockchainsUrlsByBlockchainType();

  Future<BlockChainData> getBlockChainDataByDerivationPath({
    required String mnemonic,
    required String? passphrase,
    required DerivationPath derivationPath,
  });
  Future<String> getBlockchainNetworkEnvironment();
}
