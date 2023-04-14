import 'package:daily_us/domain/usecases/logout.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../repositories/daily_us_repository_test.mocks.dart';

void main() {
  late Logout usecase;
  late MockDailyUsRepository mockRepository;

  setUp(() {
    mockRepository = MockDailyUsRepository();
    usecase = Logout(mockRepository);
  });

  test('Should be able to perform logout from the repository', () {
    when(
      mockRepository.logout(),
    ).thenAnswer((_) => true);

    final result = usecase.execute();

    expect(result, true);
  });
}
