import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_runners/nearblockchain/near_blockchain_js_runner_interface.dart';
import 'package:web/web.dart' as web;

NearBlockChainJsRunner getNearJsRunner() => NearBlockChainWebJsRunner();

class NearBlockChainWebJsRunner implements NearBlockChainJsRunner {
  @override
  Future<String> getBlockChainDataFromMnemonic({
    required String mnemonic,
    required String passphrase,
    String? accountNumber,
    String? change,
    String? address,
  }) async {
    if (accountNumber == null || change == null || address == null) {
      return _getBlockChainDataFromMnemonic(
        mnemonic.toJS,
        passphrase.toJS,
      );
    } else {
      return _getBlockChainDataFromMnemonic(
        mnemonic.toJS,
        passphrase.toJS,
        accountNumber.toJS,
        change.toJS,
        address.toJS,
      );
    }
  }

  @override
  Future<String> signNearActions({
    required String fromAddress,
    required String toAddress,
    required String transferAmount,
    required String privateKey,
    required String gas,
    required int nonce,
    required String blockHash,
    required String actions,
  }) async =>
      _signNearActions(
        fromAddress,
        toAddress,
        transferAmount,
        gas,
        privateKey,
        nonce.toString(),
        blockHash,
        actions,
      );

  @override
  Future<String> exportSecretKeyToNearApiJSFormat({
    required String privateKey,
    required String publicKey,
  }) async =>
      _exportSecretKeyToNearApiJSFormat(privateKey, publicKey);

  @override
  Future<String> getBase58PubKeyFromHexValue(String hexEncodedPubKey) async =>
      _getBase58PubKeyFromHexValue(hexEncodedPubKey);

  @override
  Future<String> getPublicKeyFromSecretKeyFromNearApiJSFormat(
          String base58PrivateKey) async =>
      _getPublicKeyFromSecretKeyFromNearApiJSFormat(base58PrivateKey);

  @override
  Future<String> getPrivateKeyFromSecretKeyFromNearApiJSFormat(
          String base58PrivateKey) async =>
      _getPrivateKeyFromSecretKeyFromNearApiJSFormat(base58PrivateKey);

  @override
  Future<String> generateAddressForNearMPC({
    required String accountId,
    required String path,
    required String chain,
    required String network,
    String? publicMPCKey,
  }) async {
    if (publicMPCKey == null) {
      return (await _generateAddressForNearMPC(
        accountId.toJS,
        path.toJS,
        chain.toJS,
        network.toJS,
      ).toDart)
          .toDart;
    } else {
      return (await _generateAddressForNearMPC(
        accountId.toJS,
        path.toJS,
        chain.toJS,
        network.toJS,
        publicMPCKey.toJS,
      ).toDart)
          .toDart;
    }
  }

  @override
  Future<void> authWithNearWalletsWeb({
    required String privateNearAPIjsFormat,
    String? successUrlCallBackWeb,
    String? failureUrlCallBackWeb,
  }) async {
    final currentUrl = web.window.location.href;
    final script = '''
        // Create a script element
        var script = document.createElement('script');

        // Set the script source, integrity, and crossorigin attributes
        script.src = 'https://cdn.jsdelivr.net/npm/near-api-js@0.44.2/dist/near-api-js.min.js';
        script.integrity = 'sha256-W5o4c5DRZZXMKjuL41jsaoBpE/UHMkrGvIxN9HcjNSY=';
        script.crossOrigin = 'anonymous';

        // Add an event listener to execute code when the script has loaded
        script.onload = function() {
            // Your code to run after the script has loaded
            console.log('Near API JS has loaded!');
            const addNewFullAccessKeyToTheNearBlockchain = async (key) => {
                const { keyStores, KeyPair, connect, WalletConnection } = nearApi;
                const myKeyStore = new keyStores.BrowserLocalStorageKeyStore();
                const connectionConfig = {
                    networkId: "mainnet",
                    keyStore: myKeyStore,
                    nodeUrl: "https://rpc.mainnet.near.org",
                    walletUrl: "https://app.mynearwallet.com",
                    helperUrl: "https://helper.mainnet.near.org",
                    explorerUrl: "https://explorer.mainnet.near.org",
                };
                const nearConnection = await connect(connectionConfig);
                const wallet = new WalletConnection(nearConnection);

                const PENDING_ACCESS_KEY_PREFIX = "pending_key";

                const loginFullAccess = async (options) => {
                    const currentUrl = new URL(window.location.href);
                    const newUrl = new URL(wallet._walletBaseUrl + "/login/");
                    newUrl.searchParams.set("success_url", "${successUrlCallBackWeb ?? currentUrl}");
                    newUrl.searchParams.set("failure_url", "${failureUrlCallBackWeb ?? currentUrl}");

                    const accessKey = KeyPair.fromString(key);
                    newUrl.searchParams.set("public_key", accessKey.getPublicKey().toString());
                    await wallet._keyStore.setKey(
                        wallet._networkId,
                        PENDING_ACCESS_KEY_PREFIX + accessKey.getPublicKey(),
                        accessKey
                    );

                    window.location.assign(newUrl.toString());
                };


                loginFullAccess();


            };

            window.addNewFullAccessKeyToTheNearBlockchain = addNewFullAccessKeyToTheNearBlockchain;
          addNewFullAccessKeyToTheNearBlockchain('$privateNearAPIjsFormat');
        };

        // Append the script element to the head of the document
        document.head.appendChild(script);

      // window.addNewFullAccessKeyToTheNearBlockchain('$privateNearAPIjsFormat');

    ''';
    globalContext.callMethod(
      'eval'.toJS,
      script.toJS,
    );
  }
}

@JS('NearBlockchain.getBlockChainDataFromMnemonic')
external String _getBlockChainDataFromMnemonic(
    JSString mnemonic, JSString passphrase,
    [JSString? account, JSString? change, JSString? address]);

@JS('NearBlockchain.signNearActions')
external String _signNearActions(
  String fromAddress,
  String toAddress,
  String transferAmount,
  String gas,
  String privateKey,
  String nonce,
  String blockHash,
  String actions,
);

@JS('NearBlockchain.exportSecretKeyToNearApiJSFormat')
external String _exportSecretKeyToNearApiJSFormat(
    String privateKey, String publicKey);

@JS('NearBlockchain.getBase58PubKeyFromHexValue')
external String _getBase58PubKeyFromHexValue(String publicKey);

@JS('NearBlockchain.getPublicKeyFromSecretKeyFromNearApiJSFormat')
external String _getPublicKeyFromSecretKeyFromNearApiJSFormat(String secretKey);

@JS('NearBlockchain.getPrivateKeyFromSecretKeyFromNearApiJSFormat')
external String _getPrivateKeyFromSecretKeyFromNearApiJSFormat(
    String secretKey);

@JS('generateAddressForNearMPC')
external JSPromise<JSString> _generateAddressForNearMPC(
    JSString accountId, JSString path, JSString chain, JSString network,
    [JSString? publicMPCKey]);

