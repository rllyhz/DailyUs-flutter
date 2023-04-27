part of 'home_bloc.dart';

abstract class HomeState extends Equatable {}

class HomeStateLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeStateLoadMoreProgress extends HomeState {
  final List<Story> tempStories;

  HomeStateLoadMoreProgress(this.tempStories);

  @override
  List<Object?> get props => [tempStories];
}

class HomeStateError extends HomeState {
  final Failure failure;

  HomeStateError(this.failure);

  @override
  List<Object?> get props => [failure];
}

class HomeStateLoadMoreError extends HomeState {
  final Failure failure;
  final List<Story> tempStories;

  HomeStateLoadMoreError(this.failure, this.tempStories);

  @override
  List<Object?> get props => [failure, tempStories];
}

class HomeStateHasData extends HomeState {
  final List<Story> stories;

  HomeStateHasData(this.stories);

  @override
  List<Object?> get props => [stories];
}

class HomeStateDataEmpty extends HomeState {
  @override
  List<Object?> get props => [];
}
