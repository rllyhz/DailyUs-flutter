import 'package:daily_us/domain/usecases/get_localization_data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../utils/data_helpers.dart';
import '../repositories/daily_us_repository_test.mocks.dart';

void main() {
  late GetLocalizationData usecase;
  late MockDailyUsRepository mockRepository;

  setUp(() {
    mockRepository = MockDailyUsRepository();
    usecase = GetLocalizationData(mockRepository);
  });

  test('Should get localization data from the repository', () {
    when(mockRepository.getLocalizationData()).thenAnswer(
      (_) => localization,
    );

    final result = usecase.execute();

    expect(result.currentLocale, localeTest);
  });
}
