import 'package:flutterchain/flutterchain_lib/models/core/blockchain_smart_contract_arguments.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';

abstract class TransferRequest {
  String? walletId;
  String? blockchainType;
  String? newUrl;
  DerivationPath? derivationPath;
  String? walletName;
  String? mnemonic;
  String? passphrase = '';
  String? toAddress;
  BlockChainSmartContractArguments? arguments;
  String? transferAmount;
  String? privateKey;
  String? publicKey;
  String? fromAddress;

  TransferRequest(
      this.walletId,
      this.blockchainType,
      this.newUrl,
      this.derivationPath,
      this.walletName,
      this.mnemonic,
      this.passphrase,
      this.toAddress,
      this.arguments,
      this.transferAmount,
      this.privateKey,
      this.publicKey,
      this.fromAddress);
}
