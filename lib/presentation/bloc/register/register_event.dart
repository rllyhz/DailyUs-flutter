part of 'register_block.dart';

abstract class RegisterEvent extends Equatable {}

class OnSubmitRegisterEvent extends RegisterEvent {
  final String name;
  final String email;
  final String password;

  OnSubmitRegisterEvent(this.name, this.email, this.password);

  @override
  List<Object?> get props => [name, email, password];
}

class OnCancelRegisterEvent extends RegisterEvent {
  @override
  List<Object?> get props => [];
}
