import 'package:daily_us/common/failure.dart';
import 'package:daily_us/domain/repositories/daily_us_repository.dart';
import 'package:dartz/dartz.dart';

class UploadNewStory {
  final DailyUsRepository repository;

  const UploadNewStory(this.repository);

  Future<Either<Failure, bool>> execute(
    List<int> photoBytes,
    String description,
    double? latitude,
    double? longitude,
  ) {
    return repository.uploadNewStory(
      photoBytes,
      description,
      latitude,
      longitude,
    );
  }
}
