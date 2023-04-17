import 'package:daily_us/common/failure.dart';
import 'package:daily_us/domain/repositories/daily_us_repository.dart';
import 'package:dartz/dartz.dart';

class UploadNewStory {
  final DailyUsRepository _repository;

  const UploadNewStory(this._repository);

  Future<Either<Failure, bool>> execute(
    String token,
    List<int> photoBytes,
    String description,
    double? latitude,
    double? longitude,
  ) {
    return _repository.uploadNewStory(
      token,
      photoBytes,
      description,
      latitude,
      longitude,
    );
  }
}
