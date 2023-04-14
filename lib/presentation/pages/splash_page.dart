import 'package:daily_us/common/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Semantics(
        label: "Logo App",
        child: Container(
          color: Theme.of(context).colorScheme.background,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/logo_icon.svg',
                  width: 82,
                  height: 82,
                ),
                Text(AppLocalizations.of(context)!.appName),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
