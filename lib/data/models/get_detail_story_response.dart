import 'package:daily_us/data/models/story_response.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_detail_story_response.g.dart';

@JsonSerializable()
class GetDetailStoryResponse extends Equatable {
  final bool error;
  final String message;
  final StoryResponse story;

  const GetDetailStoryResponse({
    required this.error,
    required this.message,
    this.story = const StoryResponse(
      id: '-',
      name: '-',
      photoUrl: '-',
      createdAt: '-',
    ),
  });

  factory GetDetailStoryResponse.fromJson(Map<String, dynamic> json) =>
      _$GetDetailStoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetDetailStoryResponseToJson(this);

  @override
  List<Object> get props => [error, message, story];
}
