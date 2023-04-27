import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'story_response.g.dart';

@JsonSerializable()
class StoryResponse extends Equatable {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final String createdAt;
  @JsonKey(name: 'lat')
  final double latitude;
  @JsonKey(name: 'lon')
  final double longitude;

  static String defaultStringValue = '-';
  static double defaultDoubleValue = 0.0;

  const StoryResponse({
    required this.id,
    required this.name,
    this.description = '-',
    required this.photoUrl,
    required this.createdAt,
    this.latitude = 0.0,
    this.longitude = 0.0,
  });

  factory StoryResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StoryResponseToJson(this);

  factory StoryResponse.withDefaultValues() => StoryResponse(
        id: StoryResponse.defaultStringValue,
        name: StoryResponse.defaultStringValue,
        description: StoryResponse.defaultStringValue,
        photoUrl: StoryResponse.defaultStringValue,
        createdAt: StoryResponse.defaultStringValue,
        latitude: StoryResponse.defaultDoubleValue,
        longitude: StoryResponse.defaultDoubleValue,
      );

  @override
  List<Object> get props =>
      [id, name, description, photoUrl, createdAt, latitude, longitude];
}
