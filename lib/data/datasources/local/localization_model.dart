import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'localization_model.g.dart';

@JsonSerializable()
class LocalizationModel extends Equatable {
  final String languageCode;

  const LocalizationModel({
    this.languageCode = 'en',
  });

  static const String defaultlanguageCode = 'en';

  factory LocalizationModel.fromJson(Map<String, dynamic> json) =>
      _$LocalizationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocalizationModelToJson(this);

  @override
  List<Object?> get props => [languageCode];
}
