// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_cache_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalCacheModel _$LocalCacheModelFromJson(Map<String, dynamic> json) =>
    LocalCacheModel(
      isAlreadyLoggedIn: json['0'] as bool,
      userId: json['1'] as String,
      userName: json['2'] as String,
      userToken: json['3'] as String,
      userEmail: json['4'] as String,
    );

Map<String, dynamic> _$LocalCacheModelToJson(LocalCacheModel instance) =>
    <String, dynamic>{
      '0': instance.isAlreadyLoggedIn,
      '1': instance.userId,
      '2': instance.userName,
      '3': instance.userToken,
      '4': instance.userEmail,
    };
