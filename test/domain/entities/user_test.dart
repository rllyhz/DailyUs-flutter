import 'dart:convert';

import 'package:daily_us/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/data_helpers.dart';

void main() {
  group("User usecases", () {
    test("Should successfully parse the json test", () {
      final actualUser = User.fromJson(json.decode(exampleUser));

      const expectedUserId = "user-1";
      const expectedUserName = "username-1";
      const expectedUserToken = "example-token-user-1";

      expect(actualUser, isNotNull);
      expect(actualUser, isA<User>());
      expect(actualUser.id, expectedUserId);
      expect(actualUser.name, expectedUserName);
      expect(actualUser.token, expectedUserToken);
    });

    test("Should return the same json format when toJson getting invoked", () {
      final expectedUser = User.fromJson(json.decode(exampleUser));

      final generatedUserJson = expectedUser.toJson();

      final actualUser = User.fromJson(
        json.decode(generatedUserJson),
      );

      expect(actualUser.id, expectedUser.id);
      expect(actualUser.name, expectedUser.name);
      expect(actualUser.token, expectedUser.token);
    });
  });
}
