// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_new_story_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadNewStoryResponse _$UploadNewStoryResponseFromJson(
        Map<String, dynamic> json) =>
    UploadNewStoryResponse(
      error: json['error'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$UploadNewStoryResponseToJson(
        UploadNewStoryResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
    };
