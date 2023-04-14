import 'package:daily_us/common/failure.dart';
import 'package:daily_us/domain/entities/user.dart';
import 'package:daily_us/domain/usecases/login.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../utils/data_helpers.dart' as data_helpers;
import '../repositories/daily_us_repository_test.mocks.dart';

void main() {
  late Login usecase;
  late MockDailyUsRepository mockRepository;

  setUp(() {
    mockRepository = MockDailyUsRepository();
    usecase = Login(mockRepository);
  });

  test('Should be able to perform login from the repository', () async {
    when(
      mockRepository.login(data_helpers.email, data_helpers.password),
    ).thenAnswer(
      (_) async => const Right(
        User(
          id: data_helpers.id,
          token: data_helpers.token,
          name: data_helpers.name,
        ),
      ),
    );

    final result = await usecase.execute(
      data_helpers.email,
      data_helpers.password,
    );

    result.fold((left) {
      expect(left, isA<Failure>());
    }, (right) {
      expect(right, isNotNull);
      expect(right!.id, data_helpers.id);
      expect(right.token, data_helpers.token);
    });
  });
}
