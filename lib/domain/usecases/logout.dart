import 'package:daily_us/common/logger.dart';
import 'package:daily_us/domain/repositories/daily_us_repository.dart';

class Logout {
  final DailyUsRepository _repository;

  const Logout(this._repository);

  bool execute() {
    Logger.log("LogoutUsecase being executed!", showPadding: true);
    return _repository.logout();
  }
}
