import 'package:daily_us/common/constants.dart';
import 'package:daily_us/common/helpers.dart';
import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/common/ui/colors.dart';
import 'package:daily_us/common/ui/theme.dart';
import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/domain/usecases/get_localization_data.dart';
import 'package:daily_us/presentation/bloc/profile/profile_bloc.dart';
import 'package:daily_us/presentation/widgets/decorations/text_decorations.dart';
import 'package:flutter/material.dart';
import 'package:daily_us/injection.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  static const valueKey = ValueKey("ProfilePage");

  const ProfilePage({
    super.key,
    required this.onLogout,
    required this.onUpdateLocalization,
    required this.authInfo,
  });

  final void Function() onLogout;
  final void Function(Locale, String, String) onUpdateLocalization;
  final AuthInfo authInfo;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GetLocalizationData getLocalizationDataUsecase =
      di.locator<GetLocalizationData>();

  bool _isUpdateLanguageDialogActive = false;
  bool _isLogoutDialogActive = false;

  @override
  void initState() {
    super.initState();

    context.read<ProfileBloc>().stream.listen((state) async {
      if (state is ProfileStateLogoutError && mounted) {
        showToast(
          getFailureMessage(context, state.failure),
        );
      } else if (state is ProfileStateLogoutSuccess) {
        widget.onLogout();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_isUpdateLanguageDialogActive || _isLogoutDialogActive) {
          Navigator.of(context, rootNavigator: true).pop();
          _isUpdateLanguageDialogActive = false;
          _isLogoutDialogActive = false;
          return false;
        } else {
          return true;
        }
      },
      child: SafeArea(
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
                        text:
                            AppLocalizations.of(context)!.buttonChangeLanguage,
                        onPressed: () {
                          _showUpdateLanguageDialog(context);
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
                    await _showLogoutDialog(context, () {
                      context.read<ProfileBloc>().add(OnLogoutEvent());
                    });
                  },
                  borderColor: secondaryColor,
                  color: secondaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showLogoutDialog(
      BuildContext context, void Function() onLogout) async {
    _isLogoutDialogActive = true;

    await appDialog(
      context: context,
      title: AppLocalizations.of(context)!.dialogTitleLogoutConfirm,
      message: AppLocalizations.of(context)!.dialogMessageLogoutConfirm,
      negativeActionText:
          AppLocalizations.of(context)!.dialogNegativeActionLogoutConfirm,
      positiveActionText:
          AppLocalizations.of(context)!.dialogPositiveActionLogoutConfirm,
      postiveActionCallback: onLogout,
    );
  }

  void _showUpdateLanguageDialog(BuildContext context) {
    _isUpdateLanguageDialogActive = true;
    var locales = AppLocalizations.supportedLocales;
    var activeLocale = getLocalizationDataUsecase.execute().currentLocale;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: AppLocalizations.of(context)!.buttonChangeLanguage,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (context, anim, secondaryAnim) {
        var totalHeightScreen = MediaQuery.of(context).size.height;
        var dialogHeight = totalHeightScreen * 0.8;
        if (totalHeightScreen >= 520.0) {
          dialogHeight = 320.0;
        }

        return Center(
          child: SizedBox(
            height: dialogHeight,
            child: Dialog(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 32.0,
                  left: 12.0,
                  right: 12.0,
                  bottom: 0.0,
                ),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.buttonChangeLanguage,
                      style: titleTextStyle(),
                    ),
                    const SizedBox(
                      height: 32.0,
                    ),
                    Column(
                      children: locales.map(
                        (locale) {
                          var countryDetail =
                              getCountryDetailOfLocale(context, locale);
                          var isSelected =
                              locale.languageCode == activeLocale.languageCode;

                          return SizedBox(
                            width: double.maxFinite,
                            child: TextButton(
                              style: ButtonStyle(
                                backgroundColor: isSelected
                                    ? MaterialStateProperty.all(greyColor)
                                    : null,
                              ),
                              onPressed: () {
                                _onLanguageSelected(locale);
                              },
                              child: Text(
                                "${countryDetail['name']} - ${countryDetail['language_code']}",
                                style: homeCardDescriptionTextStyle(),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        Tween<Offset> tween;
        if (anim.status == AnimationStatus.reverse) {
          tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
        } else {
          tween = Tween(begin: const Offset(0, 0), end: Offset.zero);
        }

        return SlideTransition(
          position: tween.animate(anim),
          child: FadeTransition(
            opacity: anim,
            child: child,
          ),
        );
      },
    );
  }

  void _onLanguageSelected(Locale locale) {
    if (mounted) {
      Navigator.of(context, rootNavigator: true).pop();
      var successMessage = AppLocalizations.of(context)!.updateLanguageSuccess;
      var failedMessage = AppLocalizations.of(context)!.updateLanguageFailed;

      widget.onUpdateLocalization(locale, successMessage, failedMessage);
    }
  }
}
