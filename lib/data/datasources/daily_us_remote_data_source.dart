import 'dart:convert';

import 'package:daily_us/common/exception.dart';
import 'package:daily_us/common/mapper.dart';
import 'package:daily_us/data/models/auth_response.dart';
import 'package:daily_us/data/models/get_all_stories_response.dart';
import 'package:daily_us/data/models/get_detail_story_response.dart';
import 'package:daily_us/data/models/upload_new_story_response.dart';
import 'package:daily_us/domain/entities/user.dart';
import 'package:dio/dio.dart';
import 'package:daily_us/domain/entities/story.dart';

abstract class DailyUsRemoteDataSource {
  Future<bool> register(String name, String email, String password);

  Future<User?> login(String email, String password);

  Future<List<Story>> getAllStories(String token);

  Future<Story?> getDetailStoryById(String token, String id);

  Future<bool> uploadNewStory(
    String token,
    List<int> photoBytes,
    String description,
    double? latitude,
    double? longitude,
  );
}

class DailyUsRemoteDataSourceImpl implements DailyUsRemoteDataSource {
  final Dio apiClient;

  DailyUsRemoteDataSourceImpl({
    required this.apiClient,
  });

  @override
  Future<bool> register(String name, String email, String password) async {
    try {
      final response = await apiClient.post("/register", data: {
        "name": name,
        "email": email,
        "password": password,
      });
      final responseData = AuthResponse.fromJson(json.decode(response.data));

      if (response.statusCode == null) {
        throw ServerException();
      } else if (response.statusCode! >= 200 &&
          response.statusCode! < 300 &&
          !responseData.error) {
        return true;
      } else {
        throw ServerException();
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response == null || e.response!.statusCode == null) {
          throw ServerException();
        }

        final statusCode = e.response!.statusCode;

        final responseData = AuthResponse.fromJson(
          json.decode(e.response!.data),
        );

        if (statusCode! >= 400 && statusCode < 500) {
          if (responseData.message == "Email is already taken") {
            throw EmailAlreadyTakenException();
          }
          if (responseData.message == "\"name\" is required") {
            throw MissingParametersException(["name"]);
          }
          if (responseData.message == "\"email\" is required") {
            throw MissingParametersException(["email"]);
          }
          if (responseData.message == "\"password\" is required") {
            throw MissingParametersException(["password"]);
          } else {
            throw MissingParametersException(["unknown"]);
          }
        } else {
          throw ServerException();
        }
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final response = await apiClient.post("/login", data: {
        "email": email,
        "password": password,
      });
      final responseData = AuthResponse.fromJson(json.decode(response.data));

      if (response.statusCode == null) {
        throw ServerException();
      } else if (response.statusCode! >= 200 &&
          response.statusCode! < 300 &&
          !responseData.error) {
        return User(
          id: responseData.loginResult.userId,
          token: responseData.loginResult.token,
          name: responseData.loginResult.name,
          email: email,
        );
      } else {
        throw ServerException();
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response == null || e.response!.statusCode == null) {
          throw ServerException();
        }

        final statusCode = e.response!.statusCode;

        final responseData = AuthResponse.fromJson(
          json.decode(e.response!.data),
        );

        if (statusCode! >= 400 && statusCode < 500) {
          if (responseData.message == "\"email\" is required") {
            throw MissingParametersException(["email"]);
          }
          if (responseData.message == "\"password\" is required") {
            throw MissingParametersException(["password"]);
          } else {
            throw MissingParametersException(["unknown"]);
          }
        } else {
          throw ServerException();
        }
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<List<Story>> getAllStories(String token) async {
    try {
      apiClient.options.headers["Authorization"] = "Bearer $token";
      final response = await apiClient.get("/stories");
      final responseData =
          GetAllStoriesResponse.fromJson(json.decode(response.data));

      if (response.statusCode == null) {
        throw ServerException();
      } else if (response.statusCode! >= 200 &&
          response.statusCode! < 300 &&
          !responseData.error) {
        return (responseData.stories.isNotEmpty)
            ? storiesResponseToEntities(responseData.stories)
            : List<Story>.empty();
      } else {
        throw RequestNotAllowedException();
      }
    } catch (e) {
      throw RequestNotAllowedException();
    }
  }

  @override
  Future<Story?> getDetailStoryById(String token, String id) async {
    try {
      apiClient.options.headers["Authorization"] = "Bearer $token";
      final response = await apiClient.get("/detail/$id");

      final responseData =
          GetDetailStoryResponse.fromJson(json.decode(response.data));

      if (response.statusCode == null) {
        throw ServerException();
      } else if (response.statusCode! >= 200 &&
          response.statusCode! < 300 &&
          !responseData.error) {
        return detailResponseToEntity(responseData.story);
      } else {
        throw ServerException();
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response == null || e.response!.statusCode == null) {
          throw ServerException();
        }

        final statusCode = e.response!.statusCode;

        if (statusCode! >= 400 && statusCode < 500) {
          return null;
        } else {
          throw ServerException();
        }
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<bool> uploadNewStory(
    String token,
    List<int> photoBytes,
    String description,
    double? latitude,
    double? longitude,
  ) async {
    final formData = FormData.fromMap({
      "description": description,
      "photo": MultipartFile.fromBytes(photoBytes),
      "lat": latitude,
      "lon": longitude,
    });

    try {
      apiClient.options.headers["Authorization"] = "Bearer $token";
      final response = await apiClient.post("/stories", data: formData);
      final responseData =
          UploadNewStoryResponse.fromJson(json.decode(response.data));

      if (response.statusCode == null) {
        throw ServerException();
      } else if (response.statusCode! >= 200 &&
          response.statusCode! < 300 &&
          !responseData.error) {
        return true;
      } else {
        throw ServerException();
      }
    } catch (e) {
      if (e is DioError) {
        if (e.response == null || e.response!.statusCode == null) {
          throw ServerException();
        }

        final statusCode = e.response!.statusCode;

        if (statusCode! >= 400 && statusCode < 500) {
          return false;
        } else {
          throw ServerException();
        }
      } else {
        throw ServerException();
      }
    }
  }
}
