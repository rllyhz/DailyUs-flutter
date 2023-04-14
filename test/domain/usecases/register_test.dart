import 'package:daily_us/common/failure.dart';
import 'package:daily_us/domain/usecases/register.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../utils/data_helpers.dart' as data_helpers;
import '../repositories/daily_us_repository_test.mocks.dart';

void main() {
  late Register usecase;
  late MockDailyUsRepository mockRepository;

  setUp(() {
    mockRepository = MockDailyUsRepository();
    usecase = Register(mockRepository);
  });

  test('Should be able to perform register from the repository', () async {
    when(
      mockRepository.register(
        data_helpers.name,
        data_helpers.email,
        data_helpers.password,
      ),
    ).thenAnswer((_) async => const Right(true));

    final result = await usecase.execute(
      data_helpers.name,
      data_helpers.email,
      data_helpers.password,
    );

    result.fold((left) {
      expect(left, isA<Failure>());
    }, (right) {
      expect(right, true);
    });
  });
}
