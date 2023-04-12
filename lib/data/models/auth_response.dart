import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthResponse extends Equatable {
  final bool error;
  final String message;
  final LoginResult loginResult;

  const AuthResponse({
    required this.error,
    required this.message,
    required this.loginResult,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> authJson) {
    LoginResult loginResult;

    if (authJson.containsKey("loginResult")) {
      loginResult = LoginResult.fromJson(authJson["loginResult"]);
    } else {
      loginResult = LoginResult.withDefaultValues();
    }

    return AuthResponse(
      error: authJson["error"],
      message: authJson["message"],
      loginResult: loginResult,
    );
  }

  String toJson() =>
      '{"error": $error, "message": "$message", "loginResult": ${loginResult.toJson()}}';

  @override
  List<Object> get props => [error, message, loginResult];
}

class LoginResult extends Equatable {
  final String userId;
  final String name;
  final String token;

  static String defaultValue = '-';

  const LoginResult({
    required this.userId,
    required this.name,
    required this.token,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult(
        userId: json["userId"],
        name: json["name"],
        token: json["token"],
      );

  factory LoginResult.withDefaultValues() => LoginResult(
        userId: LoginResult.defaultValue,
        name: LoginResult.defaultValue,
        token: LoginResult.defaultValue,
      );

  String toJson() => json.encode({
        "userId": userId,
        "name": name,
        "token": token,
      });

  @override
  List<Object> get props => [userId, name, token];
}
