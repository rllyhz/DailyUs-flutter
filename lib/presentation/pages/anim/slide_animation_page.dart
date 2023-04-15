import 'package:flutter/material.dart';

class SlideAnimationPage extends Page {
  const SlideAnimationPage({
    super.key,
    required this.child,
    this.applyOpacity = true,
    this.duration = const Duration(milliseconds: 500),
    this.direction = SlideAnimationPage.leftToRight,
  });

  final Widget child;
  final Duration duration;
  final int direction;
  final bool applyOpacity;

  static const int topToBottom = 0;
  static const int bottomToTop = 1;
  static const int leftToRight = 2;
  static const int rightToLeft = 3;

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
        settings: this,
        pageBuilder: (context, animation, secondAnimation) => child,
        transitionDuration: duration,
        transitionsBuilder: (context, animation, secondaryAnim, child) {
          return SlideTransition(
            position: _createTweenPosition(animation),
            child: applyOpacity
                ? FadeTransition(
                    opacity: animation.drive(CurveTween(curve: Curves.easeIn)),
                    child: child,
                  )
                : child,
          );
        });
  }

  Animation<Offset> _createTweenPosition(Animation<double> animation) {
    Offset startOffset = Offset.zero;
    Offset endOffset = Offset.zero;

    if (direction == SlideAnimationPage.topToBottom) {
      startOffset = const Offset(0.0, -1.0);
    } else if (direction == SlideAnimationPage.bottomToTop) {
      startOffset = const Offset(0.0, 1.0);
    } else if (direction == SlideAnimationPage.leftToRight) {
      startOffset = const Offset(-1.0, 0.0);
    } else {
      startOffset = const Offset(1.0, 0.0);
    }

    return Tween<Offset>(
      begin: startOffset,
      end: endOffset,
    ).animate(animation);
  }
}
