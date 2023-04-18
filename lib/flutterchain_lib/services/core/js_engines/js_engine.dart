import 'package:flutterchain/flutterchain_lib/services/core/js_engines/js_vm.dart';
import 'package:flutterchain/flutterchain_lib/constants/webview_constants.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

JsVMService getJsVM() {
  return MobileJsVMService();
}

class MobileJsVMService implements JsVMService {
  HeadlessInAppWebView? _headlessWebView;
  InAppWebViewController? _webViewMobileController;
  MobileJsVMService() {
    init();
  }

  @override
  Future<void> init() async {
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

  @override
  Future<dynamic> callJS(String function) async {
    return _webViewMobileController?.evaluateJavascript(source: function) ??
        "{}";
  }
}
