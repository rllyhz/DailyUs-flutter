import 'package:daily_us/common/failure.dart';
import 'package:daily_us/domain/usecases/get_detail_story.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../utils/data_helpers.dart' as data_helpers;
import '../repositories/daily_us_repository_test.mocks.dart';

void main() {
  late GetDetailStory usecase;
  late MockDailyUsRepository mockRepository;

  setUp(() {
    mockRepository = MockDailyUsRepository();
    usecase = GetDetailStory(mockRepository);
  });

  test('Should get detail story from the repository', () async {
    when(
      mockRepository.getDetailStoryById(data_helpers.token, data_helpers.id),
    ).thenAnswer(
      (_) async => const Right(data_helpers.story),
    );

    final result = await usecase.execute(data_helpers.token, data_helpers.id);

    result.fold((left) {
      expect(left, isA<Failure>());
    }, (right) {
      expect(right, isNotNull);
      expect(right!.id, data_helpers.id);
    });
  });
}
