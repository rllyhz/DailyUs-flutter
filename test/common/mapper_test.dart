import 'package:daily_us/common/mapper.dart';
import 'package:daily_us/data/models/story_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('storiesResponseToEntities test', () {
    var expectedTotalStories = 10;
    var indexes = List.generate(expectedTotalStories, (index) => index);
    var dummyStoriesResponse = List<StoryResponse>.empty(growable: true);

    setUp(() {
      for (var index in indexes) {
        dummyStoriesResponse.add(StoryResponse(
          id: "index-$index",
          name: "name-$index",
          description: "description-$index",
          photoUrl: "photoUrl-$index",
          createdAt: "createdAt-$index",
          latitude: (12 * index).toDouble(),
          longitude: (11 * index).toDouble(),
        ));
      }
    });

    tearDown(() {
      dummyStoriesResponse = List<StoryResponse>.empty(growable: true);
    });

    test(
        'Should return the expected total story when storiesResponseToEntities get invoked',
        () {
      var result = storiesResponseToEntities(dummyStoriesResponse);
      var actualTotalStories = result.length;
      expect(actualTotalStories, expectedTotalStories);
    });

    test(
        'Should return the correct list story when storiesResponseToEntities get invoked',
        () {
      var result = storiesResponseToEntities(dummyStoriesResponse);
      var expectedIndex = 3;

      var actualStory = result[expectedIndex];
      expect(actualStory.id, "index-$expectedIndex");
      expect(actualStory.name, "name-$expectedIndex");
      expect(actualStory.description, "description-$expectedIndex");
    });
  });

  group('detailResponseToEntity test', () {
    const dummyStoryResponse = StoryResponse(
      id: 'dummy-id',
      name: 'dummy-name',
      description: 'dummy-description',
      photoUrl: 'dummy-photoUrl',
      createdAt: 'dummy-createdAt',
      latitude: 0.0,
      longitude: 0.0,
    );

    test(
        'Should return the expected story when detailResponseToEntity get invoked',
        () {
      var story = detailResponseToEntity(dummyStoryResponse);

      expect(story.id, 'dummy-id');
      expect(story.name, 'dummy-name');
      expect(story.description, 'dummy-description');
      expect(story.photoUrl, 'dummy-photoUrl');
      expect(story.createdAt, 'dummy-createdAt');
    });
  });
}
