import 'package:daily_us/common/failure.dart';
import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/domain/entities/localization.dart';
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

  Localization getLocalizationData();

  Future<bool> updateLocalizationData(Localization newLocalization);

  Future<Either<Failure, List<Story>>> getAllStories(String token);

  Future<Either<Failure, Story>> getDetailStoryById(String token, String id);

  Future<Either<Failure, bool>> uploadNewStory(
    String token,
    List<int> photoBytes,
    String description,
    double? latitude,
    double? longitude,
  );
}
