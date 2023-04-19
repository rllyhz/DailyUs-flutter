import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/domain/repositories/daily_us_repository.dart';

class UpdateAuthInfo {
  final DailyUsRepository _repository;

  const UpdateAuthInfo(this._repository);

  void execute(AuthInfo authInfo) async {
    await _repository.updateAuthInfo(authInfo);
  }
}
