import 'package:daily_us/data/models/story_response.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_all_stories_response.g.dart';

@JsonSerializable()
class GetAllStoriesResponse extends Equatable {
  final bool error;
  final String message;

  @JsonKey(name: 'listStory')
  final List<StoryResponse> stories;

  const GetAllStoriesResponse({
    required this.error,
    required this.message,
    this.stories = const <StoryResponse>[],
  });

  factory GetAllStoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllStoriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllStoriesResponseToJson(this);

  @override
  List<Object> get props => [error, message, stories];
}
