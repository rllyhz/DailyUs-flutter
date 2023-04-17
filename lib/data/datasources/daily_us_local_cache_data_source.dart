import 'package:daily_us/data/datasources/local/local_cache_client.dart';
import 'package:daily_us/data/datasources/local/local_cache_model.dart';
import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/domain/entities/user.dart';

abstract class DailyUsLocalCacheDataSource {
  AuthInfo getAuthInfo();

  Future<bool> updateAuthInfo(AuthInfo authInfo);

  void clearAuthInfo();
}

class DailyUsLocalCacheDataSourceImpl implements DailyUsLocalCacheDataSource {
  final DailyUsLocalCacheClient localCacheClient;

  DailyUsLocalCacheDataSourceImpl({required this.localCacheClient});

  @override
  AuthInfo getAuthInfo() {
    var cachedData = localCacheClient.getLocalCacheData();

    return AuthInfo(
      isAlreadyLoggedIn: cachedData.isAlreadyLoggedIn,
      user: User(
        id: cachedData.userId,
        token: cachedData.userToken,
        email: cachedData.userEmail,
        name: cachedData.userName,
      ),
    );
  }

  @override
  Future<bool> updateAuthInfo(AuthInfo authInfo) async {
    var cacheModel = LocalCacheModel(
      isAlreadyLoggedIn: authInfo.isAlreadyLoggedIn,
      userId: authInfo.user.id,
      userName: authInfo.user.name,
      userToken: authInfo.user.token,
      userEmail: authInfo.user.email,
    );

    return localCacheClient.updateLocalCacheData(cacheModel);
  }

  @override
  void clearAuthInfo() async {
    localCacheClient.clearLocalCacheData();
  }
}
