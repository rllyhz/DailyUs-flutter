import 'package:daily_us/common/failure.dart';
import 'package:daily_us/domain/entities/user.dart';
import 'package:daily_us/domain/repositories/daily_us_repository.dart';
import 'package:dartz/dartz.dart';

class Login {
  final DailyUsRepository repository;

  const Login(this.repository);

  Future<Either<Failure, User?>> execute(
    String email,
    String password,
  ) {
    return repository.login(email, password);
  }
}
