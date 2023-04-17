import 'package:daily_us/common/failure.dart';
import 'package:daily_us/common/logger.dart';
import 'package:daily_us/domain/repositories/daily_us_repository.dart';
import 'package:dartz/dartz.dart';

class Register {
  final DailyUsRepository _repository;

  const Register(this._repository);

  Future<Either<Failure, bool>> execute(
    String name,
    String email,
    String password,
  ) {
    Logger.log("RegisterUsecase being executed!", showPadding: true);
    return _repository.register(name, email, password);
  }
}
