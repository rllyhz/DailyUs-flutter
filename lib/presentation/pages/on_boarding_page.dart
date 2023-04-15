import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/common/ui/theme.dart';
import 'package:daily_us/presentation/widgets/decorations/text_decorations.dart';
import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  static const valueKey = ValueKey("OnBoardingPage");

  const OnBoardingPage({
    super.key,
    required this.onLogin,
    required this.onRegister,
  });

  final void Function() onLogin;
  final void Function() onRegister;

  @override
  Widget build(BuildContext context) {
    var totalWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SizedBox.expand(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 28.0,
                  ),
                  Text(
                    AppLocalizations.of(context)!.onBoardingHeading,
                    style: onBoardingAppNameTextStyle(),
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Image.asset(
                    "assets/illustration_on_boarding.png",
                    semanticLabel: "OnBoarding logo",
                    width: totalWidth / 1.55,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Text(
                    AppLocalizations.of(context)!.onBoardingSubHeading,
                    style: onBoardingHeadlineTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 56.0,
                  ),
                  appButton(
                    text: AppLocalizations.of(context)!.buttonLogin,
                    onPressed: onLogin,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  appOutlinedButton(
                    text: AppLocalizations.of(context)!.buttonRegister,
                    onPressed: onRegister,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
