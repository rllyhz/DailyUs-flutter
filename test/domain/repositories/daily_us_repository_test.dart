import 'package:daily_us/common/failure.dart';
import 'package:daily_us/domain/entities/story.dart';
import 'package:daily_us/domain/entities/user.dart';
import 'package:daily_us/domain/repositories/daily_us_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../utils/data_helpers.dart' as data_helpers;
import 'daily_us_repository_test.mocks.dart';

@GenerateMocks([DailyUsRepository])
void main() {
  group("DailyUsRepository Usecases", () {
    test("Should be able to perform register contract", () async {
      final repository = MockDailyUsRepository();

      when(
        repository.register(
          data_helpers.name,
          data_helpers.email,
          data_helpers.password,
        ),
      ).thenAnswer(
        (_) => Future.value(const Right(true)),
      );

      final result = await repository.register(
        data_helpers.name,
        data_helpers.email,
        data_helpers.password,
      );

      result.fold(
        (left) => {
          expect(left, isA<Failure>()),
        },
        (right) => {
          expect(right, isA<bool>()),
          expect(right, true),
        },
      );
    });

    test("Should be able to perform login contract", () async {
      final repository = MockDailyUsRepository();

      when(
        repository.login(data_helpers.email, data_helpers.password),
      ).thenAnswer(
        (_) => Future.value(
          const Right(User(
            id: data_helpers.id,
            token: data_helpers.token,
            name: data_helpers.name,
            email: data_helpers.email,
          )),
        ),
      );

      final result = await repository.login(
        data_helpers.email,
        data_helpers.password,
      );

      result.fold(
        (left) => {
          expect(left, isA<Failure>()),
        },
        (right) => {
          expect(right, isA<User>()),
          expect(
            right,
            const User(
              id: data_helpers.id,
              token: data_helpers.token,
              name: data_helpers.name,
              email: data_helpers.email,
            ),
          ),
        },
      );
    });

    test("Should be able to perform logout contract", () {
      final repository = MockDailyUsRepository();

      when(
        repository.logout(),
      ).thenAnswer((_) => true);

      final result = repository.logout();

      expect(result, isA<bool>());
      expect(result, true);
    });

    test("Should be able to perform getAllStories contract", () async {
      final repository = MockDailyUsRepository();

      when(
        repository.getAllStories(null),
      ).thenAnswer((_) => Future.value(Right(List.empty())));

      final result = await repository.getAllStories(null);

      result.fold(
        (left) => {
          expect(left, isA<Failure>()),
        },
        (right) => {
          expect(right, isA<List<Story>>()),
          expect(right.length, 0),
        },
      );
    });

    test("Should be able to perform getDetailStoryById contract", () async {
      final repository = MockDailyUsRepository();

      when(
        repository.getDetailStoryById(data_helpers.token, data_helpers.id),
      ).thenAnswer((_) => Future.value(const Right(data_helpers.story)));

      final result = await repository.getDetailStoryById(
        data_helpers.token,
        data_helpers.id,
      );

      result.fold(
        (left) => {
          expect(left, isA<Failure>()),
        },
        (right) => {
          expect(right, isA<Story>()),
          expect(right, isNotNull),
          expect(right.id, data_helpers.id),
        },
      );
    });

    test("Should be able to perform uploadNewStory contract", () async {
      final repository = MockDailyUsRepository();

      final description = data_helpers.story.description;
      final lat = data_helpers.story.latitude;
      final lon = data_helpers.story.longitude;

      when(
        repository.uploadNewStory(
          data_helpers.token,
          List<int>.filled(20, 2),
          description,
          lat,
          lon,
        ),
      ).thenAnswer((_) => Future.value(const Right(true)));

      final result = await repository.uploadNewStory(
        data_helpers.token,
        List<int>.filled(20, 2),
        description,
        lat,
        lon,
      );

      result.fold(
        (left) => {
          expect(left, isA<Failure>()),
        },
        (right) => {
          expect(right, true),
        },
      );
    });

    test("Should be able to perform getAuthInfo contract", () {
      final repository = MockDailyUsRepository();

      when(
        repository.getAuthInfo(),
      ).thenAnswer((_) => data_helpers.authInfo);

      final result = repository.getAuthInfo();

      expect(result.isAlreadyLoggedIn, true);
      expect(result.user.id, data_helpers.id);
    });

    test("Should be able to perform updateAuthInfo contract", () async {
      final repository = MockDailyUsRepository();

      when(
        repository.updateAuthInfo(data_helpers.authInfo),
      ).thenAnswer((_) => Future.value(true));

      final result = await repository.updateAuthInfo(data_helpers.authInfo);

      expect(result, true);
    });
  });
}
