import 'package:daily_us/data/models/story_response.dart';
import 'package:equatable/equatable.dart';

class GetDetailStoryResponse extends Equatable {
  final bool error;
  final String message;
  final StoryResponse story;

  const GetDetailStoryResponse({
    required this.error,
    required this.message,
    required this.story,
  });

  factory GetDetailStoryResponse.fromJson(Map<String, dynamic> json) {
    StoryResponse story;

    if (json.containsKey("story")) {
      story = StoryResponse.fromJson(json["story"]);
    } else {
      story = StoryResponse.withDefaultValues();
    }

    return GetDetailStoryResponse(
      error: json["error"],
      message: json["message"],
      story: story,
    );
  }

  @override
  List<Object> get props => [error, message, story];
}
