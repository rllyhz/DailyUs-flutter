part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {}

class ProfileStateInitial extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileStateLogoutError extends ProfileState {
  final String message;

  ProfileStateLogoutError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileStateLogoutSuccess extends ProfileState {
  @override
  List<Object?> get props => [];
}
