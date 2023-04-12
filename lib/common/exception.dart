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

class ServerFailureException extends DailyUsException {
  ServerFailureException() : super("Connection error to host");
}

class RequestNotAllowedException extends DailyUsException {
  RequestNotAllowedException()
      : super("You're not allowed to perform the request");
}
