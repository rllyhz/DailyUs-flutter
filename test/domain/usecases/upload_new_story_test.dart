import 'package:daily_us/common/failure.dart';
import 'package:daily_us/domain/usecases/upload_new_story.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../utils/data_helpers.dart' as data_helpers;
import '../repositories/daily_us_repository_test.mocks.dart';

void main() {
  late UploadNewStory usecase;
  late MockDailyUsRepository mockRepository;

  setUp(() {
    mockRepository = MockDailyUsRepository();
    usecase = UploadNewStory(mockRepository);
  });

  test('Should be able to perform uploadNewStory from the repository',
      () async {
    when(
      mockRepository.uploadNewStory(
        data_helpers.token,
        List.filled(20, 3),
        data_helpers.story.description,
        data_helpers.story.latitude,
        data_helpers.story.longitude,
      ),
    ).thenAnswer((_) async => const Right(true));

    final result = await usecase.execute(
      data_helpers.token,
      List.filled(20, 3),
      data_helpers.story.description,
      data_helpers.story.latitude,
      data_helpers.story.longitude,
    );

    result.fold((left) {
      expect(left, isA<Failure>());
    }, (right) {
      expect(right, true);
    });
  });
}
