// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutterchain_example/routes/routes.dart';
import 'package:flutterchain_example/theme/app_theme.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    final theme = Modular.get<AppTheme>();
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;
    final nearColors = theme.getTheme().extension<NearColors>()!;

    return Scaffold(
      backgroundColor: nearColors.nearAqua,
      appBar: AppBar(
        backgroundColor: nearColors.nearAqua,
        title: Text(
          'Welcome to Flutter Chain',
          style: nearTextStyles.headline,
        ),
      ),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          _buildPage(
            'Introduction',
            'This app provides a comprehensive solution for managing multiple cryptocurrencies. Powered by a robust and modular architecture, it enables seamless integration of various blockchain platforms.',
            nearTextStyles.bodyCopy!,
          ),
          _buildPage(
            'Crypto Library',
            'Our crypto library features a wide range of tools, including encryption, decryption, and hashing functions. This ensures the highest level of security for your digital assets.',
            nearTextStyles.bodyCopy!,
          ),
          _buildPage(
            'Extensible',
            'The app supports multiple blockchains, including Ethereum, Bitcoin, and others. New blockchains can be added easily following the principles used in the NearRpcClient implementation.',
            nearTextStyles.bodyCopy!,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _controller.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: nearColors.nearPurple,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Previous',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: nearTextStyles.label!.fontSize,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_controller.page?.toInt() == 2) {
                  Modular.to.navigate(Routes.home.getModule());
                }
                _controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: nearColors.nearPurple,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Next',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: nearTextStyles.label!.fontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(String title, String content, TextStyle textStyle) {
    final theme = Modular.get<AppTheme>();
    final nearTextStyles = theme.getTheme().extension<NearTextStyles>()!;

    return Container(
      padding: const EdgeInsets.all(8),
      // color: nearColors.nearAqua,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: textStyle.copyWith(
              fontSize: nearTextStyles.headline!.fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            content,
            style: textStyle.copyWith(
              fontSize: nearTextStyles.bodyCopy!.fontSize,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
