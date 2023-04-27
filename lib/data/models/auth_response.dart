import 'package:daily_us/data/models/login_result_response.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse extends Equatable {
  final bool error;
  final String message;
  final LoginResult loginResult;

  const AuthResponse({
    required this.error,
    required this.message,
    this.loginResult = const LoginResult(name: '-', userId: '-', token: '-'),
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);

  @override
  List<Object> get props => [error, message];
}
