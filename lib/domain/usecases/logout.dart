import 'package:daily_us/domain/repositories/daily_us_repository.dart';

class Logout {
  final DailyUsRepository _repository;

  const Logout(this._repository);

  bool execute() {
    return _repository.logout();
  }
}
