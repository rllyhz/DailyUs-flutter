part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {}

class OnFetchAllStoriesEvent extends HomeEvent {
  final String token;

  OnFetchAllStoriesEvent(this.token);

  @override
  List<Object?> get props => [token];
}

class OnCancelFetchAllStoriesEvent extends HomeEvent {
  @override
  List<Object?> get props => [];
}
