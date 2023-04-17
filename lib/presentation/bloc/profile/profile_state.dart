part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {}

class ProfileStateInitial extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileStateLogoutError extends ProfileState {
  final Failure failure;

  ProfileStateLogoutError(this.failure);

  @override
  List<Object?> get props => [failure];
}

class ProfileStateLogoutSuccess extends ProfileState {
  @override
  List<Object?> get props => [];
}
