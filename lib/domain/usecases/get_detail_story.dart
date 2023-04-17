import 'package:daily_us/common/failure.dart';
import 'package:daily_us/domain/entities/story.dart';
import 'package:daily_us/domain/repositories/daily_us_repository.dart';
import 'package:dartz/dartz.dart';

class GetDetailStory {
  final DailyUsRepository _repository;

  const GetDetailStory(this._repository);

  Future<Either<Failure, Story?>> execute(String token, String id) {
    return _repository.getDetailStoryById(token, id);
  }
}
