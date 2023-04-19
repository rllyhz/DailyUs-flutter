import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Localization extends Equatable {
  final Locale currentLocale;

  const Localization({
    required this.currentLocale,
  });

  factory Localization.fromJson(Map<String, dynamic> authJson) => Localization(
        currentLocale: Locale(authJson["languageCode"] ?? 'en'),
      );

  String toJson() => '{"languageCode": "${currentLocale.languageCode}"}';

  @override
  List<Object?> get props => [currentLocale];
}
