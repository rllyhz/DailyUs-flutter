import 'dart:convert';

import 'package:daily_us/domain/entities/story.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Story Usecase", () {
    test("Should successfully parse story into json format", () {
      const story = Story(
        id: "story-id",
        name: "story-name",
        description: "story-description",
        photoUrl: "story-photoUrl",
        createdAt: "story-createdAt",
        latitude: 0.0,
        longitude: 0.0,
      );

      var expectedJson = json.encode({
        "id": 'story-id',
        "name": 'story-name',
        "description": 'story-description',
        "photoUrl": 'story-photoUrl',
        "createdAt": 'story-createdAt',
        "lat": 0.0,
        "lon": 0.0,
      });

      final actualJson = story.toJson();

      expect(actualJson, expectedJson);
    });
  });
}
