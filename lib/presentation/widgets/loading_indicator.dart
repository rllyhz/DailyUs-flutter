import 'package:daily_us/common/ui/colors.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    required this.semanticsLabel,
    this.color,
  });

  final String semanticsLabel;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      semanticsLabel: semanticsLabel,
      color: color ?? purple500Color,
      strokeWidth: 5.0,
    );
  }
}
