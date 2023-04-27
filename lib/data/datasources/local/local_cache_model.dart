import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'local_cache_model.g.dart';

@JsonSerializable()
class LocalCacheModel extends Equatable {
  @JsonKey(name: '0')
  final bool isAlreadyLoggedIn;
  @JsonKey(name: '1')
  final String userId;
  @JsonKey(name: '2')
  final String userName;
  @JsonKey(name: '3')
  final String userToken;
  @JsonKey(name: '4')
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

  factory LocalCacheModel.fromJson(Map<String, dynamic> json) =>
      _$LocalCacheModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocalCacheModelToJson(this);

  @override
  List<Object?> get props => [
        isAlreadyLoggedIn,
        userId,
        userName,
        userToken,
        userEmail,
      ];
}
