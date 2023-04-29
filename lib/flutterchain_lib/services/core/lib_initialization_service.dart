import 'package:flutterchain/flutterchain_lib/constants/core/storage_keys.dart';
import 'package:flutterchain/flutterchain_lib/constants/core/webview_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final InAppLocalhostServer? localhostServer = kIsWeb
    ? null
    : InAppLocalhostServer(documentRoot: WebViewConstants.documentRoot);

Future<void> initFlutterChainLib() async {
  if (!kIsWeb) {
    await localhostServer?.start();
  }

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(true);
  }
}

checkIfUserAuthorized() async {
  final res = await const FlutterSecureStorage().read(
    key: StorageKeys.wallets,
  );
  return res != null;
}
