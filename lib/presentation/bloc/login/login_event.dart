part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {}

class OnCancelLoginEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}

class OnSubmitLoginEvent extends LoginEvent {
  final String email;
  final String password;

  OnSubmitLoginEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
