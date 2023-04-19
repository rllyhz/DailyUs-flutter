import 'dart:convert';

import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/data_helpers.dart';

void main() {
  group("Auth Info Usecase", () {
    test("Should successfully parse the logged in json test", () {
      final authInfo = AuthInfo.fromJson(authInfoLoggedInJson);

      const expectedUserId = "user-1";
      const expectedUserName = "username-1";
      const expectedUserToken = "example-token-user-1";
      const expectedUserEmail = "example_email@mail.com";

      expect(authInfo.isAlreadyLoggedIn, true);
      expect(authInfo.user, isA<User>());
      expect(authInfo.user.id, expectedUserId);
      expect(authInfo.user.name, expectedUserName);
      expect(authInfo.user.token, expectedUserToken);
      expect(authInfo.user.email, expectedUserEmail);
    });

    test("Should successfully parse the not logged in json test", () {
      final authInfo = AuthInfo.fromJson(authInfoNotLoggedInJson);

      expect(authInfo.isAlreadyLoggedIn, false);
    });

    test(
        "Should return the same logged-in json format when toJson getting invoked",
        () {
      final expectedLoggedInResponse = AuthInfo.fromJson(
        authInfoLoggedInJson,
      );

      final generatedAuthInfoLoggedInJson = expectedLoggedInResponse.toJson();

      final actualLoggedInResponse = AuthInfo.fromJson(
        json.decode(generatedAuthInfoLoggedInJson),
      );

      expect(
        actualLoggedInResponse.isAlreadyLoggedIn,
        expectedLoggedInResponse.isAlreadyLoggedIn,
      );
      expect(
        actualLoggedInResponse.user.id,
        expectedLoggedInResponse.user.id,
      );
      expect(
        actualLoggedInResponse.user.name,
        expectedLoggedInResponse.user.name,
      );
      expect(
        actualLoggedInResponse.user.token,
        expectedLoggedInResponse.user.token,
      );
      expect(
        actualLoggedInResponse.user.email,
        expectedLoggedInResponse.user.email,
      );
    });

    test(
        "Should return the same not-logged-in json format when toJson getting invoked",
        () {
      final expectedNotLoggedInResponse = AuthInfo.fromJson(
        authInfoNotLoggedInJson,
      );

      final generatedAuthInfoNotLoggedInJson =
          expectedNotLoggedInResponse.toJson();

      final actualNotLoggedInResponse = AuthInfo.fromJson(
        json.decode(generatedAuthInfoNotLoggedInJson),
      );

      expect(
        actualNotLoggedInResponse.isAlreadyLoggedIn,
        expectedNotLoggedInResponse.isAlreadyLoggedIn,
      );
    });
  });
}
