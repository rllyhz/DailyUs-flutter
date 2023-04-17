import 'package:daily_us/common/ui/colors.dart';
import 'package:daily_us/presentation/widgets/decorations/text_decorations.dart';
import 'package:flutter/material.dart';

class DailyUsTextField extends StatelessWidget {
  const DailyUsTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType,
    this.validator,
    this.obscureText = false,
  });

  final String hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: greyColor,
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        obscureText: obscureText,
        cursorColor: secondaryColor,
        validator: validator,
        style: hintTextStyle(color: purple700Color),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintTextStyle(color: primaryColor),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
