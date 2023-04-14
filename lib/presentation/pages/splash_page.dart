import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/common/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
                const SizedBox(
                  height: 6,
                ),
                Text(
                  AppLocalizations.of(context)!.appName,
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    color: purple500Color,
                  ),
                ),
                const SizedBox(
                  height: 72,
                ),
                CircularProgressIndicator(
                  color: purple500Color,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
