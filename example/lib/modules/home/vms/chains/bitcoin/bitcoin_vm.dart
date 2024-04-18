import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutterchain/flutterchain_lib.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/supported_blockchains.dart';
import 'package:flutterchain/flutterchain_lib/formaters/chains/near_formater.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/bitcoin/bitcoin_transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/near/near_blockchain_smart_contract_arguments.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/near_blockchain_service.dart';
import 'package:flutterchain_example/modules/home/services/helper_service.dart';
import 'package:flutterchain_example/modules/home/stores/chains/bitcoin_blockchain_store.dart';
import 'package:flutterchain_example/modules/home/stores/core/user_store.dart';
import 'package:flutterchain_example/modules/home/vms/chains/bitcoin/ui_state_bitcoin.dart';
import 'package:rxdart/rxdart.dart';

class BitcoinVM {
  final FlutterChainLibrary cryptoLibrary;
  final BitcoinBlockchainStore bitcoinBlockchainStore;
  final NearHelperService bitcoinHelperService;
  final UserStore userStore;
  final BehaviorSubject<BitcoinState> bitcoinState =
      BehaviorSubject<BitcoinState>()..add(SuccessBitcoinBlockchainState());
  BitcoinVM(
    this.cryptoLibrary,
    this.bitcoinBlockchainStore,
    this.bitcoinHelperService,
    this.userStore,
  );

  Future<BlockChainData> addBlockChainDataByDerivationPath({
    required DerivationPath derivationPath,
    required String walletID,
  }) async {
    return cryptoLibrary.addBlockChainDataByDerivationPath(
      derivationPath: derivationPath,
      blockchainType: BlockChains.bitcoin,
      walletID: walletID,
    );
  }

  Future<dynamic> getBalanceByDerivationPath({
    required BitcoinTransferRequest bitcoinTransferRequest,
  }) async =>
      cryptoLibrary.getBalanceOfAddressOnSpecificBlockchain(
          transferRequest: bitcoinTransferRequest);

  Future<String> getWalletPublicKeyAddressByWalletId(
          String walletName, DerivationPath currentDerivationPath) async =>
      cryptoLibrary.walletsStream.value
          .firstWhere((element) => element.name == walletName)
          .blockchainsData?[BlockChains.bitcoin]!
          .firstWhereOrNull(
              (element) => element.derivationPath == currentDerivationPath)
          ?.publicKey ??
      'not founded';

  Future<String> getMnemonicPhraseByWalletName(
    String walletName,
  ) async =>
      cryptoLibrary.walletsStream.value
          .firstWhere((element) => element.name == walletName)
          .mnemonic;

  Future<BlockchainResponse> sendNativeCoinTransferByWalletId({
    required String toAddress,
    required String transferAmount,
    required String walletId,
    required String typeOfBlockchain,
    required DerivationPath currentDerivationPath,
  }) async {
    final response = cryptoLibrary.sendTransferNativeCoin(
      walletId: walletId,
      typeOfBlockchain: typeOfBlockchain,
      toAddress: toAddress,
      currentDerivationPath: currentDerivationPath,
      transferAmount: transferAmount,
    );
    return response;
  }
}
