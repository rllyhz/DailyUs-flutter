import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/presentation/widgets/decorations/text_decorations.dart';
import 'package:daily_us/presentation/widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatefulWidget {
  static const valueKey = ValueKey("SplashPage");

  const SplashPage({
    super.key,
    required this.onAnimationEnd,
    this.runPreparationCallback,
  });

  final Future<void> Function()? runPreparationCallback;
  final void Function()? onAnimationEnd;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  double _startPos = 0.3;
  double _endPos = 0;
  final _duration = const Duration(milliseconds: 1500);
  final _delay = const Duration(seconds: 1);

  bool _isForwardAnimLifeCycle = true;

  Tween<Offset> _createAnimTween(double startPos, double endPos) =>
      Tween<Offset>(
        begin: Offset(0, startPos),
        end: Offset(0, endPos),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: Center(
          child: TweenAnimationBuilder(
            tween: _createAnimTween(_startPos, _endPos),
            curve: Curves.easeInQuad,
            duration: _duration,
            builder: (context, offset, child) => FractionalTranslation(
              translation: offset,
              child: SizedBox(
                width: double.infinity,
                child: Center(
                  child: AnimatedOpacity(
                    opacity: _calculateLevelOpacity(offset.dy),
                    duration: _duration,
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
              // end forward animation
              if (_isForwardAnimLifeCycle) {
                Future.delayed(_delay, () async {
                  // run background
                  if (widget.runPreparationCallback != null) {
                    await widget.runPreparationCallback!();
                    // finish preparation stuff
                  }
                  // trigger backward animation
                  setState(() {
                    _startPos = _endPos;
                    _endPos = -1.5;
                    _isForwardAnimLifeCycle = false;
                  });
                });
              }

              // end backwards animation in duration approximately
              Future.delayed(_duration + _delay, () {
                if (widget.onAnimationEnd != null) widget.onAnimationEnd!();
              });
            },
          ),
        ),
      ),
    );
  }

  double _calculateLevelOpacity(double currentPosition) {
    if (_isForwardAnimLifeCycle) {
      if (currentPosition <= _endPos + 0.15) {
        return 1.0;
      } else if (currentPosition == _startPos) {
        return 0.0;
      } else {
        return currentPosition;
      }
    } else {
      if (currentPosition.abs() <= _endPos.abs() - 0.45) {
        return 0.0;
      } else if (currentPosition.abs() == _startPos) {
        return 1.0;
      } else {
        var current = currentPosition.abs();
        var tempLevel = (current - 0) / (1 - 0);
        // opacity level only between 0 and 1
        var level = tempLevel.abs() > 1.0 ? 1.0 : tempLevel.abs();
        return level;
      }
    }
  }
}
