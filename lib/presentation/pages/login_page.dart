import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/common/ui/theme.dart';
import 'package:daily_us/presentation/widgets/daily_us_app_bar.dart';
import 'package:daily_us/presentation/widgets/daily_us_text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  static const valueKey = ValueKey("LoginPage");

  const LoginPage({
    super.key,
    required this.onSuccessLogin,
  });

  final void Function() onSuccessLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: screenPaddingSize),
            child: Stack(
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                SizedBox.expand(
                  child: Column(
                    children: <Widget>[
                      DailyUsAppBar(
                        onBack: () {
                          Navigator.of(context).pop();
                        },
                        title: AppLocalizations.of(context)!.titleLogin,
                      ),
                      const SizedBox(
                        height: 32.0,
                      ),
                      DailyUsTextField(
                        hintText: AppLocalizations.of(context)!.emailHint,
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      DailyUsTextField(
                        hintText: AppLocalizations.of(context)!.passwordHint,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: screenPaddingSize,
                  left: 0,
                  right: 0,
                  child: appButton(
                    text: AppLocalizations.of(context)!.buttonLogin,
                    onPressed: () {
                      onSuccessLogin();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
