import 'package:chain_signatures_example/widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';

class HomeLoadingBanner extends StatelessWidget {
  const HomeLoadingBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(child: CustomLoadingIndicator()),
      ),
    );
  }
}
