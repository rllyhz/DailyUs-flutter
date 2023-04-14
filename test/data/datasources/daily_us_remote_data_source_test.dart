import 'dart:convert';

import 'package:daily_us/common/exception.dart';
import 'package:daily_us/data/datasources/daily_us_remote_data_source.dart';
import 'package:daily_us/data/models/auth_response.dart';
import 'package:daily_us/data/models/get_all_stories_response.dart';
import 'package:daily_us/data/models/get_detail_story_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

import '../../utils/data_helpers.dart';

void main() {
  late Dio mockApiClient;
  late DioAdapter dioAdapter;
  late DailyUsRemoteDataSourceImpl dataSource;

  const baseUrl = "https://test.com/";

  setUp(() {
    mockApiClient = Dio(
      BaseOptions(baseUrl: baseUrl),
    );
    dioAdapter = DioAdapter(dio: mockApiClient);

    dataSource = DailyUsRemoteDataSourceImpl(apiClient: mockApiClient);
  });

  group("DailyUsRemoteDataSource Testing Usecases", () {
    group("Perform register Testing Usecases", () {
      test('Should return true when successfully register', () async {
        dioAdapter.onPost(
          "/register",
          data: {
            "name": name,
            "email": email,
            "password": password,
          },
          (server) => server.reply(
            200,
            authSuccessJson,
            delay: const Duration(seconds: 1),
          ),
        );

        final result = await dataSource.register(name, email, password);

        expect(result, true);
      });

      test(
          'Should throw MissingParametersException when status code >= 400 && status code < 500',
          () async {
        dioAdapter.onPost(
          "/register",
          data: {
            "name": name,
            "email": email,
            "password": password,
          },
          (server) => server.reply(
            404,
            json.encode({"error": true, "message": "\"email\" is required"}),
            delay: const Duration(seconds: 1),
          ),
        );

        expect(
          () async => await dataSource.register(name, email, password),
          throwsA(isA<MissingParametersException>()),
        );
      });

      test('Should throw ServerException when status code >= 500', () async {
        dioAdapter.onPost(
          "/register",
          data: {
            "name": name,
            "email": email,
            "password": password,
          },
          (server) => server.reply(
            500,
            json.encode({"error": true, "message": "\"email\" is required"}),
            delay: const Duration(seconds: 1),
          ),
        );

        expect(
          () async => await dataSource.register(name, email, password),
          throwsA(isA<ServerException>()),
        );
      });
    });

    group("Perform login Testing Usecases", () {
      test('Should return data when successfully login', () async {
        dioAdapter.onPost(
          "/login",
          data: {
            "email": email,
            "password": password,
          },
          (server) => server.reply(
            200,
            authSuccessJson,
            delay: const Duration(seconds: 1),
          ),
        );

        final authResult = AuthResponse.fromJson(json.decode(authSuccessJson));

        final result = await dataSource.login(email, password);

        expect(result, isNotNull);
        expect(result!.id, authResult.loginResult.userId);
        expect(result.name, authResult.loginResult.name);
        expect(result.token, authResult.loginResult.token);
      });

      test(
          'Should throw MissingParametersException when status code >= 400 && status code < 500',
          () async {
        dioAdapter.onPost(
          "/login",
          data: {
            "email": email,
            "password": password,
          },
          (server) => server.reply(
            404,
            json.encode({"error": true, "message": "\"email\" is required"}),
            delay: const Duration(seconds: 1),
          ),
        );

        expect(
          () async => await dataSource.login(email, password),
          throwsA(isA<MissingParametersException>()),
        );
      });

      test('Should throw ServerException when status code >= 500', () async {
        dioAdapter.onPost(
          "/login",
          data: {
            "email": email,
            "password": password,
          },
          (server) => server.reply(
            500,
            authFailedJson,
            delay: const Duration(seconds: 1),
          ),
        );

        expect(
          () async => await dataSource.login(email, password),
          throwsA(isA<ServerException>()),
        );
      });
    });

    group("Perform getAllStories Testing Usecases", () {
      test('Should return data when successfully retrieve all stories',
          () async {
        dioAdapter.onGet(
          "/stories",
          headers: {
            "Authorization": "Bearer $token",
          },
          (server) => server.reply(
            200,
            getAllStoriesSuccessJson,
            delay: const Duration(seconds: 1),
          ),
        );

        final authResult = GetAllStoriesResponse.fromJson(
          json.decode(getAllStoriesSuccessJson),
        );

        final result = await dataSource.getAllStories(token);

        expect(result.length, greaterThan(0));
        expect(result.length, authResult.stories.length);
        expect(result[0].id, authResult.stories[0].id);
      });

      test(
          'Should throw RequestNotAllowedException when status code >= 400 && status code < 599',
          () async {
        dioAdapter.onGet(
          "/stories",
          headers: {
            "Authorization": "Bearer $token",
          },
          (server) => server.reply(
            400,
            getAllStoriesFailedJson,
            delay: const Duration(seconds: 1),
          ),
        );

        expect(
          () async => await dataSource.getAllStories(token),
          throwsA(isA<RequestNotAllowedException>()),
        );
      });
    });

    group("Perform getDetailStoryById Testing Usecases", () {
      test('Should return data when successfully retrieving detail story',
          () async {
        const storyId = "story-1";

        dioAdapter.onGet(
          "/detail/$storyId",
          headers: {
            "Authorization": "Bearer $token",
          },
          (server) => server.reply(
            200,
            getDetailStorySuccessJson,
            delay: const Duration(seconds: 1),
          ),
        );

        final authResult = GetDetailStoryResponse.fromJson(
          json.decode(getDetailStorySuccessJson),
        );
        final expectedStory = authResult.story;

        final result = await dataSource.getDetailStoryById(token, storyId);

        expect(result, isNotNull);
        expect(result!.id, storyId);
        expect(result.name, expectedStory.name);
        expect(result.createdAt, expectedStory.createdAt);
      });

      test('Should return null when status code >= 400 && status code < 500',
          () async {
        const storyId = "story-1";

        dioAdapter.onGet(
          "/detail/$storyId",
          headers: {
            "Authorization": "Bearer $token",
          },
          (server) => server.reply(
            404,
            getDetailStoryFailedJson,
            delay: const Duration(seconds: 1),
          ),
        );

        final result = await dataSource.getDetailStoryById(token, storyId);

        expect(result, isNull);
      });

      test('Should throw ServerException when status code >= 500', () async {
        const storyId = "story-1";

        dioAdapter.onGet(
          "/detail/$storyId",
          headers: {
            "Authorization": "Bearer $token",
          },
          (server) => server.reply(
            500,
            getDetailStoryFailedJson,
            delay: const Duration(seconds: 1),
          ),
        );

        expect(
          () async => await dataSource.getDetailStoryById(token, storyId),
          throwsA(isA<ServerException>()),
        );
      });
    });

    group("Perform uploadNewStory Testing Usecases", () {
      test('Should return true when successfully uploading new story',
          () async {
        final examplePhotoBytes = List.filled(20, 3);
        final exampleDescription = story.description;
        final exampleLat = story.latitude;
        final exampleLon = story.longitude;

        dioAdapter.onPost(
          "/stories",
          headers: {
            "Authorization": "Bearer $token",
          },
          data: FormData.fromMap({
            "description": exampleDescription,
            "photo": MultipartFile.fromBytes(examplePhotoBytes),
            "lat": exampleLat,
            "lon": exampleLon,
          }),
          (server) => server.reply(
            200,
            uploadNewStorySuccessJson,
            delay: const Duration(seconds: 1),
          ),
        );

        final result = await dataSource.uploadNewStory(
          token,
          examplePhotoBytes,
          exampleDescription,
          exampleLat,
          exampleLon,
        );

        expect(result, true);
      });

      test('Should return true when successfully uploading new story',
          () async {
        final examplePhotoBytes = List.filled(20, 3);
        final exampleDescription = story.description;
        final exampleLat = story.latitude;
        final exampleLon = story.longitude;

        dioAdapter.onPost(
          "/stories",
          headers: {
            "Authorization": "Bearer $token",
          },
          data: FormData.fromMap({
            "description": exampleDescription,
            "photo": MultipartFile.fromBytes(examplePhotoBytes),
            "lat": exampleLat,
            "lon": exampleLon,
          }),
          (server) => server.reply(
            404,
            uploadNewStoryFailedJson,
            delay: const Duration(seconds: 1),
          ),
        );

        final result = await dataSource.uploadNewStory(
          token,
          examplePhotoBytes,
          exampleDescription,
          exampleLat,
          exampleLon,
        );

        expect(result, false);
      });

      test('Should throw ServerException when status code >= 500', () async {
        final examplePhotoBytes = List.filled(20, 3);
        final exampleDescription = story.description;
        final exampleLat = story.latitude;
        final exampleLon = story.longitude;

        dioAdapter.onPost(
          "/stories",
          headers: {
            "Authorization": "Bearer $token",
          },
          data: FormData.fromMap({
            "description": exampleDescription,
            "photo": MultipartFile.fromBytes(examplePhotoBytes),
            "lat": exampleLat,
            "lon": exampleLon,
          }),
          (server) => server.reply(
            500,
            uploadNewStoryFailedJson,
            delay: const Duration(seconds: 1),
          ),
        );

        expect(
          () async => await dataSource.uploadNewStory(
            token,
            examplePhotoBytes,
            exampleDescription,
            exampleLat,
            exampleLon,
          ),
          throwsA(isA<ServerException>()),
        );
      });
    });
    //
  });
}
