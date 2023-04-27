part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {}

class OnFetchAllStoriesEvent extends HomeEvent {
  final String token;

  OnFetchAllStoriesEvent(this.token);

  @override
  List<Object?> get props => [token];
}

class OnLoadMoreStoriesEvent extends HomeEvent {
  final String token;

  OnLoadMoreStoriesEvent(this.token);

  @override
  List<Object?> get props => [token];
}
