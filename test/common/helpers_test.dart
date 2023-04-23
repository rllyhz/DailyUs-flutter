import 'package:daily_us/common/helpers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Helpers test', () {
    group('validateEmailFormat test', () {
      test('Should return false if email doesn\'t contain a "@" character', () {
        expect(validateEmailFormat('rullyihza.com'), false);
        expect(validateEmailFormat('rully\$ihza.com'), false);
      });

      test('Should return false if email doesn\'t contain domain name', () {
        expect(validateEmailFormat('rullyihza'), false);
        expect(validateEmailFormat('rullyemail'), false);
      });

      test('Should return true if email has the correct format', () {
        expect(validateEmailFormat('rullyihza@mail.com'), true);
        expect(validateEmailFormat('email_test@yahoo.id'), true);
      });
    });

    group('validatePasswordFormat test', () {
      test('Should return false if password length is less than 6', () {
        expect(validatePasswordFormat('mine'), false);
        expect(validatePasswordFormat('passw'), false);
      });

      test('Should return false if password length is greater than 6', () {
        expect(validatePasswordFormat('mysecret'), true);
        expect(validatePasswordFormat('my_very_secret_password'), true);
      });

      test('Should return false if password length is equal to 6', () {
        expect(validatePasswordFormat('secret'), true);
        expect(validatePasswordFormat('keykey'), true);
      });
    });

    group('getFirstName test', () {
      test(
          'Should return only first name if fullname has more name than first name',
          () {
        expect(getFirstName('Rully Ihza'), 'Rully');
        expect(getFirstName('Rully Ihza Mahendra'), 'Rully');
      });

      test('Should return first name if fullname has only first name', () {
        expect(getFirstName('Rully'), 'Rully');
        expect(getFirstName('Niken'), 'Niken');
      });
    });

    group('getFormattedName test', () {
      test('Should return only first name if fullname has only first name', () {
        expect(getFormattedName('Rully'), 'Rully');
        expect(getFormattedName('Niken'), 'Niken');
      });

      test(
          'Should return only first name and middle name if fullname has more name than 2 names',
          () {
        expect(getFormattedName('Rully Ihza'), 'Rully Ihza');
        expect(getFormattedName('Rully Ihza Mahendra'), 'Rully Ihza');
      });

      test(
          'Should return first name and initial of the rest names if first and middle names has length is greater than 10 characters',
          () {
        expect(getFormattedName('Ahmad Syu\'aib Rayyan'), 'Ahmad SR');
        expect(getFormattedName('Aditya Permana Sanjaya'), 'Aditya PS');
      });
    });

    group('getFormattedName test', () {
      test('Should return only first name and middle name', () {
        expect(getFormattedName('Rully Ihza Mahendra'), 'Rully Ihza');
        expect(getFormattedName('Nur Aisyah'), 'Nur Aisyah');
        expect(getFormattedName('Hadi'), 'Hadi');
      });

      test(
          'Should return only first name and abbreviations for the rest if length > 10',
          () {
        expect(getFormattedName('Muhammad Haikal F'), 'Muhammad HF');
        expect(getFormattedName('Ahmad Syahrawi Alrahma'), 'Ahmad SA');
      });
    });

    group('getFormattedLanguageOptionOf test', () {
      Map<String, String> validCountryDetail1 = {
        "name": "English",
        "language_code": "en"
      };

      Map<String, String> validCountryDetail2 = {
        "name": "Indonesia",
        "language_code": "id"
      };

      Map<String, String> nonValidCountryDetail1 = {
        "name": "English",
      };

      Map<String, String> nonValidCountryDetail2 = {};

      test('Should return the correct format of language option', () {
        expect(
          getFormattedLanguageOptionOf(validCountryDetail1),
          "English - en",
        );

        expect(
          getFormattedLanguageOptionOf(validCountryDetail2),
          "Indonesia - id",
        );

        expect(
          getFormattedLanguageOptionOf(nonValidCountryDetail1),
          "English - .",
        );

        expect(
          getFormattedLanguageOptionOf(nonValidCountryDetail2),
          ". - .",
        );

        expect(
          getFormattedLanguageOptionOf(nonValidCountryDetail2,
              defaultValue: "#"),
          "# - #",
        );
        //
      });
    });
  });
}
