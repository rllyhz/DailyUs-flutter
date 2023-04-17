part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {}

class OnCancelLogin extends LoginEvent {
  @override
  List<Object> get props => [];
}

class OnSubmitLogin extends LoginEvent {
  final String email;
  final String password;

  OnSubmitLogin(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
