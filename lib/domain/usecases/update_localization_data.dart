import 'package:daily_us/common/logger.dart';
import 'package:daily_us/domain/entities/localization.dart';
import 'package:daily_us/domain/repositories/daily_us_repository.dart';

class UpdateLocalizationData {
  final DailyUsRepository _repository;

  const UpdateLocalizationData(this._repository);

  void execute(Localization newLocalization) async {
    Logger.log(
      "UpdateLocalizationDataUsecase being executed!",
      showPadding: true,
    );
    await _repository.updateLocalizationData(newLocalization);
  }
}
