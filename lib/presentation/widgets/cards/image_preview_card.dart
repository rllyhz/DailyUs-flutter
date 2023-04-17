import 'package:daily_us/common/ui/colors.dart';
import 'package:daily_us/presentation/widgets/cards/daily_us_card.dart';
import 'package:flutter/material.dart';

class ImagePreviewCard extends StatelessWidget {
  const ImagePreviewCard({
    super.key,
    this.child,
    required this.padding,
  });

  final Widget? child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return DailyUsCard(
      padding: padding,
      backgroundColor: greyColor,
      label: 'ImagePreviewCard',
      elevation: 0,
      child: child,
    );
  }
}
