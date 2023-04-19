import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Localization extends Equatable {
  final Locale currentLocale;

  const Localization({
    required this.currentLocale,
  });

  factory Localization.fromJson(Map<String, dynamic> authJson) => Localization(
        currentLocale: authJson["locale"] ?? const Locale('en'),
      );

  String toJson() => '{"locale": $currentLocale}';

  @override
  List<Object?> get props => [currentLocale];
}
