import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundedTextField extends StatefulWidget {
  const RoundedTextField({
    super.key,
    required this.textEditingController,
    required this.labelText,
    this.fontSize = 14,
  });
  final TextEditingController textEditingController;
  final String labelText;
  final double fontSize;

  @override
  State<RoundedTextField> createState() => _RoundedTextFieldState();
}

class _RoundedTextFieldState extends State<RoundedTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      controller: widget.textEditingController,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontSize: widget.fontSize.sp,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
      style: TextStyle(
        fontSize: widget.fontSize.sp,
      ),
    );
  }
}
