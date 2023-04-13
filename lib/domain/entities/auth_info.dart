import 'package:daily_us/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

class AuthInfo extends Equatable {
  final bool isAlreadyLoggedIn;
  final User user;

  const AuthInfo({
    required this.isAlreadyLoggedIn,
    required this.user,
  });

  factory AuthInfo.fromJson(Map<String, dynamic> authJson) => AuthInfo(
        isAlreadyLoggedIn: authJson["isAlreadyLoggedIn"] ?? false,
        user: User.fromJson(authJson["user"]),
      );

  String toJson() =>
      '{"isAlreadyLoggedIn": $isAlreadyLoggedIn, "user": ${user.toJson()}}';

  @override
  List<Object?> get props => [isAlreadyLoggedIn, user];
}
