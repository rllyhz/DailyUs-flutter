abstract class DailyUsException implements Exception {
  final String message;

  DailyUsException(this.message);
}

class UnknownException extends DailyUsException {
  UnknownException() : super("Something went wrong unexpectedly");
}

class NoInternetConnectionException extends DailyUsException {
  NoInternetConnectionException() : super("No internet connection");
}

class InternalException extends DailyUsException {
  InternalException() : super("Something went wrong");
}

class ServerException extends DailyUsException {
  ServerException() : super("Connection error to host");
}

class EmailAlreadyTakenException extends DailyUsException {
  EmailAlreadyTakenException() : super("Email is already taken");
}

class UserWithGivenEmailNotFoundException extends DailyUsException {
  UserWithGivenEmailNotFoundException() : super("User not found");
}

class InvalidPasswordException extends DailyUsException {
  InvalidPasswordException() : super("Invalid password");
}

class InvalidEmailException extends DailyUsException {
  InvalidEmailException() : super("Invalid email");
}

class RequestNotAllowedException extends DailyUsException {
  RequestNotAllowedException()
      : super("You're not allowed to perform the request");
}
