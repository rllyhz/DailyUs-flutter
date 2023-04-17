part of 'detail_bloc.dart';

abstract class DetailEvent extends Equatable {}

class OnFetchDetailStoryEvent extends DetailEvent {
  final String token;
  final String storyId;

  OnFetchDetailStoryEvent(this.token, this.storyId);

  @override
  List<Object?> get props => [token, storyId];
}
