import 'dart:io';

import 'package:daily_us/common/exception.dart';
import 'package:daily_us/data/datasources/daily_us_local_cache_data_source.dart';
import 'package:daily_us/data/datasources/daily_us_remote_data_source.dart';
import 'package:daily_us/domain/entities/user.dart';
import 'package:daily_us/domain/entities/story.dart';
import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/common/failure.dart';
import 'package:daily_us/domain/repositories/daily_us_repository.dart';
import 'package:dartz/dartz.dart';

class DailyUsRepositoryImpl extends DailyUsRepository {
  final DailyUsRemoteDataSource remoteDataSource;
  final DailyUsLocalCacheDataSource localCacheDataSource;

  DailyUsRepositoryImpl({
    required this.remoteDataSource,
    required this.localCacheDataSource,
  });

  @override
  Future<Either<Failure, bool>> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final result = await remoteDataSource.register(name, email, password);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure());
    } on EmailAlreadyTakenException {
      return const Left(RequestNotAllowedFailure("Email is already taken"));
    } on MissingParametersException {
      return const Left(
        RequestNotAllowedFailure("Missing required parameters"),
      );
    }
  }

  @override
  Future<Either<Failure, User?>> login(String email, String password) async {
    try {
      final result = await remoteDataSource.login(email, password);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure());
    } on MissingParametersException {
      return const Left(
        RequestNotAllowedFailure("Missing required parameters"),
      );
    }
  }

  @override
  bool logout() {
    localCacheDataSource.clearAuthInfo();
    return true;
  }

  @override
  AuthInfo getAuthInfo() {
    return localCacheDataSource.getAuthInfo();
  }

  @override
  Future<bool> updateAuthInfo(AuthInfo authInfo) async {
    return await localCacheDataSource.updateAuthInfo(authInfo);
  }

  @override
  Future<Either<Failure, List<Story>>> getAllStories() async {
    try {
      final result = await remoteDataSource.getAllStories();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure());
    } on SocketException {
      return const Left(NoInternetConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, Story?>> getDetailStoryById(String id) async {
    try {
      final result = await remoteDataSource.getDetailStoryById(id);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure());
    } on SocketException {
      return const Left(NoInternetConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> uploadNewStory(List<int> photoBytes,
      String description, double? latitude, double? longitude) async {
    try {
      final result = await remoteDataSource.uploadNewStory(
          photoBytes, description, latitude, longitude);
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure());
    } on SocketException {
      return const Left(NoInternetConnectionFailure());
    }
  }
}