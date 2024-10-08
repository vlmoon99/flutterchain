import 'package:flutterchain/flutterchain_lib/models/core/account_info_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_smart_contract_arguments.dart';
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

  Future<String> getWalletBalance(AccountInfoRequest accountInfoRequest);

  Future<void> setBlockchainNetworkEnvironment(
    BlockChainNetworkEnvironmentSettings blockChainNetworkEnvironmentSettings,
  );

  Set<String> getBlockchainsUrlsByBlockchainType();

  Future<BlockChainNetworkEnvironmentSettings>
      getBlockchainNetworkEnvironment();
}

abstract class BlockchainServiceWithSmartContractCallSupport
    extends BlockChainService {
  Future<BlockchainResponse> callSmartContractFunction(
    BlockChainSmartContractArguments smartContractArguments,
  );
}
