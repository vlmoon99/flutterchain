import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';

abstract class BlockChainService {
  Future<BlockChainData> getBlockChainDataFromMnemonic(
    String mnemonic,
    String passphrase,
  );

  Future<dynamic> sendTransferNativeCoin(
    String toAdress,
    String fromAdress,
    String transferAmount,
    String privateKey,
  );

  Future<dynamic> callSmartContractFunction(
    String toAdress,
    String fromAdress,
    String transferAmount,
    String privateKey,
    String methodName,
    Map<String, dynamic> arguments,
  );

  Future<String> getWalletBalance(String accountId);

  Future<void> setBlockchainNetworkEnvironment({required String newUrl});
}
