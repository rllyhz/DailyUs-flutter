import 'dart:convert';

import 'package:equatable/equatable.dart';

class Story extends Equatable {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final String createdAt;
  final double latitude;
  final double longitude;

  const Story({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.latitude,
    required this.longitude,
  });

  String toJson() => json.encode({
        "id": id,
        "name": name,
        "description": description,
        "photoUrl": photoUrl,
        "createdAt": createdAt,
        "lat": latitude,
        "lon": longitude,
      });

  @override
  List<Object> get props =>
      [id, name, description, photoUrl, createdAt, latitude, longitude];
}
