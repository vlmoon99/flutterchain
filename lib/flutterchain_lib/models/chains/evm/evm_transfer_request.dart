import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_smart_contract_arguments.dart';
import 'package:flutterchain/flutterchain_lib/models/core/transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';

class EVMTransferRequest implements TransferRequest {
  @override
  BlockChainSmartContractArguments? arguments;

  @override
  String blockchainType = BlockChains.bitcoin;

  @override
  DerivationPath? derivationPath;

  @override
  DerivationPath? currentDerivationPath;

  @override
  String? fromAddress;

  @override
  String? mnemonic;

  @override
  String? newUrl;

  @override
  String? passphrase;

  @override
  String? privateKey;

  @override
  String? publicKey;

  @override
  String? toAddress;

  @override
  String? transferAmount;

  @override
  String? walletId;

  @override
  String? walletName;

  @override
  String? accountID;


  EVMTransferRequest({
    this.arguments,
    this.derivationPath,
    this.currentDerivationPath,
    this.fromAddress,
    this.mnemonic,
    this.newUrl,
    this.passphrase,
    this.privateKey,
    this.publicKey,
    this.toAddress,
    this.transferAmount,
    this.walletId,
    this.walletName,
    this.accountID,
  }) {
    this.blockchainType = blockchainType;
  }
}
