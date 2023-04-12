import 'dart:convert';

import 'package:daily_us/data/models/get_detail_story_response.dart';
import 'package:daily_us/data/models/story_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/data_helpers.dart';

void main() {
  group("Get Detail Story Response Usecases", () {
    test("Should return successful response test", () {
      final response = GetDetailStoryResponse.fromJson(
        json.decode(getDetailStorySuccessJson),
      );

      const expectedStoryId = "story-1";
      const expectedStoryName = "user-story-1";

      expect(response.error, false);
      expect(response.message, "success");
      expect(response.story.id, expectedStoryId);
      expect(response.story.name, expectedStoryName);
    });

    test("Should return failed response test", () {
      final response = GetDetailStoryResponse.fromJson(
        json.decode(getDetailStoryFailedJson),
      );

      final expectedStory = StoryResponse.withDefaultValues();

      expect(response.error, true);
      expect(response.message, "failed");
      expect(response.story.id, expectedStory.id);
      expect(response.story.name, expectedStory.name);
    });
  });
}
