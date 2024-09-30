import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'near_blockchain_service_test.mocks.dart';

void main() {
  group("Unit tests for MintBase service", () {
    test("Create collection", () async {
      final nearService = MockNearBlockChainService();

      when(nearService.deployNFTCollection(
              accountId: "Your account id",
              publicKey: "Your account public key",
              privateKey: "Your account private лey",
              symbol: "Symbol for collection",
              name: "Name collection",
              ownerId: "How will be owner"))
          .thenAnswer((_) async => true);

      final res = await nearService.deployNFTCollection(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          symbol: "Symbol for collection",
          name: "Name collection",
          ownerId: "How will be owner");
      expect(res, true);
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

      when(nearService.addDeleteMinters(
              accountId: "Your account id",
              publicKey: "Your account public key",
              privateKey: "Your account private лey",
              nftCollectionContract: "Full id collection",
              name: "Name collection",
              isAdd: true))
          .thenAnswer((_) async => true);

      final res = await nearService.addDeleteMinters(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          nftCollectionContract: "Full id collection",
          name: "Name collection",
          isAdd: true);
      expect(res, true);
    });

    test("Transfer NFT collection", () async {
      final nearService = MockNearBlockChainService();

      when(nearService.transferNFTCollection(
              accountId: "Your account id",
              publicKey: "Your account public key",
              privateKey: "Your account private лey",
              nftCollectionContract: "Full id collection",
              new_owner: "new owner id",
              keep_old_minters: true))
          .thenAnswer((_) async => true);

      final res = await nearService.transferNFTCollection(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          nftCollectionContract: "Full id collection",
          new_owner: "new owner id",
          keep_old_minters: true);
      expect(res, true);
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

      when(nearService.mintNFT(
              accountId: "Your account id",
              publicKey: "Your account public key",
              privateKey: "Your account private лey",
              nftCollectionContract: "Full id collection",
              owner_id: "Account id how will be owner",
              description: "Description for NFT",
              title: "Title for NFT",
              media: "Media for NFT in string format"))
          .thenAnswer((_) async => true);

      final res = await nearService.mintNFT(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          nftCollectionContract: "Full id collection",
          owner_id: "Account id how will be owner",
          description: "Description for NFT",
          title: "Title for NFT",
          media: "Media for NFT in string format");
      expect(res, true);
    });

    test("Transfer NFT", () async {
      final nearService = MockNearBlockChainService();

      when(nearService.transferNFT(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          nftCollectionContract: "Full id collection",
          tokenIds: [
            ["Token Id", "ID owner"]
          ])).thenAnswer((_) async => true);

      final res = await nearService.transferNFT(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          nftCollectionContract: "Full id collection",
          tokenIds: [
            ["Token Id", "ID owner"]
          ]);
      expect(res, true);
    });

    test("Multiply NFT", () async {
      final nearService = MockNearBlockChainService();

      when(nearService.multiplyNFT(
              accountId: "Your account id",
              publicKey: "Your account public key",
              privateKey: "Your account private лey",
              nameNFTCollection: "Full id collection",
              nameNFT: "Name NFT that you want multiply",
              numToMint: 2,
              media: "Media for NFT in string format"))
          .thenAnswer((_) async => true);

      final res = await nearService.multiplyNFT(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          nameNFTCollection: "Full id collection",
          nameNFT: "Name NFT that you want multiply",
          numToMint: 2,
          media: "Media for NFT in string format");
      expect(res, true);
    });

    test("Listing activate", () async {
      final nearService = MockNearBlockChainService();

      when(nearService.listingActivate(
              accountId: "Your account id",
              publicKey: "Your account public key",
              privateKey: "Your account private лey"))
          .thenAnswer((_) async => true);

      final res = await nearService.listingActivate(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey");
      expect(res, true);
    });

    test("Simple list NFT", () async {
      final nearService = MockNearBlockChainService();

      when(nearService.simpleListNFT(
              accountId: "Your account id",
              publicKey: "Your account public key",
              privateKey: "Your account private лey",
              nameNFTCollection: "Full id collection",
              tokenId: "Id token that you want list",
              price: "Price for token"))
          .thenAnswer((_) async => true);

      final res = await nearService.simpleListNFT(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          nameNFTCollection: "Full id collection",
          tokenId: "Id token that you want list",
          price: "Price for token");
      expect(res, true);
    });

    test("Buy simple list NFT", () async {
      final nearService = MockNearBlockChainService();

      when(nearService.buySimpleListNFT(
              accountId: "Your account id",
              publicKey: "Your account public key",
              privateKey: "Your account private лey",
              nameNFTCollection: "Full id collection",
              tokenId: 3))
          .thenAnswer((_) async => true);

      final res = await nearService.buySimpleListNFT(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          nameNFTCollection: "Full id collection",
          tokenId: 3);
      expect(res, true);
    });

    test("Unlist simple list NFT", () async {
      final nearService = MockNearBlockChainService();

      when(nearService.unlistNFT(
              accountId: "Your account id",
              publicKey: "Your account public key",
              privateKey: "Your account private лey",
              nameNFTCollection: "Full id collection",
              tokenId: 3))
          .thenAnswer((_) async => true);

      final res = await nearService.unlistNFT(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          nameNFTCollection: "Full id collection",
          tokenId: 3);
      expect(res, true);
    });

    test("Offers to rolling auction", () async {
      final nearService = MockNearBlockChainService();

      when(nearService.rollingAuctionNft(
              accountId: "Your account id",
              publicKey: "Your account public key",
              privateKey: "Your account private лey",
              nameNFTCollection: "Full id collection",
              tokenId: 3,
              price: "Price bet"))
          .thenAnswer((_) async => true);

      final res = await nearService.rollingAuctionNft(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          nameNFTCollection: "Full id collection",
          tokenId: 3,
          price: "Price bet");
      expect(res, true);
    });

    test("Delist rolling NFT", () async {
      final nearService = MockNearBlockChainService();

      when(nearService.delistNFT(
              accountId: "Your account id",
              publicKey: "Your account public key",
              privateKey: "Your account private лey",
              nameNFTCollection: "Full id collection",
              tokenId: 3))
          .thenAnswer((_) async => true);

      final res = await nearService.delistNFT(
          accountId: "Your account id",
          publicKey: "Your account public key",
          privateKey: "Your account private лey",
          nameNFTCollection: "Full id collection",
          tokenId: 3);
      expect(res, true);
    });
  });
}
