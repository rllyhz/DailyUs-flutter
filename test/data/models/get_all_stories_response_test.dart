import 'dart:convert';

import 'package:daily_us/data/models/get_all_stories_response.dart';
import 'package:daily_us/data/models/story_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/data_helpers.dart';

void main() {
  group("Get All Stories Response parsing json usecases", () {
    test("Should return successful response test", () {
      final response = GetAllStoriesResponse.fromJson(getAllStoriesSuccessJson);

      const expectedStoryId = "story-1"; // index-0
      const expectedTotalOfStories = 3; // 3 items in dummy json

      expect(response.error, false);
      expect(response.message, "success");
      expect(response.stories, isA<List<StoryResponse>>());
      expect(response.stories.length, expectedTotalOfStories);
      expect(response.stories[0].id, expectedStoryId);
    });

    test("Should return failed response test", () {
      final response = GetAllStoriesResponse.fromJson(getAllStoriesFailedJson);

      const expectedTotalOfStories = 0; // no items in failed response json

      expect(response.error, true);
      expect(response.message, "failed");
      expect(response.stories, isA<List<StoryResponse>>());
      expect(response.stories.length, expectedTotalOfStories);
    });
  });
}
