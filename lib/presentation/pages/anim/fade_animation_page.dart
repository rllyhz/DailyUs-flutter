import 'package:flutter/material.dart';

class FadeAnimationPage extends Page {
  const FadeAnimationPage({
    super.key,
    required this.child,
    this.opaque = true,
  });

  final Widget child;
  final bool opaque;

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      opaque: opaque,
      settings: this,
      pageBuilder: (context, animation, secondAnim) {
        var curveTween = CurveTween(curve: Curves.easeIn);
        return FadeTransition(
          opacity: animation.drive(curveTween),
          child: child,
        );
      },
    );
  }
}
