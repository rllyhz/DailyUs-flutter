import 'package:equatable/equatable.dart';

class StoryResponse extends Equatable {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final String createdAt;
  final double latitude;
  final double longitude;

  static String defaultStringValue = '-';
  static double defaultDoubleValue = 0.0;

  const StoryResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.latitude,
    required this.longitude,
  });

  factory StoryResponse.fromJson(Map<String, dynamic> json) => StoryResponse(
        id: json["id"],
        name: json["name"],
        description: json["description"] ?? StoryResponse.defaultStringValue,
        photoUrl: json["photoUrl"],
        createdAt: json["createdAt"],
        latitude: json["lat"] ?? StoryResponse.defaultDoubleValue,
        longitude: json["lon"] ?? StoryResponse.defaultDoubleValue,
      );

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
