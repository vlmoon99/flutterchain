import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomLoadingIndicator extends StatefulWidget {
  const CustomLoadingIndicator({
    super.key,
    this.assetPath = "assets/Loading Indicator.svg",
    this.size = 50,
    this.duration = const Duration(seconds: 1),
  });

  final String assetPath;
  final double size;
  final Duration duration;

  @override
  State<CustomLoadingIndicator> createState() => _CustomLoadingIndicatorState();
}

class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: _controller,
        child: SvgPicture.asset(
          widget.assetPath,
          height: widget.size,
          width: widget.size,
        ),
      ),
    );
  }
}
