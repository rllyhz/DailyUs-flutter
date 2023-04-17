part of 'detail_bloc.dart';

abstract class DetailState extends Equatable {}

class DetailStateLoading extends DetailState {
  @override
  List<Object?> get props => [];
}

class DetailStateError extends DetailState {
  final Failure failure;

  DetailStateError(this.failure);

  @override
  List<Object?> get props => [failure];
}

class DetailStateHasData extends DetailState {
  final Story detailStory;

  DetailStateHasData(this.detailStory);

  @override
  List<Object?> get props => [detailStory];
}
