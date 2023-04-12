import 'dart:convert';

import 'package:daily_us/data/models/auth_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/data_helpers.dart';

void main() {
  group("Auth Response parsing json usecases", () {
    test("Should return successful response test", () {
      final response = AuthResponse.fromJson(json.decode(authSuccessJson));

      expect(response.error, false);
      expect(response.message, "success");
      expect(response.loginResult, isA<LoginResult>());
    });

    test("Should return failed response test", () {
      final response = AuthResponse.fromJson(json.decode(authFailedJson));

      expect(response.error, true);
      expect(response.message, "failed");
      expect(response.loginResult, isA<LoginResult>());
    });

    test("Should return the correct LoginResult in successful response test",
        () {
      final response = AuthResponse.fromJson(json.decode(authSuccessJson));

      const expectedUserId = "userId-example";
      const expectedName = "user_example";
      const expectedToken = "token-example-1234";

      expect(response.error, false);
      expect(response.loginResult.userId, expectedUserId);
      expect(response.loginResult.name, expectedName);
      expect(response.loginResult.token, expectedToken);
    });

    test("Should return the correct LoginResult in failed response test", () {
      final response = AuthResponse.fromJson(json.decode(authFailedJson));
      final loginResultWithDefaultValues = LoginResult.withDefaultValues();

      final expectedUserId = loginResultWithDefaultValues.userId;
      final expectedName = loginResultWithDefaultValues.name;
      final expectedToken = loginResultWithDefaultValues.token;

      expect(response.error, true);
      expect(response.loginResult.userId, expectedUserId);
      expect(response.loginResult.name, expectedName);
      expect(response.loginResult.token, expectedToken);
    });
  });

  test("Should return the same success json format when toJson getting invoked",
      () {
    final successfulResponse =
        AuthResponse.fromJson(json.decode(authSuccessJson));

    final generatedAuthRegisterSuccessJson = successfulResponse.toJson();

    final generatedSuccessfulResponse =
        AuthResponse.fromJson(json.decode(generatedAuthRegisterSuccessJson));

    expect(generatedSuccessfulResponse.error, successfulResponse.error);
    expect(generatedSuccessfulResponse.message, successfulResponse.message);
    expect(
      generatedSuccessfulResponse.loginResult.userId,
      successfulResponse.loginResult.userId,
    );
    expect(
      generatedSuccessfulResponse.loginResult.name,
      successfulResponse.loginResult.name,
    );
    expect(
      generatedSuccessfulResponse.loginResult.token,
      successfulResponse.loginResult.token,
    );
  });

  test("Should return the same success json format when toJson getting invoked",
      () {
    final successfulResponse =
        AuthResponse.fromJson(json.decode(authSuccessJson));

    final generatedSuccessfulJson = successfulResponse.toJson();

    final generatedSuccessfulResponse =
        AuthResponse.fromJson(json.decode(generatedSuccessfulJson));

    expect(generatedSuccessfulResponse.error, successfulResponse.error);
    expect(generatedSuccessfulResponse.message, successfulResponse.message);
    expect(
      generatedSuccessfulResponse.loginResult.userId,
      successfulResponse.loginResult.userId,
    );
    expect(
      generatedSuccessfulResponse.loginResult.name,
      successfulResponse.loginResult.name,
    );
    expect(
      generatedSuccessfulResponse.loginResult.token,
      successfulResponse.loginResult.token,
    );
  });

  test("Should return the same failed json format when toJson getting invoked",
      () {
    final failedResponse = AuthResponse.fromJson(json.decode(authFailedJson));

    final generatedFailedJson = failedResponse.toJson();

    final generatedFailedResponse =
        AuthResponse.fromJson(json.decode(generatedFailedJson));

    expect(generatedFailedResponse.error, failedResponse.error);
    expect(generatedFailedResponse.message, failedResponse.message);
    expect(
      generatedFailedResponse.loginResult.userId,
      failedResponse.loginResult.userId,
    );
    expect(
      generatedFailedResponse.loginResult.name,
      failedResponse.loginResult.name,
    );
    expect(
      generatedFailedResponse.loginResult.token,
      failedResponse.loginResult.token,
    );
  });
}
