import 'package:daily_us/common/failure.dart';
import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/domain/entities/story.dart';
import 'package:daily_us/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class DailyUsRepository {
  Future<Either<Failure, bool>> register(
      String name, String email, String password);

  Future<Either<Failure, User?>> login(String email, String password);

  bool logout();

  AuthInfo getAuthInfo();

  Future<bool> updateAuthInfo(AuthInfo authInfo);

  Future<Either<Failure, List<Story>>> getAllStories();

  Future<Either<Failure, Story?>> getDetailStoryById(String id);

  Future<Either<Failure, bool>> uploadNewStory(List<int> photoBytes,
      String description, double? latitude, double? longitude);
}
