part of 'post_bloc.dart';

abstract class PostState extends Equatable {}

class PostStateInitial extends PostState {
  @override
  List<Object?> get props => [];
}

class PostStateUploading extends PostState {
  @override
  List<Object?> get props => [];
}

class PostStateUploadDone extends PostState {
  final bool isSuccess;

  PostStateUploadDone(this.isSuccess);

  @override
  List<Object?> get props => [];
}

class PostStateUploadFailed extends PostState {
  final Failure failure;

  PostStateUploadFailed(this.failure);

  @override
  List<Object?> get props => [];
}
