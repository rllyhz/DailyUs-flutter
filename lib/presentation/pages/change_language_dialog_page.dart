import 'package:daily_us/common/helpers.dart';
import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/common/ui/colors.dart';
import 'package:daily_us/presentation/widgets/daily_us_dialog.dart';
import 'package:daily_us/presentation/widgets/decorations/text_decorations.dart';
import 'package:flutter/material.dart';

class ChangeLanguageDialogPage extends StatelessWidget {
  static const valueKey = ValueKey("ChangeLanguageDialogPage");

  const ChangeLanguageDialogPage({
    super.key,
    required this.locales,
    required this.activeLocale,
    required this.onCancel,
    required this.onUpdateLocalization,
  });

  final List<Locale> locales;
  final Locale activeLocale;
  final void Function() onCancel;
  final void Function(Locale, String, String) onUpdateLocalization;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.2),
      body: Center(
        child: DailyUsDialog(
          showActions: false,
          title: Text(
            AppLocalizations.of(context)!.buttonChangeLanguage,
            textAlign: TextAlign.center,
            style: titleTextStyle(),
          ),
          content: Column(
            children: locales.map(
              (locale) {
                var countryDetail = getCountryDetailOfLocale(context, locale);
                var languageOption =
                    getFormattedLanguageOptionOf(countryDetail);
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
                      _onLanguageChanged(context, locale);
                    },
                    child: Text(
                      languageOption,
                      style: homeCardDescriptionTextStyle(),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }

  void _onLanguageChanged(BuildContext context, Locale selectedLocale) {
    if (!context.mounted) return;

    var successMessage = AppLocalizations.of(context)!.updateLanguageSuccess;
    var failedMessage = AppLocalizations.of(context)!.updateLanguageFailed;

    onUpdateLocalization(selectedLocale, successMessage, failedMessage);
  }
}
