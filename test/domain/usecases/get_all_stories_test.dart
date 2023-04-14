import 'package:daily_us/domain/entities/story.dart';
import 'package:daily_us/domain/usecases/get_all_stories.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../repositories/daily_us_repository_test.mocks.dart';

void main() {
  late GetAllStories usecase;
  late MockDailyUsRepository mockRepository;

  setUp(() {
    mockRepository = MockDailyUsRepository();
    usecase = GetAllStories(mockRepository);
  });

  const token = "example-user-token";
  const story = Story(
    id: "id",
    name: "story",
    description: "description",
    photoUrl: "url",
    createdAt: "21-05-2021",
    latitude: 20.0054,
    longitude: 2334.05454,
  );
  const stories = [story, story, story];

  test('Should get all stories from the repository', () async {
    when(mockRepository.getAllStories(token)).thenAnswer(
      (_) async => const Right(stories),
    );

    final result = await usecase.execute(token);

    expect(result, const Right(stories));
  });
}
