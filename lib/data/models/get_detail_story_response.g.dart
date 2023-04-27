// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_detail_story_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetDetailStoryResponse _$GetDetailStoryResponseFromJson(
        Map<String, dynamic> json) =>
    GetDetailStoryResponse(
      error: json['error'] as bool,
      message: json['message'] as String,
      story: json['story'] == null
          ? const StoryResponse(
              id: '-', name: '-', photoUrl: '-', createdAt: '-')
          : StoryResponse.fromJson(json['story'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetDetailStoryResponseToJson(
        GetDetailStoryResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'story': instance.story,
    };
