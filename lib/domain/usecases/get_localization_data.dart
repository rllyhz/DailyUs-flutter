import 'package:daily_us/common/logger.dart';
import 'package:daily_us/domain/entities/localization.dart';
import 'package:daily_us/domain/repositories/daily_us_repository.dart';

class GetLocalizationData {
  final DailyUsRepository _repository;

  const GetLocalizationData(this._repository);

  Localization execute() {
    Logger.log(
      "GetLocalizationDataUsecase being executed!",
      showPadding: true,
    );
    return _repository.getLocalizationData();
  }
}
