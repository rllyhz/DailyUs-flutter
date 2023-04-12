import 'package:equatable/equatable.dart';

class UploadNewStoryResponse extends Equatable {
  final bool error;
  final String message;

  const UploadNewStoryResponse({
    required this.error,
    required this.message,
  });

  factory UploadNewStoryResponse.fromJson(Map<String, dynamic> json) =>
      UploadNewStoryResponse(
        error: json["error"],
        message: json["message"],
      );

  @override
  List<Object> get props => [error, message];
}
