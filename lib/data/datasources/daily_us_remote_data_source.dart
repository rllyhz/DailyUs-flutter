import 'dart:io';

import 'package:daily_us/common/exception.dart';
import 'package:daily_us/common/logger.dart';
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

  Future<Story> getDetailStoryById(String token, String id);

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

      final responseData = AuthResponse.fromJson(response.data);

      if (response.statusCode == null) {
        throw InternalException();
      } else if (response.statusCode! >= 200 &&
          response.statusCode! < 300 &&
          !responseData.error) {
        Logger.logWithTag("Register Success", response.data.toString());
        return true;
      } else {
        throw ServerException();
      }
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    } on DioError catch (e) {
      if (e.response == null || e.response!.statusCode == null) {
        throw InternalException();
      }

      final statusCode = e.response!.statusCode;

      final responseData = AuthResponse.fromJson(
        e.response!.data,
      );

      Logger.logWithTag("Register Failed", e.response!.data.toString());

      if (statusCode! >= 400 && statusCode < 500) {
        if (responseData.message == "Email is already taken") {
          throw EmailAlreadyTakenException();
        } else if (responseData.message == '"email" must be a valid email') {
          throw InvalidEmailException();
        } else {
          throw UnknownException();
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
      final responseData = AuthResponse.fromJson(response.data);

      if (response.statusCode == null) {
        throw InternalException();
      } else if (response.statusCode! >= 200 &&
          response.statusCode! < 300 &&
          !responseData.error) {
        Logger.logWithTag("Login Success", response.data.toString());
        return User(
          id: responseData.loginResult.userId,
          token: responseData.loginResult.token,
          name: responseData.loginResult.name,
          email: email,
        );
      } else {
        throw ServerException();
      }
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    } on DioError catch (e) {
      if (e.response == null || e.response!.statusCode == null) {
        throw InternalException();
      }

      final statusCode = e.response!.statusCode;

      Logger.logWithTag("Login Failed", e.response!.data.toString());

      final responseData = AuthResponse.fromJson(
        e.response!.data,
      );

      if (statusCode! >= 400 && statusCode < 500) {
        if (responseData.message == 'Invalid password') {
          throw InvalidPasswordException();
        } else if (responseData.message == 'User not found') {
          throw UserWithGivenEmailNotFoundException();
        } else if (responseData.message == '"email" must be a valid email') {
          throw InvalidEmailException();
        } else {
          throw UnknownException();
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
      final responseData = GetAllStoriesResponse.fromJson(response.data);

      if (response.statusCode == null) {
        throw ServerException();
      } else if (response.statusCode! >= 200 &&
          response.statusCode! < 300 &&
          !responseData.error) {
        Logger.logWithTag("GetAllStories Success", response.data.toString());
        return (responseData.stories.isNotEmpty)
            ? storiesResponseToEntities(responseData.stories)
            : List<Story>.empty();
      } else {
        throw ServerException();
      }
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    } on DioError catch (e) {
      if (e.response == null || e.response!.statusCode == null) {
        throw InternalException();
      }

      Logger.logWithTag("GetAllStories Failed", e.response!.data.toString());

      throw ServerException();
    }
  }

  @override
  Future<Story> getDetailStoryById(String token, String id) async {
    try {
      apiClient.options.headers["Authorization"] = "Bearer $token";
      final response = await apiClient.get("/stories/$id");

      final responseData = GetDetailStoryResponse.fromJson(response.data);

      if (response.statusCode == null) {
        throw ServerException();
      } else if (response.statusCode! >= 200 &&
          response.statusCode! < 300 &&
          !responseData.error) {
        Logger.logWithTag("GetDetailStory Success", response.data.toString());
        return detailResponseToEntity(responseData.story);
      } else {
        throw ServerException();
      }
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    } on DioError catch (e) {
      if (e.response == null || e.response!.statusCode == null) {
        throw ServerException();
      }

      final responseData = GetDetailStoryResponse.fromJson(
        e.response!.data,
      );

      Logger.logWithTag("GetDetailStory Failed", e.response!.data.toString());

      final statusCode = e.response!.statusCode;

      if (statusCode! >= 400 && statusCode < 500) {
        if (responseData.message == 'Story not found') {
          throw StoryNotFoundException();
        } else {
          throw UnknownException();
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
      final responseData = UploadNewStoryResponse.fromJson(response.data);

      if (response.statusCode == null) {
        throw ServerException();
      } else if (response.statusCode! >= 200 &&
          response.statusCode! < 300 &&
          !responseData.error) {
        Logger.logWithTag("UploadNewStory Success", response.data.toString());
        return true;
      } else {
        throw ServerException();
      }
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    } on DioError catch (e) {
      if (e.response == null || e.response!.statusCode == null) {
        throw ServerException();
      }

      Logger.logWithTag("UploadNewStory Failed", e.response!.data.toString());

      final statusCode = e.response!.statusCode;

      if (statusCode! >= 400 && statusCode < 500) {
        return false;
      } else {
        throw ServerException();
      }
    }
  }
}
