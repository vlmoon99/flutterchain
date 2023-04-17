import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutterchain/flutterchain_lib/constants/webview_constants.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:js' as js;

class JsVMService {
  HeadlessInAppWebView? _headlessWebView;
  InAppWebViewController? _webViewMobileController;
  JsVMService() {
    if (kIsWeb) {
      return;
    }
    if (Platform.isAndroid) {
      log('Running on Android!');
      initMobile();
    } else if (Platform.isIOS) {
      log('Running on iOS!');
      initMobile();
    } else if (Platform.isMacOS) {
      log('Running on macOS!');
    } else if (Platform.isWindows) {
      log('Running on Windows!');
    } else if (Platform.isLinux) {
      log('Running on Linux!');
    } else if (Platform.isFuchsia) {
      log('Running on Fuchsia!');
    } else if (kIsWeb) {
      log('Running on Web!');
    } else {
      log('Unknown platform!');
    }
    initMobile();
  }
  Future<void> initMobile() async {
    _headlessWebView = HeadlessInAppWebView(
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        domStorageEnabled: true,
        allowFileAccess: true,
        allowContentAccess: true,
        allowUniversalAccessFromFileURLs: true,
        cacheMode: CacheMode.LOAD_NO_CACHE,
        databaseEnabled: true,
        mixedContentMode: MixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
      ),
      initialUrlRequest: URLRequest(
        url: WebUri(
          WebViewConstants.hiddenWebviewUrl,
        ),
      ),
      onWebViewCreated: (controller) async {
        await controller.setSettings(
          settings: InAppWebViewSettings(),
        );
        _webViewMobileController = controller;
      },
      onConsoleMessage: (controller, consoleMessage) {},
      onLoadStart: (controller, url) async {},
      onLoadStop: (controller, url) async {},
    );
    await _headlessWebView?.run();
  }

  Future<dynamic> callJS(String function) async {
    if (Platform.isAndroid) {
      return _webViewMobileController?.evaluateJavascript(source: function) ??
          "{}";
    } else if (Platform.isIOS) {
      return _webViewMobileController?.evaluateJavascript(source: function) ??
          "{}";
    } else if (Platform.isMacOS) {
    } else if (Platform.isWindows) {
    } else if (Platform.isLinux) {
    } else if (Platform.isFuchsia) {
    } else if (kIsWeb) {
      return js.context
          .callMethod('eval', ['console.log("Hello, JavaScript!");']);
    } else {
      return "Not implemented on your platform";
    }
  }
}
