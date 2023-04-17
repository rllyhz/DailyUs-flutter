part of 'register_block.dart';

abstract class RegisterState extends Equatable {}

class RegisterStateInitial extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterStateLoading extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterStateError extends RegisterState {
  final Failure failure;

  RegisterStateError(this.failure);

  @override
  List<Object?> get props => [failure];
}

class RegisterStateSuccess extends RegisterState {
  @override
  List<Object?> get props => [];
}
