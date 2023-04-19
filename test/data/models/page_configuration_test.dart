import 'package:daily_us/data/models/page_configuration.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Page Configuration test", () {
    test("Should return the correct unknown configuration", () {
      var configuration = PageConfiguration.unknown();
      expect(configuration.unknown, true);
    });

    test("Should return the correct splash configuration", () {
      var configuration = PageConfiguration.splash();
      expect(configuration.loggedIn, isNull);
    });

    test("Should return the correct login configuration", () {
      var configuration = PageConfiguration.login();
      expect(configuration.loggedIn, isNotNull);
      expect(configuration.loggedIn, false);
    });

    test("Should return the correct register configuration", () {
      var configuration = PageConfiguration.register();
      expect(configuration.loggedIn, false);
      expect(configuration.register, true);
    });

    test("Should return the correct onBoarding configuration", () {
      var configuration = PageConfiguration.onBoarding();
      expect(configuration.loggedIn, isNull);
      expect(configuration.register, false);
      expect(configuration.onBoarding, true);
    });

    test("Should return the correct main/loggedin configuration", () {
      var configuration = PageConfiguration.main();
      expect(configuration.register, false);
      expect(configuration.onBoarding, false);
      expect(configuration.loggedIn, true);
      expect(configuration.storyId, isNull);
    });

    test("Should return the correct detail configuration", () {
      var storyIdTest = 'story-id-test';
      var configuration = PageConfiguration.detail(storyIdTest);
      expect(configuration.loggedIn, true);
      expect(configuration.storyId, isNotNull);
    });
    //
  });
}
