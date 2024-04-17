import 'package:flutterchain/flutterchain_lib/models/core/blockchain_smart_contract_arguments.dart';
import 'package:flutterchain/flutterchain_lib/models/core/transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';

class NearTransferRequest implements TransferRequest {
  @override
  BlockChainSmartContractArguments? arguments;

  @override
  String? blockchainType;

  @override
  DerivationPath? derivationPath;

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

  NearTransferRequest(
      this.arguments,
      this.blockchainType,
      this.derivationPath,
      this.fromAddress,
      this.mnemonic,
      this.newUrl,
      this.passphrase,
      this.privateKey,
      this.publicKey,
      this.toAddress,
      this.transferAmount,
      this.walletId,
      this.walletName);
}
