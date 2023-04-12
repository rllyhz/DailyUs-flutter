import 'package:daily_us/common/failure.dart';
import 'package:daily_us/domain/entities/story.dart';
import 'package:daily_us/domain/repositories/daily_us_repository.dart';
import 'package:dartz/dartz.dart';

class GetDetailStory {
  final DailyUsRepository repository;

  const GetDetailStory(this.repository);

  Future<Either<Failure, Story?>> execute(String id) {
    return repository.getDetailStoryById(id);
  }
}
