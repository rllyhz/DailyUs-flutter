import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_result_response.g.dart';

@JsonSerializable()
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

  factory LoginResult.withDefaultValues() => LoginResult(
        userId: LoginResult.defaultValue,
        name: LoginResult.defaultValue,
        token: LoginResult.defaultValue,
      );

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);

  @override
  List<Object> get props => [userId, name, token];
}
