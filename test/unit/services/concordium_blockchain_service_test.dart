import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_account_info.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_account_info_request.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_blockchain_data.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_derivation_path.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_network_environment_settings.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_network_type.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_transfer_request.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/create_identity_request_params.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/identity_info.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/identity_provider.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/concordium_blockchain_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'concordium_blockchain_service_test.mocks.dart';

@GenerateMocks([
  ConcordiumBlockChainService,
])
void main() {
  group("Unit tests for Concordium Blockchain Service'", () {
    final service = MockConcordiumBlockChainService();
    test("getBlockchainNetworkEnvironment", () async {
      const mockBaseUrl = "concordium-rpc-endpoint.com";
      const mockPort = 20000;
      const mockTypeOfNetwork = ConcordiumNetwork.testnet;

      when(service.getBlockchainNetworkEnvironment()).thenAnswer(
        (_) async => ConcordiumNetworkEnvironmentSettings(
          baseUrl: mockBaseUrl,
          port: mockPort,
          typeOfNetwork: mockTypeOfNetwork,
        ),
      );
      final res = await service.getBlockchainNetworkEnvironment();

      expect(
        res,
        ConcordiumNetworkEnvironmentSettings(
          baseUrl: mockBaseUrl,
          port: mockPort,
          typeOfNetwork: mockTypeOfNetwork,
        ),
      );
    });
    test(
      "setBlockchainNetworkEnvironment",
      () async {
        final networkEnvSettings = ConcordiumNetworkEnvironmentSettings(
          baseUrl: "concordium-rpc-endpoint.com",
          port: 20000,
          typeOfNetwork: ConcordiumNetwork.testnet,
        );

        await service.setBlockchainNetworkEnvironment(networkEnvSettings);

        when(service.getBlockchainNetworkEnvironment()).thenAnswer(
          (_) async => networkEnvSettings,
        );

        final currentNetworkEnvSettings =
            await service.getBlockchainNetworkEnvironment();

        expect(currentNetworkEnvSettings, networkEnvSettings);
      },
    );
    test(
      "generateMnemonic",
      () async {
        const expectedMnemonic =
            "bar engine black trophy task wheel soccer chicken mom rotate noodle later";

        when(service.generateMnemonic(strength: 128)).thenAnswer(
          (_) async =>
              "bar engine black trophy task wheel soccer chicken mom rotate noodle later",
        );
        final mnemonic = await service.generateMnemonic(strength: 128);
        expect(mnemonic, expectedMnemonic);
      },
    );
    test(
      "getIdentityProviders",
      () async {
        final identityProvider = IdentityProvider(
          arsInfos: {
            "1": {
              "arDescription": {
                "description": "Testnet anonymity revoker",
                "name": "Testnet AR 1",
                "url": ""
              },
              "arIdentity": 1,
              "arPublicKey": "some_arPublicKey"
            },
            "2": {
              "arDescription": {
                "description": "Testnet anonymity revoker 2",
                "name": "Testnet AR 2",
                "url": ""
              },
              "arIdentity": 2,
              "arPublicKey": "some_arPublicKey"
            },
            "3": {
              "arDescription": {
                "description": "Testnet anonymity revoker 3",
                "name": "Testnet AR 3",
                "url": ""
              },
              "arIdentity": 3,
              "arPublicKey": "some_arPublicKey"
            }
          },
          ipInfo: {
            "ipCdiVerifyKey": "some_ipCdiVerifyKey",
            "ipDescription": {
              "description": "Concordium testnet identity provider",
              "name": "Concordium testnet IP",
              "url": ""
            },
            "ipIdentity": 0,
            "ipVerifyKey": "some_ipVerifyKey"
          },
          metadata: {
            "icon": "image_in_base64",
            "issuanceStart":
                "https://id-service.testnet.concordium.com/api/v1/identity",
            "recoveryStart":
                "https://id-service.testnet.concordium.com/api/v1/recover",
            "support": "support@concordium.software"
          },
        );

        when(service.getIdentityProviders()).thenAnswer(
          (_) async => [identityProvider],
        );

        final identityProviders = await service.getIdentityProviders();

        expect(identityProviders.first.ipInfo["ipDescription"]["name"],
            "Concordium testnet IP");
      },
    );
    test(
      "getCreateIdentityRequestParams",
      () async {
        final someIdentityProvider = IdentityProvider(
          arsInfos: {
            "1": {
              "arDescription": {
                "description": "Testnet anonymity revoker",
                "name": "Testnet AR 1",
                "url": ""
              },
              "arIdentity": 1,
              "arPublicKey": "some_arPublicKey"
            },
            "2": {
              "arDescription": {
                "description": "Testnet anonymity revoker 2",
                "name": "Testnet AR 2",
                "url": ""
              },
              "arIdentity": 2,
              "arPublicKey": "some_arPublicKey"
            },
            "3": {
              "arDescription": {
                "description": "Testnet anonymity revoker 3",
                "name": "Testnet AR 3",
                "url": ""
              },
              "arIdentity": 3,
              "arPublicKey": "some_arPublicKey"
            }
          },
          ipInfo: {
            "ipCdiVerifyKey": "some_ipCdiVerifyKey",
            "ipDescription": {
              "description": "Concordium testnet identity provider",
              "name": "Concordium testnet IP",
              "url": ""
            },
            "ipIdentity": 0,
            "ipVerifyKey": "some_ipVerifyKey"
          },
          metadata: {
            "icon": "image_in_base64",
            "issuanceStart":
                "https://id-service.testnet.concordium.com/api/v1/identity",
            "recoveryStart":
                "https://id-service.testnet.concordium.com/api/v1/recover",
            "support": "support@concordium.software"
          },
        );
        const someMnemonic =
            "bar engine black trophy task wheel soccer chicken mom rotate noodle later";

        final createIdentityRequestParams =
            CreateIdentityRequestParams(v: 0, value: {
          "choiceArData": {
            "arIdentities": [1, 2, 3],
            "threshold": 2
          },
          "idCredPub": "some_idCredPub",
          "idCredSecCommitment": "some_idCredSecCommitment",
          "ipArData": {
            "1": {
              "encPrfKeyShare": "some_encPrfKeyShare",
              "proofComEncEq": "some_proofComEncEq"
            },
            "2": {
              "encPrfKeyShare": "some_encPrfKeyShare",
              "proofComEncEq": "some_proofComEncEq"
            },
            "3": {
              "encPrfKeyShare": "some_encPrfKeyShare",
              "proofComEncEq": "some_proofComEncEq"
            }
          },
          "prfKeyCommitmentWithIP": "some_prfKeyCommitmentWithIP",
          "prfKeySharingCoeffCommitments": [
            "prfKeySharingCoeffCommitment_1",
            "prfKeySharingCoeffCommitment_2"
          ],
          "proofsOfKnowledge": "some_proofsOfKnowledge"
        });

        when(service.getCreateIdentityRequestParams(
          identityProvider: anyNamed('identityProvider'),
          mnemonic: anyNamed('mnemonic'),
          identityIndex: anyNamed('identityIndex'),
        )).thenAnswer((_) async => createIdentityRequestParams);

        final requestParams = await service.getCreateIdentityRequestParams(
          mnemonic: someMnemonic,
          identityProvider: someIdentityProvider,
          identityIndex: 0,
        );

        expect(requestParams.value["idCredPub"], "some_idCredPub");
      },
    );
    test("getIdentityCreateRequestUrl", () async {
      final identityProvider = IdentityProvider(
        arsInfos: {
          "1": {
            "arDescription": {
              "description": "Testnet anonymity revoker",
              "name": "Testnet AR 1",
              "url": ""
            },
            "arIdentity": 1,
            "arPublicKey": "some_arPublicKey"
          },
          "2": {
            "arDescription": {
              "description": "Testnet anonymity revoker 2",
              "name": "Testnet AR 2",
              "url": ""
            },
            "arIdentity": 2,
            "arPublicKey": "some_arPublicKey"
          },
          "3": {
            "arDescription": {
              "description": "Testnet anonymity revoker 3",
              "name": "Testnet AR 3",
              "url": ""
            },
            "arIdentity": 3,
            "arPublicKey": "some_arPublicKey"
          }
        },
        ipInfo: {
          "ipCdiVerifyKey": "some_ipCdiVerifyKey",
          "ipDescription": {
            "description": "Concordium testnet identity provider",
            "name": "Concordium testnet IP",
            "url": ""
          },
          "ipIdentity": 0,
          "ipVerifyKey": "some_ipVerifyKey"
        },
        metadata: {
          "icon": "image_in_base64",
          "issuanceStart":
              "https://id-service.testnet.concordium.com/api/v1/identity",
          "recoveryStart":
              "https://id-service.testnet.concordium.com/api/v1/recover",
          "support": "support@concordium.software"
        },
      );

      final createIdentityRequestParams =
          CreateIdentityRequestParams(v: 0, value: {
        "choiceArData": {
          "arIdentities": [1, 2, 3],
          "threshold": 2
        },
        "idCredPub": "some_idCredPub",
        "idCredSecCommitment": "some_idCredSecCommitment",
        "ipArData": {
          "1": {
            "encPrfKeyShare": "some_encPrfKeyShare",
            "proofComEncEq": "some_proofComEncEq"
          },
          "2": {
            "encPrfKeyShare": "some_encPrfKeyShare",
            "proofComEncEq": "some_proofComEncEq"
          },
          "3": {
            "encPrfKeyShare": "some_encPrfKeyShare",
            "proofComEncEq": "some_proofComEncEq"
          }
        },
        "prfKeyCommitmentWithIP": "some_prfKeyCommitmentWithIP",
        "prfKeySharingCoeffCommitments": [
          "prfKeySharingCoeffCommitment_1",
          "prfKeySharingCoeffCommitment_2"
        ],
        "proofsOfKnowledge": "some_proofsOfKnowledge"
      });

      const expectedUrl = "url_to_register_identity";

      when(service.getIdentityCreateRequestUrl(
        identityProvider: anyNamed("identityProvider"),
        createIdentityRequestParams: anyNamed("createIdentityRequestParams"),
      )).thenAnswer((_) async => "url_to_register_identity");

      final url = await service.getIdentityCreateRequestUrl(
        identityProvider: identityProvider,
        createIdentityRequestParams: createIdentityRequestParams,
      );

      expect(url, expectedUrl);
    });
    test(
      "createIdentityDialog",
      () async {
        const urlToGetIdentityInfo = "url_to_get_identity_info";

        when(service.createIdentityDialog(
          context: anyNamed("context"),
          creationUrl: urlToGetIdentityInfo,
        )).thenAnswer((_) async => urlToGetIdentityInfo);

        final url = await service.createIdentityDialog(
          context: MockBuildContext(),
          creationUrl: urlToGetIdentityInfo,
        );

        expect(url, urlToGetIdentityInfo);
      },
    );
    test("getIdentityInfo", () async {
      final identityInfo = IdentityInfo(
        attributeList: {
          "chosenAttributes": {
            "countryOfResidence": "DK",
            "dob": "19700101",
            "firstName": "John",
            "idDocExpiresAt": "20300101",
            "idDocIssuedAt": "20200101",
            "idDocIssuer": "DK",
            "idDocNo": "12345",
            "idDocType": "1",
            "lastName": "Doe",
            "nationalIdNo": "N-1234",
            "nationality": "DK",
            "sex": "0",
            "taxIdNo": "T-1234"
          },
          "createdAt": "202409",
          "maxAccounts": 200,
          "validTo": "202509"
        },
        preIdentityObject: {
          "choiceArData": {
            "arIdentities": [1, 2, 3],
            "threshold": 2
          },
          "idCredPub": "some_idCredPub",
          "idCredSecCommitment": "some_idCredSecCommitment",
          "ipArData": {
            "1": {
              "encPrfKeyShare": "some_encPrfKeyShare",
              "proofComEncEq": "some_proofComEncEq"
            },
            "2": {
              "encPrfKeyShare": "some_encPrfKeyShare",
              "proofComEncEq": "some_proofComEncEq"
            },
            "3": {
              "encPrfKeyShare": "some_encPrfKeyShare",
              "proofComEncEq": "some_proofComEncEq"
            }
          },
          "prfKeyCommitmentWithIP": "some_prfKeyCommitmentWithIP",
          "prfKeySharingCoeffCommitments": [
            "prfKeySharingCoeffCommitment_1",
            "prfKeySharingCoeffCommitment_2"
          ],
          "proofsOfKnowledge": "some_proofsOfKnowledge"
        },
        signature: "some_signature",
      );

      const urlToGetIdentityInfo = "url_to_get_identity_info";

      when(service.getIdentityInfo(
        any,
      )).thenAnswer((_) async => identityInfo);

      final identity = await service.getIdentityInfo(
        urlToGetIdentityInfo,
      );

      expect(identity.attributeList["chosenAttributes"]["firstName"], "John");
    });
    test(
      "createAccount",
      () async {
        final expectedBlockchainResponse = BlockchainResponse(
          status: "received",
          data: {
            "txHash": "some_txHash",
            "accountAddress": "your_account_address",
          },
        );

        final identityProvider = IdentityProvider(
          arsInfos: {
            "1": {
              "arDescription": {
                "description": "Testnet anonymity revoker",
                "name": "Testnet AR 1",
                "url": ""
              },
              "arIdentity": 1,
              "arPublicKey": "some_arPublicKey"
            },
            "2": {
              "arDescription": {
                "description": "Testnet anonymity revoker 2",
                "name": "Testnet AR 2",
                "url": ""
              },
              "arIdentity": 2,
              "arPublicKey": "some_arPublicKey"
            },
            "3": {
              "arDescription": {
                "description": "Testnet anonymity revoker 3",
                "name": "Testnet AR 3",
                "url": ""
              },
              "arIdentity": 3,
              "arPublicKey": "some_arPublicKey"
            }
          },
          ipInfo: {
            "ipCdiVerifyKey": "some_ipCdiVerifyKey",
            "ipDescription": {
              "description": "Concordium testnet identity provider",
              "name": "Concordium testnet IP",
              "url": ""
            },
            "ipIdentity": 0,
            "ipVerifyKey": "some_ipVerifyKey"
          },
          metadata: {
            "icon": "image_in_base64",
            "issuanceStart":
                "https://id-service.testnet.concordium.com/api/v1/identity",
            "recoveryStart":
                "https://id-service.testnet.concordium.com/api/v1/recover",
            "support": "support@concordium.software"
          },
        );

        final identityInfo = IdentityInfo(
          attributeList: {
            "chosenAttributes": {
              "countryOfResidence": "DK",
              "dob": "19700101",
              "firstName": "John",
              "idDocExpiresAt": "20300101",
              "idDocIssuedAt": "20200101",
              "idDocIssuer": "DK",
              "idDocNo": "12345",
              "idDocType": "1",
              "lastName": "Doe",
              "nationalIdNo": "N-1234",
              "nationality": "DK",
              "sex": "0",
              "taxIdNo": "T-1234"
            },
            "createdAt": "202409",
            "maxAccounts": 200,
            "validTo": "202509"
          },
          preIdentityObject: {
            "choiceArData": {
              "arIdentities": [1, 2, 3],
              "threshold": 2
            },
            "idCredPub": "some_idCredPub",
            "idCredSecCommitment": "some_idCredSecCommitment",
            "ipArData": {
              "1": {
                "encPrfKeyShare": "some_encPrfKeyShare",
                "proofComEncEq": "some_proofComEncEq"
              },
              "2": {
                "encPrfKeyShare": "some_encPrfKeyShare",
                "proofComEncEq": "some_proofComEncEq"
              },
              "3": {
                "encPrfKeyShare": "some_encPrfKeyShare",
                "proofComEncEq": "some_proofComEncEq"
              }
            },
            "prfKeyCommitmentWithIP": "some_prfKeyCommitmentWithIP",
            "prfKeySharingCoeffCommitments": [
              "prfKeySharingCoeffCommitment_1",
              "prfKeySharingCoeffCommitment_2"
            ],
            "proofsOfKnowledge": "some_proofsOfKnowledge"
          },
          signature: "some_signature",
        );

        when(service.createAccount(
          mnemonic: anyNamed("mnemonic"),
          derivationPath: anyNamed("derivationPath"),
          identityInfo: anyNamed("identityInfo"),
          identityProviderInfo: anyNamed("identityProviderInfo"),
        )).thenAnswer((_) async => expectedBlockchainResponse);

        final response = await service.createAccount(
          mnemonic: "some_mnemonic",
          derivationPath: ConcordiumDerivationPath(identityProviderIndex: 0),
          identityInfo: identityInfo,
          identityProviderInfo: identityProvider,
        );

        expect(response.status, "received");
        expect(response.data["accountAddress"], "your_account_address");
      },
    );
    test("getTransactionStatus", () async {
      final expectedBlockchainResponse =
          BlockchainResponse(status: "finalized", data: {
        "energyCost": {
          "value": "54100",
        }
      });

      when(service.getTransactionStatus(
        transactionHash: anyNamed("transactionHash"),
      )).thenAnswer((_) async => expectedBlockchainResponse);

      final response = await service.getTransactionStatus(
        transactionHash: "some_transaction_hash",
      );

      expect(response.status, "finalized");
      expect(response.data["energyCost"]["value"], "54100");
    });
    test("getAccountInfo", () async {
      final expectedAccountInfo = ConcordiumAccountInfo(
        type: "simple",
        accountAddress: "some_account_address",
        accountNonce: 1,
        accountAmount: "20000000000",
        accountIndex: 11111,
        accountThreshold: 1,
        accountEncryptionKey: "some_accountEncryptionKey",
        accountEncryptedAmount: {
          "selfAmount":
              "c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
          "startIndex": 0,
          "incomingAmounts": [],
        },
        accountReleaseSchedule: {"total": "0", "schedule": []},
        accountCredentials: {
          "0": {
            "v": 0,
            "value": {
              "type": "normal",
              "contents": {
                "ipIdentity": 0,
                "credentialPublicKeys": {
                  "threshold": 1,
                  "keys": {
                    "0": {
                      "schemeId": "Ed25519",
                      "verifyKey": "some_verifyKey",
                    }
                  }
                },
                "policy": {
                  "validTo": "202509",
                  "createdAt": "202409",
                  "revealedAttributes": {}
                },
                "credId": "some_credId",
                "revocationThreshold": 2,
                "arData": {
                  "1": {"encIdCredPubShare": "some_encIdCredPubShare"},
                  "2": {"encIdCredPubShare": "some_encIdCredPubShare"},
                  "3": {"encIdCredPubShare": "some_encIdCredPubShare"}
                },
                "commitments": {
                  "cmmPrf": "some_cmmPrf",
                  "cmmCredCounter": "some_cmmCredCounter",
                  "cmmIdCredSecSharingCoeff": [
                    "cmmIdCredSecSharingCoeff1",
                    "cmmIdCredSecSharingCoeff2"
                  ],
                  "cmmAttributes": {
                    "firstName": "cmn_firstName",
                    "lastName": "cmn_lastName",
                    "sex": "cmn_sex",
                    "dob": "cmn_dob",
                    "countryOfResidence": "cmn_countryOfResidence",
                    "nationality": "cmn_nationality",
                    "idDocType": "cmn_idDocType",
                    "idDocNo": "cmn_idDocNo",
                    "idDocIssuer": "cmn_idDocIssuer",
                    "idDocIssuedAt": "cmn_idDocIssuedAt",
                    "idDocExpiresAt": "cmn_idDocExpiresAt",
                    "nationalIdNo": "cmn_nationalIdNo",
                    "taxIdNo": "cmn_taxIdNo"
                  },
                  "cmmMaxAccounts": "cmmMaxAccounts",
                }
              }
            }
          }
        },
      );

      when(service.getAccountInfo(any))
          .thenAnswer((_) async => expectedAccountInfo);

      final response = await service.getAccountInfo(
        ConcordiumAccountInfoRequest(
          accountAddress: "accountAddress",
        ),
      );

      expect(response.type, "simple");
      expect(response.accountAddress, "some_account_address");
      expect(response.accountNonce, 1);
      expect(response.accountAmount, "20000000000");
    });
    test("getWalletBalance", () async {
      const expectedWalletBalance = "20000000000";

      when(service.getWalletBalance(any))
          .thenAnswer((_) async => expectedWalletBalance);

      final response = await service.getWalletBalance(
        ConcordiumAccountInfoRequest(
          accountAddress: "accountAddress",
        ),
      );

      expect(response, expectedWalletBalance);
    });
    test("getAccountAddressFromMnemonic", () async {
      const identityProviderIndex = 0;
      final derivationPath = ConcordiumDerivationPath(
        identityProviderIndex: identityProviderIndex,
        credentialIndex: 0,
        identityIndex: 0,
      );
      const someMnemonic = "mnemonic_phrase";

      when(service.getAccountAddressFromMnemonic(
              mnemonic: anyNamed('mnemonic'),
              derivationPath: anyNamed('derivationPath')))
          .thenAnswer((_) async => "your_account_address");

      final response = await service.getAccountAddressFromMnemonic(
        mnemonic: someMnemonic,
        derivationPath: derivationPath,
      );

      expect(response, "your_account_address");
    });
    test("getAccountPublicKeyFromMnemonic", () async {
      const identityProviderIndex = 0;
      final derivationPath = ConcordiumDerivationPath(
        identityProviderIndex: identityProviderIndex,
        credentialIndex: 0,
        identityIndex: 0,
      );
      const someMnemonic = "mnemonic_phrase";

      when(service.getAccountPublicKey(
              mnemonic: anyNamed('mnemonic'),
              derivationPath: anyNamed('derivationPath')))
          .thenAnswer((_) async => "some_account_public_key");

      final response = await service.getAccountPublicKey(
        mnemonic: someMnemonic,
        derivationPath: derivationPath,
      );

      expect(response, "some_account_public_key");
    });
    test("getAccountPublicKey", () async {
      const identityProviderIndex = 0;
      final derivationPath = ConcordiumDerivationPath(
        identityProviderIndex: identityProviderIndex,
        credentialIndex: 0,
        identityIndex: 0,
      );
      const someMnemonic = "mnemonic_phrase";

      when(service.getAccountPublicKey(
              mnemonic: anyNamed('mnemonic'),
              derivationPath: anyNamed('derivationPath')))
          .thenAnswer((_) async => "some_account_public_key");

      final response = await service.getAccountPublicKey(
        mnemonic: someMnemonic,
        derivationPath: derivationPath,
      );

      expect(response, "some_account_public_key");
    });
    test("getBlockChainData", () async {
      const someMnemonic = "mnemonic_phrase";
      final someDerivationPath = ConcordiumDerivationPath(
        identityProviderIndex: 0,
        credentialIndex: 0,
        identityIndex: 0,
      );

      final expectedBlockChainData = ConcordiumBlockChainData(
        accountAddress: "some_account_address",
        publicKey: "some_public_key",
        privateKey: "some_private_key",
        derivationPath: someDerivationPath,
      );

      when(service.getBlockChainData(
              mnemonic: anyNamed('mnemonic'),
              derivationPath: anyNamed('derivationPath')))
          .thenAnswer((_) async => expectedBlockChainData);

      final response = await service.getBlockChainData(
        mnemonic: someMnemonic,
        derivationPath: someDerivationPath,
      );

      expect(response, expectedBlockChainData);
    });
    test("sendTransferNativeCoin", () async {
      const senderAddress = "your_address";
      const toAddress = "receiver_address";
      const transferAmountInMicroCcd = 1000000000;
      const privateKey = "your_private_key";

      final expectedBlockchainResponse = BlockchainResponse(
        status: "received",
        data: {
          "txHash": "some_tx_hash",
        },
      );

      when(service.sendTransferNativeCoin(any))
          .thenAnswer((_) async => expectedBlockchainResponse);

      final response = await service.sendTransferNativeCoin(
        ConcordiumTransferRequest(
          senderAddress: senderAddress,
          toAddress: toAddress,
          transferAmountInMicroCcd: transferAmountInMicroCcd,
          privateKey: privateKey,
        ),
      );

      expect(response, expectedBlockchainResponse);
    });
    test("sendDelegationTransaction", () async {
      const senderAddress = "your_address";
      const transferAmountInMicroCcd = 1000000000;
      const privateKey = "your_private_key";

      when(service.sendDelegationTransaction(
        privateKey: anyNamed('privateKey'),
        senderAddress: anyNamed('senderAddress'),
        delegationType: ConcordiumDelegationType.passive,
        amountInMicroCcd: anyNamed('amountInMicroCcd'),
        restakeEarnings: anyNamed('restakeEarnings'),
      )).thenAnswer(
        (_) async => BlockchainResponse(
          status: "received",
          data: {
            "txHash": "some_tx_hash",
          },
        ),
      );

      final responseForPassiveType = await service.sendDelegationTransaction(
        senderAddress: senderAddress,
        privateKey: privateKey,
        amountInMicroCcd: transferAmountInMicroCcd,
        restakeEarnings: true,
        delegationType: ConcordiumDelegationType.passive,
      );

      when(service.sendDelegationTransaction(
        privateKey: anyNamed('privateKey'),
        senderAddress: anyNamed('senderAddress'),
        delegationType: ConcordiumDelegationType.baker,
        amountInMicroCcd: anyNamed('amountInMicroCcd'),
        restakeEarnings: anyNamed('restakeEarnings'),
        bakerId: anyNamed('bakerId'),
      )).thenAnswer(
        (_) async => BlockchainResponse(
          status: "received",
          data: {
            "txHash": "some_tx_hash",
          },
        ),
      );

      final responseForBakerType = await service.sendDelegationTransaction(
        senderAddress: senderAddress,
        privateKey: privateKey,
        amountInMicroCcd: transferAmountInMicroCcd,
        restakeEarnings: true,
        delegationType: ConcordiumDelegationType.baker,
        bakerId: "some_baker_address",
      );

      when(service.sendDelegationTransaction(
        privateKey: anyNamed('privateKey'),
        senderAddress: anyNamed('senderAddress'),
        amountInMicroCcd: 0,
      )).thenAnswer(
        (_) async => BlockchainResponse(
          status: "received",
          data: {
            "txHash": "some_tx_hash",
          },
        ),
      );

      final responseForWithdraw = await service.sendDelegationTransaction(
        senderAddress: senderAddress,
        privateKey: privateKey,
        amountInMicroCcd: 0,
      );

      expect(
        responseForPassiveType,
        BlockchainResponse(
          status: "received",
          data: {
            "txHash": "some_tx_hash",
          },
        ),
      );

      expect(
        responseForBakerType,
        BlockchainResponse(
          status: "received",
          data: {
            "txHash": "some_tx_hash",
          },
        ),
      );

      expect(
        responseForWithdraw,
        BlockchainResponse(
          status: "received",
          data: {
            "txHash": "some_tx_hash",
          },
        ),
      );
    });
    test("sendBakerTransaction", () async {
      const senderAddress = "your_address";
      const transferAmountInMicroCcd = 1000000000;
      const privateKey = "your_private_key";

      when(
        service.sendBakerTransaction(
          privateKey: anyNamed('privateKey'),
          senderAddress: anyNamed('senderAddress'),
          stakeAmountInMicroCcd: anyNamed('stakeAmountInMicroCcd'),
          restakeEarnings: anyNamed('restakeEarnings'),
          openStatus: anyNamed('openStatus'),
          metadataUrl: anyNamed('metadataUrl'),
          transactionFeeCommissionInPercentage:
              anyNamed('transactionFeeCommissionInPercentage'),
          bakingRewardCommissionInPercentage:
              anyNamed('bakingRewardCommissionInPercentage'),
          finalizationRewardCommissionInPercentage:
              anyNamed('finalizationRewardCommissionInPercentage'),
          bakerKeys: anyNamed('bakerKeys'),
        ),
      ).thenAnswer(
        (_) async => BlockchainResponse(
          status: "received",
          data: {
            "txHash": "some_tx_hash",
          },
        ),
      );

      final response = await service.sendBakerTransaction(
        senderAddress: senderAddress,
        privateKey: privateKey,
        stakeAmountInMicroCcd: transferAmountInMicroCcd,
        restakeEarnings: true,
        openStatus: DelegationOpenStatus.OpenForAll,
        metadataUrl: "some_metadata_url",
        transactionFeeCommissionInPercentage: 10.0,
        bakingRewardCommissionInPercentage: 10.0,
        finalizationRewardCommissionInPercentage: 100.0,
      );

      final responseUpdateParam = await service.sendBakerTransaction(
          senderAddress: senderAddress,
          privateKey: privateKey,
          bakingRewardCommissionInPercentage: 20,
          transactionFeeCommissionInPercentage: 15,
          bakerKeys: {} // saved baker keys or null to create new keys
          );

      expect(
        response,
        BlockchainResponse(
          status: "received",
          data: {
            "txHash": "some_tx_hash",
          },
        ),
      );

      expect(
        responseUpdateParam,
        BlockchainResponse(
          status: "received",
          data: {
            "txHash": "some_tx_hash",
          },
        ),
      );
    });
  });
}

class MockBuildContext extends Mock implements BuildContext {}
