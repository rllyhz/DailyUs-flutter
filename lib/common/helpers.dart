import 'package:daily_us/common/failure.dart';
import 'package:daily_us/common/localizations.dart';
import 'package:daily_us/common/logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

bool validateEmailFormat(String email) => RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    .hasMatch(email);

bool validatePasswordFormat(String password) => password.length >= 6;

String getFirstName(String name) => name.split(" ").first;
String getFormattedName(String name) {
  var formattedName = '';
  var splittedNames = name.split(" ");

  if (splittedNames.length < 3) {
    formattedName = name;
  } else {
    formattedName = "${splittedNames[0]} ${splittedNames[1]}";
    if (formattedName.length > 10) {
      var firstName = '';
      var lastName = '';
      splittedNames.asMap().forEach((key, value) {
        if (key == 0) {
          firstName = value;
        } else {
          lastName += value[0];
        }
      });
      formattedName = "$firstName $lastName";
    }
  }

  return formattedName;
}

String getFormattedDate(BuildContext context, String date) {
  try {
    var createdDateTime = DateTime.parse(date);
    var diff = DateTime.now().difference(createdDateTime);
    var day = diff.inDays;
    var hour = diff.inHours;
    var min = diff.inMinutes;
    var sec = diff.inSeconds;

    var formattedDate = '';

    if (day > 0) {
      formattedDate = AppLocalizations.of(context)!.dateInDays(day);
    } else if (hour > 0) {
      formattedDate = AppLocalizations.of(context)!.dateInHours(hour);
    } else if (min > 0) {
      formattedDate = AppLocalizations.of(context)!.dateInMinutes(min);
    } else if (sec > 0) {
      formattedDate = AppLocalizations.of(context)!.dateInSeconds(sec);
    } else {
      formattedDate = AppLocalizations.of(context)!.dateInJustNow;
    }

    return formattedDate;
    //
  } catch (e) {
    Logger.logWithTag("Parse Date String", e.toString());
    return 'UnknownTime';
  }
}

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
  } else if (failure is StoryNotFoundFailure) {
    message = AppLocalizations.of(context)!.storyNotFoundMessage;
  } else {
    message = AppLocalizations.of(context)!.internalErrorMessage;
  }

  return message;
}

Future<List<int>> compressImage(Uint8List bytes) async {
  int imageLength = bytes.length;
  if (imageLength < 1000000) return bytes;

  final img.Image image = img.decodeImage(bytes)!;
  int compressQuality = 100;
  int length = imageLength;
  Uint8List newByte;

  do {
    compressQuality -= 10;
    newByte = img.encodeJpg(
      image,
      quality: compressQuality,
    );
    length = newByte.length;
  } while (length > 1000000);

  return newByte;
}

Map<String, String> getCountryDetailOfLocale(
  BuildContext context,
  Locale locale,
) {
  Map<String, String> country = {};

  if (locale.languageCode == 'en') {
    country['language_code'] = 'en';
    country['name'] = AppLocalizations.of(context)!.languageEn;
  } else {
    country['language_code'] = 'id';
    country['name'] = AppLocalizations.of(context)!.languageId;
  }

  return country;
}
