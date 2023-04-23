import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/presentation/widgets/daily_us_dialog.dart';
import 'package:daily_us/presentation/widgets/decorations/text_decorations.dart';
import 'package:flutter/material.dart';

class RegisterDialogPage extends StatelessWidget {
  static const valueKey = ValueKey("RegisterDialogPage");

  const RegisterDialogPage({
    super.key,
    required this.onGoLogin,
  });

  final void Function() onGoLogin;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.2),
      body: Center(
        child: DailyUsDialog(
          title: Text(
            AppLocalizations.of(context)!.dialogTitleRegisterSuccess,
            textAlign: TextAlign.start,
            style: titleTextStyle(),
          ),
          content: Text(
            AppLocalizations.of(context)!.dialogMessageRegisterSuccess,
            style: homeCardDescriptionTextStyle(
              fontSize: 16.0,
            ),
          ),
          positiveAction: OutlinedButton(
            onPressed: onGoLogin,
            child: Text(
              AppLocalizations.of(context)!.dialogPositiveActionRegisterSuccess,
              style: homeCardDescriptionTextStyle(fontSize: 14.0),
            ),
          ),
        ),
      ),
    );
  }
}
