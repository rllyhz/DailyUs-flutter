import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/presentation/widgets/decorations/text_decorations.dart';
import 'package:daily_us/presentation/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatefulWidget {
  static String routeName = "/splash";

  const SplashPage({
    super.key,
    required this.onAnimationEnd,
  });

  final void Function()? onAnimationEnd;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  double startPos = 0.3;
  double endPos = 0;
  final duration = const Duration(milliseconds: 1500);
  final delay = const Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Center(
          child: TweenAnimationBuilder(
            tween: Tween<Offset>(
              begin: Offset(0, startPos),
              end: Offset(0, endPos),
            ),
            curve: Curves.easeInQuad,
            duration: duration,
            builder: (context, offset, child) => FractionalTranslation(
              translation: offset,
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: AnimatedOpacity(
                    opacity: _calculateLevelOpacity(offset.dy),
                    duration: duration,
                    child: child,
                  ),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  logoIconAssetPath,
                  width: logoIconSize,
                  height: logoIconSize,
                  semanticsLabel: "LogoApp",
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(
                  AppLocalizations.of(context)!.appName,
                  style: splashTextStyle(),
                ),
                const SizedBox(
                  height: 72,
                ),
                const LoadingIndicator(
                  semanticsLabel: "OnBoarding loading indicator",
                ),
              ],
            ),
            onEnd: () {
              // end animation
              Future.delayed(delay, () {
                if (widget.onAnimationEnd != null) widget.onAnimationEnd!();
              });
            },
          ),
        ),
      ),
    );
  }

  double _calculateLevelOpacity(double currentPosition) {
    if (currentPosition <= endPos + 0.15) {
      return 1.0;
    } else if (currentPosition == startPos) {
      return 0.0;
    } else {
      return currentPosition;
    }
  }
}
