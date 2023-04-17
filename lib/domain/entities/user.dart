import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String token;

  const User({
    required this.id,
    required this.token,
    required this.email,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> userJson) => User(
        id: userJson["id"],
        name: userJson["name"],
        email: userJson["email"],
        token: userJson["token"],
      );

  String toJson() => json.encode({
        "id": id,
        "name": name,
        "email": email,
        "token": token,
      });

  @override
  List<Object?> get props => [id, token, email, name];
}
