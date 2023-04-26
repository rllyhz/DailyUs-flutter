import 'package:daily_us/common/failure.dart';
import 'package:daily_us/domain/entities/story.dart';
import 'package:daily_us/domain/repositories/daily_us_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllStories {
  final DailyUsRepository _repository;

  const GetAllStories(this._repository);

  Future<Either<Failure, List<Story>>> execute(
    String token, {
    int page = 0,
    int location = 0,
  }) {
    return _repository.getAllStories(
      token,
      page,
      location,
    );
  }
}
