import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/common/ui/colors.dart';
import 'package:daily_us/common/ui/theme.dart';
import 'package:daily_us/presentation/widgets/decorations/text_decorations.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  static const valueKey = ValueKey("ProfilePage");

  const ProfilePage({super.key, required this.onLogout});

  final void Function() onLogout;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(
          left: screenPaddingSize,
          right: screenPaddingSize,
        ),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 24.0,
                    ),
                    Text(
                      'rllyhz@mail.com',
                      style: profileEmailTextStyle(),
                    ),
                    Text(
                      'Rully Ihza Mahendra',
                      style: profileFullNameTextStyle(),
                    ),
                    const SizedBox(
                      height: 46.0,
                    ),
                    appOutlinedButton(
                      text: AppLocalizations.of(context)!.buttonChangeLanguage,
                      onPressed: () {
                        // print("change language");
                      },
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: screenPaddingSize,
              left: 0,
              right: 0,
              child: appOutlinedButton(
                text: AppLocalizations.of(context)!.buttonLogout,
                onPressed: onLogout,
                borderColor: secondaryColor,
                color: secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
