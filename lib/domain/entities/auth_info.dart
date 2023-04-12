import 'package:daily_us/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

class AuthInfo extends Equatable {
  final bool isAlreadyLoggedIn;
  final User? user;

  const AuthInfo({
    required this.isAlreadyLoggedIn,
    required this.user,
  });

  factory AuthInfo.fromJson(Map<String, dynamic> authJson) {
    User? authUser;

    if (authJson["user"] != null) {
      authUser = User.fromJson(authJson["user"]);
    }

    return AuthInfo(
      isAlreadyLoggedIn: authJson["isAlreadyLoggedIn"] ?? false,
      user: authUser,
    );
  }

  String toJson() {
    String? userJson;

    if (user != null) {
      userJson = user!.toJson();
    }

    return '{"isAlreadyLoggedIn": $isAlreadyLoggedIn, "user": $userJson}';
  }

  @override
  List<Object?> get props => [isAlreadyLoggedIn, user];
}
