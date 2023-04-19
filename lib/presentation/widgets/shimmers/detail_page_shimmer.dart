import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/common/ui/colors.dart';
import 'package:daily_us/presentation/widgets/daily_us_app_bar.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';

class DetailPageShimmer extends StatelessWidget {
  const DetailPageShimmer({
    super.key,
    this.fadeTheme,
  });

  final FadeTheme? fadeTheme;

  @override
  Widget build(BuildContext context) {
    var totalWidth = MediaQuery.of(context).size.width;
    var previewCardwidth = totalWidth;
    var previewCardHeight = totalWidth * 1 / 2;
    if (totalWidth > 620.0) {
      previewCardHeight = totalWidth * 3 / 2;
    }

    return SizedBox.expand(
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: screenPaddingSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              DailyUsAppBar(
                onBack: () {},
                title: AppLocalizations.of(context)!.titleDetail,
              ),
              const SizedBox(
                height: 12.0,
              ),
              SizedBox(
                width: previewCardwidth,
                height: previewCardHeight,
                child: FadeShimmer.round(
                  fadeTheme: fadeTheme,
                  baseColor: primaryColor,
                  highlightColor: primaryColor.withOpacity(0.2),
                  size: 12.0,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: totalWidth,
                height: 12.0,
                child: FadeShimmer.round(
                  fadeTheme: fadeTheme,
                  baseColor: primaryColor,
                  highlightColor: primaryColor.withOpacity(0.2),
                  size: 12.0,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: totalWidth,
                height: 12.0,
                child: FadeShimmer.round(
                  fadeTheme: fadeTheme,
                  baseColor: primaryColor,
                  highlightColor: primaryColor.withOpacity(0.2),
                  size: 12.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
