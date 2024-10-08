// Mocks generated by Mockito 5.4.4 from annotations
// in flutterchain/test/unit/services/concordium_blockchain_service_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i11;

import 'package:flutter/material.dart' as _i14;
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_account_info.dart'
    as _i8;
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_derivation_path.dart'
    as _i15;
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/create_identity_request_params.dart'
    as _i5;
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/identity_info.dart'
    as _i6;
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/identity_provider.dart'
    as _i13;
import 'package:flutterchain/flutterchain_lib/models/core/account_info_request.dart'
    as _i16;
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_network_environment_settings.dart'
    as _i4;
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart'
    as _i7;
import 'package:flutterchain/flutterchain_lib/models/core/transfer_request.dart'
    as _i17;
import 'package:flutterchain/flutterchain_lib/models/core/wallet.dart' as _i9;
import 'package:flutterchain/flutterchain_lib/network/chains/concordium_grpc/concordium_rpc_client.dart'
    as _i3;
import 'package:flutterchain/flutterchain_lib/services/chains/concordium_blockchain_service.dart'
    as _i10;
import 'package:flutterchain/flutterchain_lib/services/core/js_engines/core/js_vm.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i12;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeJsVMService_0 extends _i1.SmartFake implements _i2.JsVMService {
  _FakeJsVMService_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeConcordiumRpcClient_1 extends _i1.SmartFake
    implements _i3.ConcordiumRpcClient {
  _FakeConcordiumRpcClient_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeBlockChainNetworkEnvironmentSettings_2 extends _i1.SmartFake
    implements _i4.BlockChainNetworkEnvironmentSettings {
  _FakeBlockChainNetworkEnvironmentSettings_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCreateIdentityRequestParams_3 extends _i1.SmartFake
    implements _i5.CreateIdentityRequestParams {
  _FakeCreateIdentityRequestParams_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeIdentityInfo_4 extends _i1.SmartFake implements _i6.IdentityInfo {
  _FakeIdentityInfo_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeBlockchainResponse_5 extends _i1.SmartFake
    implements _i7.BlockchainResponse {
  _FakeBlockchainResponse_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeConcordiumAccountInfo_6 extends _i1.SmartFake
    implements _i8.ConcordiumAccountInfo {
  _FakeConcordiumAccountInfo_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeBlockChainData_7 extends _i1.SmartFake
    implements _i9.BlockChainData {
  _FakeBlockChainData_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [ConcordiumBlockChainService].
///
/// See the documentation for Mockito's code generation for more information.
class MockConcordiumBlockChainService extends _i1.Mock
    implements _i10.ConcordiumBlockChainService {
  MockConcordiumBlockChainService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.JsVMService get jsVMService => (super.noSuchMethod(
        Invocation.getter(#jsVMService),
        returnValue: _FakeJsVMService_0(
          this,
          Invocation.getter(#jsVMService),
        ),
      ) as _i2.JsVMService);

  @override
  _i3.ConcordiumRpcClient get concordiumRpcClient => (super.noSuchMethod(
        Invocation.getter(#concordiumRpcClient),
        returnValue: _FakeConcordiumRpcClient_1(
          this,
          Invocation.getter(#concordiumRpcClient),
        ),
      ) as _i3.ConcordiumRpcClient);

  @override
  set concordiumRpcClient(_i3.ConcordiumRpcClient? _concordiumRpcClient) =>
      super.noSuchMethod(
        Invocation.setter(
          #concordiumRpcClient,
          _concordiumRpcClient,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i11.Future<void> setBlockchainNetworkEnvironment(
          _i4.BlockChainNetworkEnvironmentSettings?
              blockChainNetworkEnvironmentSettings) =>
      (super.noSuchMethod(
        Invocation.method(
          #setBlockchainNetworkEnvironment,
          [blockChainNetworkEnvironmentSettings],
        ),
        returnValue: _i11.Future<void>.value(),
        returnValueForMissingStub: _i11.Future<void>.value(),
      ) as _i11.Future<void>);

  @override
  _i11.Future<_i4.BlockChainNetworkEnvironmentSettings>
      getBlockchainNetworkEnvironment() => (super.noSuchMethod(
            Invocation.method(
              #getBlockchainNetworkEnvironment,
              [],
            ),
            returnValue:
                _i11.Future<_i4.BlockChainNetworkEnvironmentSettings>.value(
                    _FakeBlockChainNetworkEnvironmentSettings_2(
              this,
              Invocation.method(
                #getBlockchainNetworkEnvironment,
                [],
              ),
            )),
          ) as _i11.Future<_i4.BlockChainNetworkEnvironmentSettings>);

  @override
  Set<String> getBlockchainsUrlsByBlockchainType() => (super.noSuchMethod(
        Invocation.method(
          #getBlockchainsUrlsByBlockchainType,
          [],
        ),
        returnValue: <String>{},
      ) as Set<String>);

  @override
  _i11.Future<String> generateMnemonic({int? strength = 128}) =>
      (super.noSuchMethod(
        Invocation.method(
          #generateMnemonic,
          [],
          {#strength: strength},
        ),
        returnValue: _i11.Future<String>.value(_i12.dummyValue<String>(
          this,
          Invocation.method(
            #generateMnemonic,
            [],
            {#strength: strength},
          ),
        )),
      ) as _i11.Future<String>);

  @override
  _i11.Future<List<_i13.IdentityProvider>> getIdentityProviders() =>
      (super.noSuchMethod(
        Invocation.method(
          #getIdentityProviders,
          [],
        ),
        returnValue: _i11.Future<List<_i13.IdentityProvider>>.value(
            <_i13.IdentityProvider>[]),
      ) as _i11.Future<List<_i13.IdentityProvider>>);

  @override
  _i11.Future<_i5.CreateIdentityRequestParams> getCreateIdentityRequestParams({
    required String? mnemonic,
    required _i13.IdentityProvider? identityProvider,
    int? identityIndex = 0,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCreateIdentityRequestParams,
          [],
          {
            #mnemonic: mnemonic,
            #identityProvider: identityProvider,
            #identityIndex: identityIndex,
          },
        ),
        returnValue: _i11.Future<_i5.CreateIdentityRequestParams>.value(
            _FakeCreateIdentityRequestParams_3(
          this,
          Invocation.method(
            #getCreateIdentityRequestParams,
            [],
            {
              #mnemonic: mnemonic,
              #identityProvider: identityProvider,
              #identityIndex: identityIndex,
            },
          ),
        )),
      ) as _i11.Future<_i5.CreateIdentityRequestParams>);

  @override
  _i11.Future<String> getIdentityCreateRequestUrl({
    required _i13.IdentityProvider? identityProvider,
    required _i5.CreateIdentityRequestParams? createIdentityRequestParams,
    String? redirectUrlToReturnForWeb,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getIdentityCreateRequestUrl,
          [],
          {
            #identityProvider: identityProvider,
            #createIdentityRequestParams: createIdentityRequestParams,
            #redirectUrlToReturnForWeb: redirectUrlToReturnForWeb,
          },
        ),
        returnValue: _i11.Future<String>.value(_i12.dummyValue<String>(
          this,
          Invocation.method(
            #getIdentityCreateRequestUrl,
            [],
            {
              #identityProvider: identityProvider,
              #createIdentityRequestParams: createIdentityRequestParams,
              #redirectUrlToReturnForWeb: redirectUrlToReturnForWeb,
            },
          ),
        )),
      ) as _i11.Future<String>);

  @override
  _i11.Future<String?> createIdentityDialog({
    required _i14.BuildContext? context,
    required String? creationUrl,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #createIdentityDialog,
          [],
          {
            #context: context,
            #creationUrl: creationUrl,
          },
        ),
        returnValue: _i11.Future<String?>.value(),
      ) as _i11.Future<String?>);

  @override
  _i11.Future<_i6.IdentityInfo> getIdentityInfo(String? url) =>
      (super.noSuchMethod(
        Invocation.method(
          #getIdentityInfo,
          [url],
        ),
        returnValue: _i11.Future<_i6.IdentityInfo>.value(_FakeIdentityInfo_4(
          this,
          Invocation.method(
            #getIdentityInfo,
            [url],
          ),
        )),
      ) as _i11.Future<_i6.IdentityInfo>);

  @override
  _i11.Future<_i6.IdentityInfo> recoverExistingIdentity({
    required String? mnemonic,
    required _i13.IdentityProvider? identityProvider,
    int? identityIndex = 0,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #recoverExistingIdentity,
          [],
          {
            #mnemonic: mnemonic,
            #identityProvider: identityProvider,
            #identityIndex: identityIndex,
          },
        ),
        returnValue: _i11.Future<_i6.IdentityInfo>.value(_FakeIdentityInfo_4(
          this,
          Invocation.method(
            #recoverExistingIdentity,
            [],
            {
              #mnemonic: mnemonic,
              #identityProvider: identityProvider,
              #identityIndex: identityIndex,
            },
          ),
        )),
      ) as _i11.Future<_i6.IdentityInfo>);

  @override
  _i11.Future<_i7.BlockchainResponse> createAccount({
    required String? mnemonic,
    required _i15.ConcordiumDerivationPath? derivationPath,
    required _i6.IdentityInfo? identityInfo,
    required _i13.IdentityProvider? identityProviderInfo,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #createAccount,
          [],
          {
            #mnemonic: mnemonic,
            #derivationPath: derivationPath,
            #identityInfo: identityInfo,
            #identityProviderInfo: identityProviderInfo,
          },
        ),
        returnValue:
            _i11.Future<_i7.BlockchainResponse>.value(_FakeBlockchainResponse_5(
          this,
          Invocation.method(
            #createAccount,
            [],
            {
              #mnemonic: mnemonic,
              #derivationPath: derivationPath,
              #identityInfo: identityInfo,
              #identityProviderInfo: identityProviderInfo,
            },
          ),
        )),
      ) as _i11.Future<_i7.BlockchainResponse>);

  @override
  _i11.Future<_i8.ConcordiumAccountInfo> getAccountInfo(
          _i16.AccountInfoRequest? accountInfoRequest) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAccountInfo,
          [accountInfoRequest],
        ),
        returnValue: _i11.Future<_i8.ConcordiumAccountInfo>.value(
            _FakeConcordiumAccountInfo_6(
          this,
          Invocation.method(
            #getAccountInfo,
            [accountInfoRequest],
          ),
        )),
      ) as _i11.Future<_i8.ConcordiumAccountInfo>);

  @override
  _i11.Future<String> getWalletBalance(
          _i16.AccountInfoRequest? accountInfoRequest) =>
      (super.noSuchMethod(
        Invocation.method(
          #getWalletBalance,
          [accountInfoRequest],
        ),
        returnValue: _i11.Future<String>.value(_i12.dummyValue<String>(
          this,
          Invocation.method(
            #getWalletBalance,
            [accountInfoRequest],
          ),
        )),
      ) as _i11.Future<String>);

  @override
  _i11.Future<String> getAccountAddressFromMnemonic({
    required String? mnemonic,
    required _i15.ConcordiumDerivationPath? derivationPath,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAccountAddressFromMnemonic,
          [],
          {
            #mnemonic: mnemonic,
            #derivationPath: derivationPath,
          },
        ),
        returnValue: _i11.Future<String>.value(_i12.dummyValue<String>(
          this,
          Invocation.method(
            #getAccountAddressFromMnemonic,
            [],
            {
              #mnemonic: mnemonic,
              #derivationPath: derivationPath,
            },
          ),
        )),
      ) as _i11.Future<String>);

  @override
  _i11.Future<String> getAccountPrivateKey({
    required String? mnemonic,
    required _i15.ConcordiumDerivationPath? derivationPath,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAccountPrivateKey,
          [],
          {
            #mnemonic: mnemonic,
            #derivationPath: derivationPath,
          },
        ),
        returnValue: _i11.Future<String>.value(_i12.dummyValue<String>(
          this,
          Invocation.method(
            #getAccountPrivateKey,
            [],
            {
              #mnemonic: mnemonic,
              #derivationPath: derivationPath,
            },
          ),
        )),
      ) as _i11.Future<String>);

  @override
  _i11.Future<String> getAccountPublicKey({
    required String? mnemonic,
    required _i15.ConcordiumDerivationPath? derivationPath,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getAccountPublicKey,
          [],
          {
            #mnemonic: mnemonic,
            #derivationPath: derivationPath,
          },
        ),
        returnValue: _i11.Future<String>.value(_i12.dummyValue<String>(
          this,
          Invocation.method(
            #getAccountPublicKey,
            [],
            {
              #mnemonic: mnemonic,
              #derivationPath: derivationPath,
            },
          ),
        )),
      ) as _i11.Future<String>);

  @override
  _i11.Future<_i7.BlockchainResponse> getTransactionStatus(
          {required String? transactionHash}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getTransactionStatus,
          [],
          {#transactionHash: transactionHash},
        ),
        returnValue:
            _i11.Future<_i7.BlockchainResponse>.value(_FakeBlockchainResponse_5(
          this,
          Invocation.method(
            #getTransactionStatus,
            [],
            {#transactionHash: transactionHash},
          ),
        )),
      ) as _i11.Future<_i7.BlockchainResponse>);

  @override
  _i11.Future<_i9.BlockChainData> getBlockChainData({
    required String? mnemonic,
    String? passphrase,
    _i9.DerivationPathData? derivationPath,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #getBlockChainData,
          [],
          {
            #mnemonic: mnemonic,
            #passphrase: passphrase,
            #derivationPath: derivationPath,
          },
        ),
        returnValue:
            _i11.Future<_i9.BlockChainData>.value(_FakeBlockChainData_7(
          this,
          Invocation.method(
            #getBlockChainData,
            [],
            {
              #mnemonic: mnemonic,
              #passphrase: passphrase,
              #derivationPath: derivationPath,
            },
          ),
        )),
      ) as _i11.Future<_i9.BlockChainData>);

  @override
  _i11.Future<_i7.BlockchainResponse> sendTransferNativeCoin(
          _i17.TransferRequest? transferRequest) =>
      (super.noSuchMethod(
        Invocation.method(
          #sendTransferNativeCoin,
          [transferRequest],
        ),
        returnValue:
            _i11.Future<_i7.BlockchainResponse>.value(_FakeBlockchainResponse_5(
          this,
          Invocation.method(
            #sendTransferNativeCoin,
            [transferRequest],
          ),
        )),
      ) as _i11.Future<_i7.BlockchainResponse>);

  @override
  _i11.Future<_i7.BlockchainResponse> sendDelegationTransaction({
    required String? senderAddress,
    required String? privateKey,
    int? amountInMicroCcd,
    bool? restakeEarnings,
    String? delegationType,
    String? bakerId,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #sendDelegationTransaction,
          [],
          {
            #senderAddress: senderAddress,
            #privateKey: privateKey,
            #amountInMicroCcd: amountInMicroCcd,
            #restakeEarnings: restakeEarnings,
            #delegationType: delegationType,
            #bakerId: bakerId,
          },
        ),
        returnValue:
            _i11.Future<_i7.BlockchainResponse>.value(_FakeBlockchainResponse_5(
          this,
          Invocation.method(
            #sendDelegationTransaction,
            [],
            {
              #senderAddress: senderAddress,
              #privateKey: privateKey,
              #amountInMicroCcd: amountInMicroCcd,
              #restakeEarnings: restakeEarnings,
              #delegationType: delegationType,
              #bakerId: bakerId,
            },
          ),
        )),
      ) as _i11.Future<_i7.BlockchainResponse>);

  @override
  _i11.Future<_i7.BlockchainResponse> sendBakerTransaction({
    required String? senderAddress,
    required String? privateKey,
    int? stakeAmountInMicroCcd,
    bool? restakeEarnings,
    _i10.DelegationOpenStatus? openStatus,
    String? metadataUrl,
    double? transactionFeeCommissionInPercentage,
    double? bakingRewardCommissionInPercentage,
    double? finalizationRewardCommissionInPercentage,
    Map<String, dynamic>? bakerKeys = const {},
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #sendBakerTransaction,
          [],
          {
            #senderAddress: senderAddress,
            #privateKey: privateKey,
            #stakeAmountInMicroCcd: stakeAmountInMicroCcd,
            #restakeEarnings: restakeEarnings,
            #openStatus: openStatus,
            #metadataUrl: metadataUrl,
            #transactionFeeCommissionInPercentage:
                transactionFeeCommissionInPercentage,
            #bakingRewardCommissionInPercentage:
                bakingRewardCommissionInPercentage,
            #finalizationRewardCommissionInPercentage:
                finalizationRewardCommissionInPercentage,
            #bakerKeys: bakerKeys,
          },
        ),
        returnValue:
            _i11.Future<_i7.BlockchainResponse>.value(_FakeBlockchainResponse_5(
          this,
          Invocation.method(
            #sendBakerTransaction,
            [],
            {
              #senderAddress: senderAddress,
              #privateKey: privateKey,
              #stakeAmountInMicroCcd: stakeAmountInMicroCcd,
              #restakeEarnings: restakeEarnings,
              #openStatus: openStatus,
              #metadataUrl: metadataUrl,
              #transactionFeeCommissionInPercentage:
                  transactionFeeCommissionInPercentage,
              #bakingRewardCommissionInPercentage:
                  bakingRewardCommissionInPercentage,
              #finalizationRewardCommissionInPercentage:
                  finalizationRewardCommissionInPercentage,
              #bakerKeys: bakerKeys,
            },
          ),
        )),
      ) as _i11.Future<_i7.BlockchainResponse>);
}
