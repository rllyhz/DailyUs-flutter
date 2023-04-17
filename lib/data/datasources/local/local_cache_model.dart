import 'dart:convert';

import 'package:equatable/equatable.dart';

class LocalCacheModel extends Equatable {
  final bool isAlreadyLoggedIn;
  final String userId;
  final String userName;
  final String userToken;
  final String userEmail;

  static String isAlreadyLoggedInKey = "0";
  static String userIdKey = "1";
  static String userNameKey = "2";
  static String userTokenKey = "3";
  static String userEmailKey = "4";

  const LocalCacheModel({
    required this.isAlreadyLoggedIn,
    required this.userId,
    required this.userName,
    required this.userToken,
    required this.userEmail,
  });

  factory LocalCacheModel.fromJson(Map<String, dynamic> strJson) =>
      LocalCacheModel(
        isAlreadyLoggedIn: strJson[LocalCacheModel.isAlreadyLoggedInKey],
        userId: strJson[LocalCacheModel.userIdKey],
        userName: strJson[LocalCacheModel.userNameKey],
        userToken: strJson[LocalCacheModel.userTokenKey],
        userEmail: strJson[LocalCacheModel.userEmailKey],
      );

  String toJson() => json.encode({
        LocalCacheModel.isAlreadyLoggedInKey: isAlreadyLoggedIn,
        LocalCacheModel.userIdKey: userId,
        LocalCacheModel.userNameKey: userName,
        LocalCacheModel.userTokenKey: userToken,
        LocalCacheModel.userEmailKey: userEmail,
      });

  @override
  List<Object?> get props => [
        isAlreadyLoggedIn,
        userId,
        userName,
        userToken,
        userEmail,
      ];
}
