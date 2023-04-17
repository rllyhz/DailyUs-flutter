import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/domain/repositories/daily_us_repository.dart';

class GetAuthInfo {
  final DailyUsRepository _repository;

  const GetAuthInfo(this._repository);

  AuthInfo? execute() {
    return _repository.getAuthInfo();
  }
}
