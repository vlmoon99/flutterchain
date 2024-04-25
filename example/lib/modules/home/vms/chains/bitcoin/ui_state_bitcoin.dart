class SuccessBitcoinBlockchainState extends BitcoinState {
  final dynamic blockchainsDataCreatedByDerivationPath;
  final dynamic creatingBitcoinAccount;
  final dynamic addKeyResult;
  final dynamic deleteKeyResult;
  final dynamic transferResult;
  final dynamic adressID;

  SuccessBitcoinBlockchainState({
    this.blockchainsDataCreatedByDerivationPath,
    this.creatingBitcoinAccount,
    this.addKeyResult,
    this.deleteKeyResult,
    this.transferResult,
    this.adressID,
  });

  SuccessBitcoinBlockchainState copyWith({
    dynamic blockchainsDataCreatedByDerivationPath,
    dynamic creatingBitcoinAccount,
    dynamic addKeyResult,
    dynamic deleteKeyResult,
    dynamic transferResult,
    dynamic adressID,
  }) {
    return SuccessBitcoinBlockchainState(
      blockchainsDataCreatedByDerivationPath:
          blockchainsDataCreatedByDerivationPath ??
              this.blockchainsDataCreatedByDerivationPath,
      creatingBitcoinAccount:
          creatingBitcoinAccount ?? this.creatingBitcoinAccount,
      addKeyResult: addKeyResult ?? this.addKeyResult,
      deleteKeyResult: deleteKeyResult ?? this.deleteKeyResult,
      transferResult: transferResult ?? this.transferResult,
      adressID: adressID ?? this.adressID,
    );
  }
}

class ErrorBitcoinBlockchainState extends BitcoinState {
  final String message;

  ErrorBitcoinBlockchainState({required this.message});
}

class BitcoinState {}
