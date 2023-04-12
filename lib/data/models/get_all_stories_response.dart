import 'package:daily_us/data/models/story_response.dart';
import 'package:equatable/equatable.dart';

class GetAllStoriesResponse extends Equatable {
  final bool error;
  final String message;
  final List<StoryResponse> stories;

  const GetAllStoriesResponse({
    required this.error,
    required this.message,
    required this.stories,
  });

  factory GetAllStoriesResponse.fromJson(Map<String, dynamic> json) {
    List<StoryResponse> stories;

    if (json.containsKey("listStory")) {
      stories = List<StoryResponse>.from(
        (json["listStory"] as List).map((x) => StoryResponse.fromJson(x)),
      );
    } else {
      stories = List<StoryResponse>.empty();
    }

    return GetAllStoriesResponse(
      error: json["error"],
      message: json["message"],
      stories: stories,
    );
  }

  @override
  List<Object> get props => [error, message, stories];
}
