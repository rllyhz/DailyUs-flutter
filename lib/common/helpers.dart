import 'package:daily_us/common/failure.dart';
import 'package:daily_us/common/localizations.dart';
import 'package:flutter/material.dart';

bool validateEmailFormat(String email) => RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    .hasMatch(email);

bool validatePasswordFormat(String password) => password.length >= 6;

String getFirstName(String name) => name.split(" ").first;

String getFailureMessage(BuildContext context, Failure failure) {
  var message = '';

  if (failure is NoInternetConnectionFailure) {
    message = AppLocalizations.of(context)!.noConnectionMessage;
  } else if (failure is EmailAlreadyTakenFailure) {
    message = AppLocalizations.of(context)!.emailAlreadyTakenMessage;
  } else if (failure is UserWithGivenEmailNotFoundFailure) {
    message = AppLocalizations.of(context)!.wrongCredentialMessage;
  } else if (failure is InvalidEmailFailure) {
    message = AppLocalizations.of(context)!.emailInvalidMessage;
  } else if (failure is InvalidPasswordFailure) {
    message = AppLocalizations.of(context)!.wrongCredentialMessage;
  } else {
    message = AppLocalizations.of(context)!.internalErrorMessage;
  }

  return message;
}
