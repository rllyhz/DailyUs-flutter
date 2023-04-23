import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/presentation/widgets/daily_us_dialog.dart';
import 'package:daily_us/presentation/widgets/decorations/text_decorations.dart';
import 'package:flutter/material.dart';

class LogoutDialogPage extends StatelessWidget {
  static const valueKey = ValueKey("LogoutDialogPage");

  const LogoutDialogPage({
    super.key,
    required this.onCancel,
    required this.onLogout,
  });

  final void Function() onCancel;
  final void Function() onLogout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.2),
      body: Center(
        child: DailyUsDialog(
          title: Text(
            AppLocalizations.of(context)!.dialogTitleLogoutConfirm,
            textAlign: TextAlign.start,
            style: titleTextStyle(),
          ),
          content: Text(
            AppLocalizations.of(context)!.dialogMessageLogoutConfirm,
            style: homeCardDescriptionTextStyle(
              fontSize: 16.0,
            ),
          ),
          negativeAction: OutlinedButton(
            onPressed: onCancel,
            child: Text(
              AppLocalizations.of(context)!.dialogNegativeActionLogoutConfirm,
              style: homeCardDescriptionTextStyle(fontSize: 14.0),
            ),
          ),
          positiveAction: OutlinedButton(
            onPressed: onLogout,
            child: Text(
              AppLocalizations.of(context)!.dialogPositiveActionLogoutConfirm,
              style: homeCardDescriptionTextStyle(fontSize: 14.0),
            ),
          ),
        ),
      ),
    );
  }
}
