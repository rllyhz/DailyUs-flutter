import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:daily_us/common/failure.dart';
import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/domain/usecases/login.dart';
import 'package:daily_us/domain/usecases/update_auth_info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login _loginUsecase;
  final UpdateAuthInfo _updateAuthInfoUsecase;

  LoginBloc(this._loginUsecase, this._updateAuthInfoUsecase)
      : super(LoginStateInitial()) {
    on<OnSubmitLoginEvent>(_onSubmitLogin, transformer: restartable());
    on<OnCancelLoginEvent>(_onCancelLogin);
  }

  FutureOr<void> _onCancelLogin(
    OnCancelLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginStateInitial());
  }

  FutureOr<void> _onSubmitLogin(
    OnSubmitLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginStateLoading());

    final email = event.email;
    final password = event.password;

    final result = await _loginUsecase.execute(email, password);

    emit(
      result.fold((failure) => LoginStateError(failure), (user) {
        if (user == null) {
          return LoginStateError(const UnknownFailure());
        } else {
          var newAuthInfo = AuthInfo(isAlreadyLoggedIn: true, user: user);
          _updateAuthInfoUsecase.execute(newAuthInfo);
          return LoginStateSuccess(newAuthInfo);
        }
      }),
    );
  }

  @override
  Stream<LoginState> get stream => super.stream.debounceTime(
        const Duration(milliseconds: 300),
      );
}
