import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/domain/repositories/daily_us_repository.dart';

class GetAuthInfo {
  final DailyUsRepository repository;

  const GetAuthInfo(this.repository);

  AuthInfo? execute() {
    return repository.getAuthInfo();
  }
}
