import 'package:daily_us/data/datasources/daily_us_local_cache_data_source.dart';
import 'package:daily_us/data/datasources/local/local_cache_model.dart';
import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../utils/data_helpers.dart';
import '../../utils/test_helpers.mocks.dart';

void main() {
  late MockDailyUsLocalCacheClient mockLocalCacheClient;
  late DailyUsLocalCacheDataSourceImpl dataSource;

  setUp(() {
    mockLocalCacheClient = MockDailyUsLocalCacheClient();
    dataSource = DailyUsLocalCacheDataSourceImpl(
      localCacheClient: mockLocalCacheClient,
    );
  });

  group("DailyUsLocalCacheDataSource Testing Usecases", () {
    test(
        'Should return true-state authInfo when retrieving cachedData is success',
        () {
      when(mockLocalCacheClient.getLocalCacheData()).thenAnswer(
        (_) => const LocalCacheModel(
            isAlreadyLoggedIn: true,
            userId: id,
            userName: name,
            userToken: token),
      );

      final result = dataSource.getAuthInfo();

      verify(mockLocalCacheClient.getLocalCacheData()).called(1);

      expect(result.isAlreadyLoggedIn, true);
      expect(result.user.id, id);
      expect(result.user.name, name);
      expect(result.user.token, token);
    });

    test('Should return true when updating authinfo is success', () async {
      var cachedModel = const LocalCacheModel(
        isAlreadyLoggedIn: true,
        userId: id,
        userName: name,
        userToken: token,
      );

      when(mockLocalCacheClient.updateLocalCacheData(cachedModel))
          .thenAnswer((_) async => true);

      final result = await dataSource.updateAuthInfo(
        AuthInfo(
            isAlreadyLoggedIn: cachedModel.isAlreadyLoggedIn,
            user: User(
              id: cachedModel.userId,
              token: cachedModel.userToken,
              name: cachedModel.userName,
            )),
      );

      verify(mockLocalCacheClient.updateLocalCacheData(cachedModel)).called(1);
      expect(result, true);
    });
  });
}
