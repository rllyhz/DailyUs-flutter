import 'package:daily_us/common/ui/colors.dart';
import 'package:flutter/material.dart';

class DailyUsCard extends StatelessWidget {
  const DailyUsCard({
    super.key,
    required this.padding,
    this.backgroundColor,
    this.label,
    this.elevation,
    this.child,
  });

  final Color? backgroundColor;
  final String? label;
  final double? elevation;
  final Widget? child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: label,
      child: Card(
        color: backgroundColor ?? greyColor,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: const BorderSide(width: 0, color: Colors.transparent),
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
