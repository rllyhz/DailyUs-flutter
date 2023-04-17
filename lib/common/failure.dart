import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class UnknownFailure extends Failure {
  const UnknownFailure() : super("Something went wrong unexpectedly");
}

class NoInternetConnectionFailure extends Failure {
  const NoInternetConnectionFailure() : super("No internet connection");
}

class ServerFailure extends Failure {
  const ServerFailure() : super("Connection error to host");
}

class InternalFailure extends Failure {
  const InternalFailure() : super("Something went wrong");
}

class EmailAlreadyTakenFailure extends Failure {
  const EmailAlreadyTakenFailure() : super("Email is already taken");
}

class UserWithGivenEmailNotFoundFailure extends Failure {
  const UserWithGivenEmailNotFoundFailure() : super("User not found");
}

class InvalidEmailFailure extends Failure {
  const InvalidEmailFailure() : super("Invalid email");
}

class InvalidPasswordFailure extends Failure {
  const InvalidPasswordFailure() : super("Invalid password");
}

class StoryNotFoundFailure extends Failure {
  const StoryNotFoundFailure() : super("Story not found");
}
