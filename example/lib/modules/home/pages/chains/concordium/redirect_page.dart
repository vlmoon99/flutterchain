import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutterchain/flutterchain_lib/services/chains/concordium_blockchain_service.dart';
import 'package:flutterchain_example/modules/home/pages/core/replaceCurrentTabForWeb.dart'
    if (dart.library.io) 'package:flutterchain_example/modules/home/pages/core/replaceCurrentTabStub.dart';
import 'package:flutterchain_example/routes/routes.dart';

class RedirectPage extends StatefulWidget {
  const RedirectPage({super.key, required this.args});

  final Map<String, dynamic>? args;

  @override
  State<RedirectPage> createState() => _RedirectPageState();
}

class _RedirectPageState extends State<RedirectPage> {
  Future<String?> extractUrlToCreateConcordiumIdentity() async {
    final currentUrl = Uri.base.toString();
    if (currentUrl.contains("code_uri")) {
      final urlToGetIdentityInfo =
          RegExp(r'code_uri=([^&]+)').firstMatch(currentUrl)?.group(1);
      return urlToGetIdentityInfo;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      final ConcordiumBlockchainService concordiumBlockchainService =
          ConcordiumBlockchainService.defaultInstance();
      if (widget.args == null) {
        final url = await extractUrlToCreateConcordiumIdentity();
        log(url.toString());
        final FlutterSecureStorage storage = Modular.get<FlutterSecureStorage>();
        await storage.write(key: "code_uri", value: url);
        Modular.to.navigate(Routes.home.getRoute(Routes.home.concordiumCreateAccount), arguments: true);
      }
      final initUrl =
          await concordiumBlockchainService.getIdentityCreateRequestUrl(
        identityProvider: widget.args!["identityProvider"],
        createIdentityRequestParams:
            widget.args!["createIdentityRequestParams"],
        redirectUrlToReturnForWeb: Uri.base.toString(),
      );
      replaceCurrentTab(initUrl);
    });
    return const Scaffold(
      body: Center(
        child: Text("Redirecting..."),
      ),
    );
  }
}
