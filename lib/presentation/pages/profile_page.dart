import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/common/ui/colors.dart';
import 'package:daily_us/common/ui/theme.dart';
import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/presentation/bloc/profile/profile_bloc.dart';
import 'package:daily_us/presentation/widgets/decorations/text_decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  static const valueKey = ValueKey("ProfilePage");

  const ProfilePage({
    super.key,
    required this.onLogout,
    required this.authInfo,
  });

  final void Function() onLogout;
  final AuthInfo authInfo;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();

    context.read<ProfileBloc>().stream.listen((state) async {
      if (state is ProfileStateLogoutError) {
        showSnacbar(context, state.message);
      } else if (state is ProfileStateLogoutSuccess) {
        widget.onLogout();
      }
    });
  }

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
                      widget.authInfo.user.email,
                      style: profileEmailTextStyle(),
                    ),
                    Text(
                      widget.authInfo.user.name,
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
                onPressed: () async {
                  var shouldLogout = await _showLogoutDialog(context);

                  if (shouldLogout && context.mounted) {
                    context.read<ProfileBloc>().add(OnLogoutEvent());
                  }
                },
                borderColor: secondaryColor,
                color: secondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _showLogoutDialog(BuildContext context) async => await appDialog(
        context: context,
        title: AppLocalizations.of(context)!.dialogTitleLogoutConfirm,
        message: AppLocalizations.of(context)!.dialogMessageLogoutConfirm,
        negativeActionText:
            AppLocalizations.of(context)!.dialogNegativeActionLogoutConfirm,
        positiveActionText:
            AppLocalizations.of(context)!.dialogPositiveActionLogoutConfirm,
      );
}
