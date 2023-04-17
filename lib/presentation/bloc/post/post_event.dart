part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {}

class OnCancelUploadStoryEvent extends PostEvent {
  @override
  List<Object?> get props => [];
}

class OnUploadStoryEvent extends PostEvent {
  final XFile photoXFile;
  final String description;
  final double? latitude;
  final double? longitude;
  final String token;

  OnUploadStoryEvent({
    required this.photoXFile,
    required this.token,
    required this.description,
    this.latitude,
    this.longitude,
  });

  @override
  List<Object?> get props => [
        photoXFile,
        token,
        description,
        latitude,
        latitude,
      ];
}
