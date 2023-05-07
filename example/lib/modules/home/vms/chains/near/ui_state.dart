class SuccessNearBlockchainState extends NearState {
  final dynamic resultOfSmartContractCall;
  final dynamic blockchainsDataCreatedByDerivationPath;
  final dynamic exportSecretKeyToTheNearApiJsFormat;
  final dynamic creatingNearAccount;
  final dynamic addKeyResult;
  final dynamic deleteKeyResult;
  final dynamic transferResult;

  SuccessNearBlockchainState({
    this.resultOfSmartContractCall,
    this.blockchainsDataCreatedByDerivationPath,
    this.exportSecretKeyToTheNearApiJsFormat,
    this.creatingNearAccount,
    this.addKeyResult,
    this.deleteKeyResult,
    this.transferResult,
  });

  SuccessNearBlockchainState copyWith({
    dynamic resultOfSmartContractCall,
    dynamic blockchainsDataCreatedByDerivationPath,
    dynamic exportSecretKeyToTheNearApiJsFormat,
    dynamic creatingNearAccount,
    dynamic addKeyResult,
    dynamic deleteKeyResult,
    dynamic transferResult,
  }) {
    return SuccessNearBlockchainState(
      resultOfSmartContractCall:
          resultOfSmartContractCall ?? this.resultOfSmartContractCall,
      blockchainsDataCreatedByDerivationPath:
          blockchainsDataCreatedByDerivationPath ??
              this.blockchainsDataCreatedByDerivationPath,
      exportSecretKeyToTheNearApiJsFormat:
          exportSecretKeyToTheNearApiJsFormat ??
              this.exportSecretKeyToTheNearApiJsFormat,
      creatingNearAccount: creatingNearAccount ?? this.creatingNearAccount,
      addKeyResult: addKeyResult ?? this.addKeyResult,
      deleteKeyResult: deleteKeyResult ?? this.deleteKeyResult,
      transferResult: transferResult ?? this.transferResult,
    );
  }
}

class ErrorNearBlockchainState extends NearState {
  final String message;

  ErrorNearBlockchainState({required this.message});
}

class NearState {}
