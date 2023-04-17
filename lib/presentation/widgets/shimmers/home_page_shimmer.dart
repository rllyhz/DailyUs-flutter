import 'package:daily_us/common/ui/colors.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

class HomePageShimmer extends StatelessWidget {
  const HomePageShimmer({
    super.key,
    required this.totalItem,
    required this.padding,
    this.fadeTheme,
    required this.distanceBetweenItems,
    this.scrollable = false,
  });

  final int totalItem;
  final EdgeInsetsGeometry padding;
  final FadeTheme? fadeTheme;
  final double distanceBetweenItems;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    var totalWidth = MediaQuery.of(context).size.width;
    var height = totalWidth * 1 / 3;

    return SizedBox.expand(
      child: ListView.builder(
        physics: !scrollable ? const NeverScrollableScrollPhysics() : null,
        padding: padding,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(bottom: distanceBetweenItems),
          child: SizedBox(
            width: totalWidth,
            height: height,
            child: FadeShimmer(
              millisecondsDelay: index * 300,
              width: double.maxFinite,
              height: double.maxFinite,
              fadeTheme: fadeTheme,
              baseColor: primaryColor,
              highlightColor: primaryColor.withOpacity(0.2),
              radius: 12.0,
            ),
          ),
        ),
        itemCount: totalItem,
      ),
    );
  }
}
