import 'package:daily_us/data/models/story_response.dart';
import 'package:daily_us/domain/entities/story.dart';

List<Story> storiesResponseToEntities(List<StoryResponse> storiesResponse) =>
    storiesResponse
        .map((item) => Story(
              id: item.id,
              name: item.name,
              description: item.description,
              photoUrl: item.photoUrl,
              createdAt: item.createdAt,
              latitude: item.latitude,
              longitude: item.longitude,
            ))
        .toList();

Story detailResponseToEntity(StoryResponse detailResponse) => Story(
      id: detailResponse.id,
      name: detailResponse.name,
      description: detailResponse.description,
      photoUrl: detailResponse.photoUrl,
      createdAt: detailResponse.createdAt,
      latitude: detailResponse.latitude,
      longitude: detailResponse.longitude,
    );
