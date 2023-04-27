import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'upload_new_story_response.g.dart';

@JsonSerializable()
class UploadNewStoryResponse extends Equatable {
  final bool error;
  final String message;

  const UploadNewStoryResponse({
    required this.error,
    required this.message,
  });

  factory UploadNewStoryResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadNewStoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UploadNewStoryResponseToJson(this);

  @override
  List<Object> get props => [error, message];
}
