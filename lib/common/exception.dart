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

class ServerException extends DailyUsException {
  ServerException() : super("Connection error to host");
}

class MissingParametersException extends DailyUsException {
  final List<String> requiredParameters;

  MissingParametersException(this.requiredParameters)
      : super("Missing the required parameter(s)");
}

class EmailAlreadyTakenException extends DailyUsException {
  EmailAlreadyTakenException() : super("Email is already taken");
}

class RequestNotAllowedException extends DailyUsException {
  RequestNotAllowedException()
      : super("You're not allowed to perform the request");
}
