import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutterchain/flutterchain_lib/models/core/blockchain_response.dart';
import 'package:mockito/mockito.dart';

import 'near_blockchain_service_test.mocks.dart';

void main() {
  group("Unit tests for MintBase service", () {
    test("Create collection", () async {
      final nearService = MockNearBlockChainService();

      final response = BlockchainResponse(data: {}, status: "success");

      when(nearService.deployNFTCollection(
              accountId: "Your account id",
              publicKey: "Your account public key",
              privateKey: "Your account private лey",
              symbol: "Symbol for collection",
              name: "Name collection",
              ownerId: "How will be owner"))
          .thenAnswer((_) async => response);

      final res = await nearService.deployNFTCollection(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          symbol: "Symbol for collection",
          name: "Name collection",
          ownerId: "How will be owner");
      expect(res, response);
    });

    test("Сheck which collections you own", () async {
      final nearService = MockNearBlockChainService();

      when(nearService.checkOwnerCollection(owner_id: "Your id"))
          .thenAnswer((_) async => []);

      final res = await nearService.checkOwnerCollection(owner_id: "Your id");
      expect(res, []);
    });

    test("Add or delete minters", () async {
      final nearService = MockNearBlockChainService();
      final response = BlockchainResponse(data: {}, status: "success");

      when(nearService.addDeleteMinters(
              accountId: "Your account id",
              publicKey: "Your account public key",
              privateKey: "Your account private лey",
              nftCollectionContract: "Full id collection",
              name: "Name collection",
              isAdd: true))
          .thenAnswer((_) async => response);

      final res = await nearService.addDeleteMinters(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          nftCollectionContract: "Full id collection",
          name: "Name collection",
          isAdd: true);
      expect(res, response);
    });

    test("Transfer NFT collection", () async {
      final nearService = MockNearBlockChainService();
      final response = BlockchainResponse(data: {}, status: "success");

      when(nearService.transferNFTCollection(
              accountId: "Your account id",
              publicKey: "Your account public key",
              privateKey: "Your account private лey",
              nftCollectionContract: "Full id collection",
              new_owner: "new owner id",
              keep_old_minters: true))
          .thenAnswer((_) async => response);

      final res = await nearService.transferNFTCollection(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          nftCollectionContract: "Full id collection",
          new_owner: "new owner id",
          keep_old_minters: true);
      expect(res, response);
    });

    test("Get minters by NFT collection", () async {
      final nearService = MockNearBlockChainService();

      when(nearService.getMinters(
              accountId: "Your account id",
              publicKey: "Your account public key",
              privateKey: "Your account private лey",
              nftCollectionContract: "Full id collection"))
          .thenAnswer((_) async => []);

      final res = await nearService.getMinters(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          nftCollectionContract: "Full id collection");
      expect(res, []);
    });

    test("Mint NFT", () async {
      final nearService = MockNearBlockChainService();
      final response = BlockchainResponse(data: {}, status: "success");

      when(nearService.mintNFT(
              accountId: "Your account id",
              publicKey: "Your account public key",
              privateKey: "Your account private лey",
              nftCollectionContract: "Full id collection",
              owner_id: "Account id how will be owner",
              description: "Description for NFT",
              title: "Title for NFT",
              media: Uint8List(0)))
          .thenAnswer((_) async => response);

      final res = await nearService.mintNFT(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          nftCollectionContract: "Full id collection",
          owner_id: "Account id how will be owner",
          description: "Description for NFT",
          title: "Title for NFT",
          media: Uint8List(0));
      expect(res, response);
    });

    test("Transfer NFT", () async {
      final nearService = MockNearBlockChainService();
      final response = BlockchainResponse(data: {}, status: "success");

      when(nearService.transferNFT(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          nftCollectionContract: "Full id collection",
          tokenIds: [
            ["Token Id", "ID owner"]
          ])).thenAnswer((_) async => response);

      final res = await nearService.transferNFT(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          nftCollectionContract: "Full id collection",
          tokenIds: [
            ["Token Id", "ID owner"]
          ]);
      expect(res, response);
    });

    test("Multiply NFT", () async {
      final nearService = MockNearBlockChainService();
      final response = BlockchainResponse(data: {}, status: "success");

      when(nearService.multiplyNFT(
              accountId: "Your account id",
              publicKey: "Your account public key",
              privateKey: "Your account private лey",
              nameNFTCollection: "Full id collection",
              nameNFT: "Name NFT that you want multiply",
              numToMint: 2,
              media: "Media for NFT in string format"))
          .thenAnswer((_) async => response);

      final res = await nearService.multiplyNFT(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          nameNFTCollection: "Full id collection",
          nameNFT: "Name NFT that you want multiply",
          numToMint: 2,
          media: "Media for NFT in string format");
      expect(res, response);
    });

    test("Listing activate", () async {
      final nearService = MockNearBlockChainService();
      final response = BlockchainResponse(data: {}, status: "success");

      when(nearService.listingActivate(
              accountId: "Your account id",
              publicKey: "Your account public key",
              privateKey: "Your account private лey"))
          .thenAnswer((_) async => response);

      final res = await nearService.listingActivate(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey");
      expect(res, response);
    });

    test("Simple list NFT", () async {
      final nearService = MockNearBlockChainService();
      final response = BlockchainResponse(data: {}, status: "success");

      when(nearService.simpleListNFT(
              accountId: "Your account id",
              publicKey: "Your account public key",
              privateKey: "Your account private лey",
              nameNFTCollection: "Full id collection",
              tokenId: "Id token that you want list",
              price: "Price for token"))
          .thenAnswer((_) async => response);

      final res = await nearService.simpleListNFT(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          nameNFTCollection: "Full id collection",
          tokenId: "Id token that you want list",
          price: "Price for token");
      expect(res, response);
    });

    test("Buy simple list NFT", () async {
      final nearService = MockNearBlockChainService();
      final response = BlockchainResponse(data: {}, status: "success");

      when(nearService.buySimpleListNFT(
              accountId: "Your account id",
              publicKey: "Your account public key",
              privateKey: "Your account private лey",
              nameNFTCollection: "Full id collection",
              tokenId: 3))
          .thenAnswer((_) async => response);

      final res = await nearService.buySimpleListNFT(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          nameNFTCollection: "Full id collection",
          tokenId: 3);
      expect(res, response);
    });

    test("Unlist simple list NFT", () async {
      final nearService = MockNearBlockChainService();
      final response = BlockchainResponse(data: {}, status: "success");

      when(nearService.unlistNFT(
              accountId: "Your account id",
              publicKey: "Your account public key",
              privateKey: "Your account private лey",
              nameNFTCollection: "Full id collection",
              tokenId: 3))
          .thenAnswer((_) async => response);

      final res = await nearService.unlistNFT(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          nameNFTCollection: "Full id collection",
          tokenId: 3);
      expect(res, response);
    });

    test("Offers to rolling auction", () async {
      final nearService = MockNearBlockChainService();
      final response = BlockchainResponse(data: {}, status: "success");

      when(nearService.rollingAuctionNft(
              accountId: "Your account id",
              publicKey: "Your account public key",
              privateKey: "Your account private лey",
              nameNFTCollection: "Full id collection",
              tokenId: 3,
              price: "Price bet"))
          .thenAnswer((_) async => response);

      final res = await nearService.rollingAuctionNft(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          nameNFTCollection: "Full id collection",
          tokenId: 3,
          price: "Price bet");
      expect(res, response);
    });

    test("Delist rolling NFT", () async {
      final nearService = MockNearBlockChainService();
      final response = BlockchainResponse(data: {}, status: "success");

      when(nearService.delistNFT(
              accountId: "Your account id",
              publicKey: "Your account public key",
              privateKey: "Your account private лey",
              nameNFTCollection: "Full id collection",
              tokenId: 3))
          .thenAnswer((_) async => response);

      final res = await nearService.delistNFT(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          nameNFTCollection: "Full id collection",
          tokenId: 3);
      expect(res, response);
    });
  });
}
