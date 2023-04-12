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

class RequestNotAllowedFailure extends Failure {
  final String description;

  const RequestNotAllowedFailure(this.description) : super(description);
}
