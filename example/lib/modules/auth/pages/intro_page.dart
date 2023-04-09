import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to My Crypto App'),
      ),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          _buildPage('Introduction',
              'This app provides a comprehensive solution for managing multiple cryptocurrencies. Powered by a robust and modular architecture, it enables seamless integration of various blockchain platforms.'),
          _buildPage('Crypto Library',
              'Our crypto library features a wide range of tools, including encryption, decryption, and hashing functions. This ensures the highest level of security for your digital assets.'),
          _buildPage('Extensible',
              'The app supports multiple blockchains, including Ethereum, Bitcoin, and others. New blockchains can be added easily following the principles used in the NearRpcClient implementation.'),
        ],
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              _controller.previousPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Text('Previous'),
          ),
          SizedBox(width: 16),
          ElevatedButton(
            onPressed: () {
              _controller.nextPage(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(String title, String content) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            content,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
