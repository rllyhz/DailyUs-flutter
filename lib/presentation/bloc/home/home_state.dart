part of 'home_bloc.dart';

abstract class HomeState extends Equatable {}

class HomeStateLoading extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeStateError extends HomeState {
  final Failure failure;

  HomeStateError(this.failure);

  @override
  List<Object?> get props => [failure];
}

class HomeStateHasData extends HomeState {
  final List<Story> stories;

  HomeStateHasData(this.stories);

  @override
  List<Object?> get props => [stories];
}
