part of 'login_bloc.dart';

abstract class LoginState extends Equatable {}

class LoginStateInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginStateLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginStateError extends LoginState {
  final String message;

  LoginStateError(this.message);

  @override
  List<Object> get props => [message];
}

class LoginStateSuccess extends LoginState {
  final AuthInfo authInfo;

  LoginStateSuccess(this.authInfo);

  @override
  List<Object> get props => [authInfo];
}
