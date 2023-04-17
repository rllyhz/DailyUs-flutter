import 'dart:async';

import 'package:daily_us/common/failure.dart';
import 'package:daily_us/domain/usecases/register.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final Register _registerUsecase;

  RegisterBloc(this._registerUsecase) : super(RegisterStateInitial()) {
    on<OnSubmitRegisterEvent>(_onSubmitRegister);
    on<OnCancelRegisterEvent>(_onCancelRegister);
  }

  FutureOr<void> _onCancelRegister(
    OnCancelRegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterStateInitial());
  }

  FutureOr<void> _onSubmitRegister(
    OnSubmitRegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterStateLoading());

    final name = event.name;
    final email = event.email;
    final password = event.password;

    final result = await _registerUsecase.execute(name, email, password);

    emit(
      result.fold(
        (failure) => RegisterStateError(failure),
        (success) => success
            ? RegisterStateSuccess()
            : RegisterStateError(const UnknownFailure()),
      ),
    );
  }
}
