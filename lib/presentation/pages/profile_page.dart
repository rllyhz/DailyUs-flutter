import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/helpers.dart';
import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/common/ui/colors.dart';
import 'package:daily_us/common/ui/theme.dart';
import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/domain/usecases/get_localization_data.dart';
import 'package:daily_us/presentation/widgets/decorations/text_decorations.dart';
import 'package:flutter/material.dart';
import 'package:daily_us/injection.dart' as di;

class ProfilePage extends StatefulWidget {
  static const valueKey = ValueKey("ProfilePage");

  const ProfilePage({
    super.key,
    required this.onShowConfirmLogout,
    required this.onShowLanguageChangeDialog,
    required this.authInfo,
  });

  final void Function() onShowConfirmLogout;
  final void Function(List<Locale>, Locale) onShowLanguageChangeDialog;
  final AuthInfo authInfo;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late GetLocalizationData _getLocalizationDataUsecase;

  @override
  void initState() {
    super.initState();
    _getLocalizationDataUsecase = di.locator<GetLocalizationData>();
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
                      getFormattedName(widget.authInfo.user.name),
                      style: profileFullNameTextStyle(),
                    ),
                    const SizedBox(
                      height: 46.0,
                    ),
                    appOutlinedButton(
                      text: AppLocalizations.of(context)!.buttonChangeLanguage,
                      onPressed: () {
                        var locales = AppLocalizations.supportedLocales;
                        var activeLocale =
                            _getLocalizationDataUsecase.execute().currentLocale;

                        widget.onShowLanguageChangeDialog(
                          locales,
                          activeLocale,
                        );
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
                onPressed: widget.onShowConfirmLogout,
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
