import 'package:daily_us/common/failure.dart';
import 'package:daily_us/domain/repositories/daily_us_repository.dart';
import 'package:dartz/dartz.dart';

class Register {
  final DailyUsRepository repository;

  const Register(this.repository);

  Future<Either<Failure, bool>> execute(
    String name,
    String email,
    String password,
  ) {
    return repository.register(name, email, password);
  }
}
