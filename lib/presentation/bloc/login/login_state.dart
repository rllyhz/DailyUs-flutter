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
  final Failure failure;

  LoginStateError(this.failure);

  @override
  List<Object> get props => [failure];
}

class LoginStateSuccess extends LoginState {
  final AuthInfo authInfo;

  LoginStateSuccess(this.authInfo);

  @override
  List<Object> get props => [authInfo];
}
