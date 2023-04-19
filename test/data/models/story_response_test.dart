import 'package:daily_us/data/models/story_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/data_helpers.dart';

void main() {
  group("Story Response usecases", () {
    test("Should successfully parse json test", () {
      final storyResponse = StoryResponse.fromJson(exampleStory1);

      const expectedStoryId = "story-1";
      const expectedStoryName = "user-story-1";
      const expectedStoryDescription = "description-1";
      const expectedStoryPhotoUrl = "url-here";
      const expectedStoryCreatedAt = "11-05-2032";
      const expectedStoryLat = 0.2322;
      const expectedStoryLon = 0.434235;

      expect(storyResponse.id, expectedStoryId);
      expect(storyResponse.name, expectedStoryName);
      expect(storyResponse.description, expectedStoryDescription);
      expect(storyResponse.photoUrl, expectedStoryPhotoUrl);
      expect(storyResponse.createdAt, expectedStoryCreatedAt);
      expect(storyResponse.latitude, expectedStoryLat);
      expect(storyResponse.longitude, expectedStoryLon);
    });
  });
}
