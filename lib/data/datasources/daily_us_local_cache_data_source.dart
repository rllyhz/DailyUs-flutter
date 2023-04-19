import 'package:daily_us/common/logger.dart';
import 'package:daily_us/data/datasources/local/local_cache_client.dart';
import 'package:daily_us/data/datasources/local/local_cache_model.dart';
import 'package:daily_us/data/datasources/local/localization_model.dart';
import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:daily_us/domain/entities/localization.dart';
import 'package:daily_us/domain/entities/user.dart';
import 'package:flutter/material.dart';

abstract class DailyUsLocalCacheDataSource {
  AuthInfo getAuthInfo();

  Localization getLocalizationData();

  Future<bool> updateAuthInfo(AuthInfo authInfo);

  Future<bool> updateLocalizationData(Localization localization);

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
  Localization getLocalizationData() {
    var localization = localCacheClient.getLocalizationData();

    Logger.logWithTag(
      "getLocalizationData in datasource",
      localization.toJson(),
    );

    return Localization(
      currentLocale: Locale(localization.languageCode),
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
  Future<bool> updateLocalizationData(Localization newLocalization) async {
    var localizationModel = LocalizationModel(
      languageCode: newLocalization.currentLocale.languageCode,
    );

    Logger.logWithTag(
      "updateLocalizationData in datasource",
      localizationModel.toJson(),
    );

    return localCacheClient.updateLocalizationData(localizationModel);
  }

  @override
  void clearAuthInfo() async {
    localCacheClient.clearLocalCacheData();
  }
}
