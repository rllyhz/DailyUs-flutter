part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {}

class OnLogoutEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}
