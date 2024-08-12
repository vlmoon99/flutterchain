import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterchain/flutterchain_lib/models/chains/concordium/concordium_blockchain_data.dart';
import 'package:rxdart/rxdart.dart';

class ConcordiumVm {
  final FlutterSecureStorage storage;

  ConcordiumVm(this.storage);

  final BehaviorSubject<ConcordiumVmState> streamController =
      BehaviorSubject<ConcordiumVmState>.seeded(ConcordiumVmState());

  Stream<ConcordiumVmState> get stream => streamController.stream;

  ConcordiumVmState get state => streamController.value;

  Future<void> updateState({
    String? mnemonic,
    int? identityProviderIndex,
    int? currentBlockchainIndex,
    List<ConcordiumBlockchainData>? blockchainsData,
  }) async {
    final newState = state.copyWith(
      mnemonic: mnemonic,
      identityProviderIndex: identityProviderIndex,
      currentBlockchainIndex: currentBlockchainIndex,
      blockchainsData: blockchainsData,
    );

    streamController.add(newState);
    await saveStateToStorage();
  }

  Future<void> saveStateToStorage() async {
    await storage.write(
        key: "concordium_vm", value: jsonEncode(state.toJson()));
  }

  Future<void> loadStateFromStorage() async {
    final jsonString = await storage.read(key: "concordium_vm");
    if (jsonString != null) {
      final stateFromJson =
          ConcordiumVmState.fromJson(Map.from(jsonDecode(jsonString)));
      streamController.add(stateFromJson);
    }
  }
}

class ConcordiumVmState {
  final String mnemonic;
  final int identityProviderIndex;
  final int currentBlockchainIndex;
  final List<ConcordiumBlockchainData> blockchainsData;

  ConcordiumVmState(
      {this.mnemonic = "",
      this.identityProviderIndex = 0,
      this.currentBlockchainIndex = 0,
      this.blockchainsData = const []});

  ConcordiumVmState copyWith(
      {String? mnemonic,
      int? identityProviderIndex,
      int? currentBlockchainIndex,
      List<ConcordiumBlockchainData>? blockchainsData}) {
    return ConcordiumVmState(
      mnemonic: mnemonic ?? this.mnemonic,
      identityProviderIndex:
          identityProviderIndex ?? this.identityProviderIndex,
      currentBlockchainIndex:
          currentBlockchainIndex ?? this.currentBlockchainIndex,
      blockchainsData: blockchainsData ?? this.blockchainsData,
    );
  }

  Map<String, dynamic> toJson() => {
        "mnemonic": mnemonic,
        "identityProviderIndex": identityProviderIndex,
        "currentBlockchainIndex": currentBlockchainIndex,
        "blockchainsData": jsonEncode(blockchainsData),
      };

  factory ConcordiumVmState.fromJson(Map<String, dynamic> json) {
    final rawBlockChainsData = jsonDecode(json["blockchainsData"] ?? "[]");
    final listOfBlockChainsData = rawBlockChainsData
        .map((e) => ConcordiumBlockchainData.fromJson(e))
        .toList();
    return ConcordiumVmState(
      mnemonic: json["mnemonic"] ?? "",
      identityProviderIndex: json["identityProviderIndex"] ?? 0,
      currentBlockchainIndex: json["currentBlockchainIndex"] ?? 0,
      blockchainsData:
          List<ConcordiumBlockchainData>.from(listOfBlockChainsData),
    );
  }
}
