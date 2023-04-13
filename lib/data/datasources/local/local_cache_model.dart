import 'dart:convert';

class LocalCacheModel {
  final bool isAlreadyLoggedIn;
  final String userId;
  final String userName;
  final String userToken;

  static String isAlreadyLoggedInKey = "0";
  static String userIdKey = "1";
  static String userNameKey = "2";
  static String userTokenKey = "3";

  LocalCacheModel({
    required this.isAlreadyLoggedIn,
    required this.userId,
    required this.userName,
    required this.userToken,
  });

  factory LocalCacheModel.fromJson(Map<String, dynamic> strJson) =>
      LocalCacheModel(
        isAlreadyLoggedIn: strJson[LocalCacheModel.isAlreadyLoggedInKey],
        userId: strJson[LocalCacheModel.userIdKey],
        userName: strJson[LocalCacheModel.userNameKey],
        userToken: strJson[LocalCacheModel.userTokenKey],
      );

  String toJson() => json.encode({
        LocalCacheModel.isAlreadyLoggedInKey: isAlreadyLoggedIn,
        LocalCacheModel.userIdKey: userId,
        LocalCacheModel.userNameKey: userName,
        LocalCacheModel.userTokenKey: userToken,
      });
}
