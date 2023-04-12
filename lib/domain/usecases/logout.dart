import 'package:daily_us/domain/repositories/daily_us_repository.dart';

class Logout {
  final DailyUsRepository repository;

  const Logout(this.repository);

  bool execute() {
    return repository.logout();
  }
}
