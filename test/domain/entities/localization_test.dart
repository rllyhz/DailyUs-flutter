import 'dart:convert';

import 'package:daily_us/domain/entities/localization.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/data_helpers.dart';

void main() {
  group("Localization Usecase", () {
    test("Should successfully parse localization and return the correct locale",
        () {
      var expectedLocale = localeTest;

      var localization = Localization.fromJson({
        "languageCode": localeTest.languageCode,
      });

      var actualLocale = localization.currentLocale;

      expect(actualLocale, expectedLocale);
      expect(actualLocale.languageCode, expectedLocale.languageCode);
    });
  });
}
