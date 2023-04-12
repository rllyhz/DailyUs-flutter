import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String token;

  const User({required this.id, required this.token, required this.name});

  factory User.fromJson(Map<String, dynamic> userJson) => User(
        id: userJson["id"],
        name: userJson["name"],
        token: userJson["token"],
      );

  String toJson() => json.encode({
        "id": id,
        "name": name,
        "token": token,
      });

  @override
  List<Object?> get props => [id, token, name];
}
