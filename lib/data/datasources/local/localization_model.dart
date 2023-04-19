import 'package:equatable/equatable.dart';

class LocalizationModel extends Equatable {
  final String languageCode;

  const LocalizationModel({
    required this.languageCode,
  });

  static const String defaultlanguageCode = 'en';

  factory LocalizationModel.fromJson(Map<String, dynamic> strJson) =>
      LocalizationModel(
        languageCode:
            strJson["languageCode"] ?? LocalizationModel.defaultlanguageCode,
      );

  String toJson() => '{"languageCode": "$languageCode"}';

  @override
  List<Object?> get props => [languageCode];
}
