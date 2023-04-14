import 'package:daily_us/common/failure.dart';
import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/domain/entities/story.dart';
import 'package:daily_us/domain/entities/user.dart';
import 'package:daily_us/domain/repositories/daily_us_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'daily_us_repository_test.mocks.dart';

@GenerateMocks([DailyUsRepository])
void main() {
  group("DailyUsRepository Usecases", () {
    const id = "user-test";
    const name = "nameTest";
    const email = "nameTest@mail.com";
    const password = "nameTest123";
    const token = "example-user-token";

    const story = Story(
      id: id,
      name: name,
      description: "description",
      photoUrl: "url",
      createdAt: "21-06-43",
      latitude: 034.5454,
      longitude: 032.2227,
    );

    const authInfo = AuthInfo(
      isAlreadyLoggedIn: true,
      user: User(id: id, token: token, name: name),
    );

    test("Should be able to perform register contract", () async {
      final repository = MockDailyUsRepository();

      when(
        repository.register(name, email, password),
      ).thenAnswer(
        (_) => Future.value(const Right(true)),
      );

      final result = await repository.register(name, email, password);

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
        repository.login(email, password),
      ).thenAnswer(
        (_) => Future.value(
          const Right(User(id: id, token: token, name: name)),
        ),
      );

      final result = await repository.login(email, password);

      result.fold(
        (left) => {
          expect(left, isA<Failure>()),
        },
        (right) => {
          expect(right, isA<User>()),
          expect(right, const User(id: id, token: token, name: name)),
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
        repository.getDetailStoryById(token, id),
      ).thenAnswer((_) => Future.value(const Right(story)));

      final result = await repository.getDetailStoryById(token, id);

      result.fold(
        (left) => {
          expect(left, isA<Failure>()),
        },
        (right) => {
          expect(right, isA<Story>()),
          expect(right, isNotNull),
          expect(right!.id, id),
        },
      );
    });

    test("Should be able to perform uploadNewStory contract", () async {
      final repository = MockDailyUsRepository();

      final description = story.description;
      final lat = story.latitude;
      final lon = story.longitude;

      when(
        repository.uploadNewStory(
          token,
          List<int>.filled(20, 2),
          description,
          lat,
          lon,
        ),
      ).thenAnswer((_) => Future.value(const Right(true)));

      final result = await repository.uploadNewStory(
        token,
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
      ).thenAnswer((_) => authInfo);

      final result = repository.getAuthInfo();

      expect(result.isAlreadyLoggedIn, true);
      expect(result.user.id, id);
    });

    test("Should be able to perform updateAuthInfo contract", () async {
      final repository = MockDailyUsRepository();

      when(
        repository.updateAuthInfo(authInfo),
      ).thenAnswer((_) => Future.value(true));

      final result = await repository.updateAuthInfo(authInfo);

      expect(result, true);
    });
  });
}
