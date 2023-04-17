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
  final String message;

  RegisterStateError(this.message);

  @override
  List<Object?> get props => [message];
}

class RegisterStateSuccess extends RegisterState {
  @override
  List<Object?> get props => [];
}
