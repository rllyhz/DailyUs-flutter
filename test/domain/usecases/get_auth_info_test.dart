import 'package:daily_us/domain/usecases/get_auth_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../utils/data_helpers.dart';
import '../repositories/daily_us_repository_test.mocks.dart';

void main() {
  late GetAuthInfo usecase;
  late MockDailyUsRepository mockRepository;

  setUp(() {
    mockRepository = MockDailyUsRepository();
    usecase = GetAuthInfo(mockRepository);
  });

  test('Should get auth info from the repository', () {
    when(mockRepository.getAuthInfo()).thenAnswer(
      (_) => authInfo,
    );

    final result = usecase.execute();

    expect(result, isNotNull);
    expect(result!.isAlreadyLoggedIn, true);
  });
}
