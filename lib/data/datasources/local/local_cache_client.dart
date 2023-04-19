import 'dart:convert';

import 'package:daily_us/common/logger.dart';
import 'package:daily_us/data/datasources/local/local_cache_model.dart';
import 'package:daily_us/data/datasources/local/localization_model.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:shared_preferences/shared_preferences.dart';

class DailyUsLocalCacheClient {
  final SharedPreferences pref;
  final String _authInfoKey = "daily_us_local_cache_auth_info_key";
  final String _localizationDataKey = "daily_us_local_cache_localization_key";

  DailyUsLocalCacheClient({required this.pref});

  LocalCacheModel getLocalCacheData() {
    try {
      var cachedData = pref.getString(_authInfoKey);

      if (cachedData != null) {
        return LocalCacheModel.fromJson(json.decode(cachedData));
      } else {
        return const LocalCacheModel(
          isAlreadyLoggedIn: false,
          userEmail: '',
          userId: '',
          userName: '',
          userToken: '',
        );
      }
    } catch (e) {
      return const LocalCacheModel(
        isAlreadyLoggedIn: false,
        userEmail: '',
        userId: '',
        userName: '',
        userToken: '',
      );
    }
  }

  LocalizationModel getLocalizationData() {
    try {
      var localizationJson = pref.getString(_localizationDataKey);

      if (localizationJson != null) {
        return LocalizationModel.fromJson(json.decode(localizationJson));
      } else {
        return const LocalizationModel(
          languageCode: LocalizationModel.defaultlanguageCode,
        );
      }
    } catch (e) {
      Logger.logWithTag(
        "Failed to load localization data from client",
        e.toString(),
      );
      return const LocalizationModel(
        languageCode: LocalizationModel.defaultlanguageCode,
      );
    }
  }

  Future<bool> updateLocalCacheData(LocalCacheModel cacheModel) async {
    try {
      await pref.setString(_authInfoKey, cacheModel.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateLocalizationData(
    LocalizationModel localizationModel,
  ) async {
    try {
      await pref.setString(_localizationDataKey, localizationModel.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  void clearLocalCacheData() async {
    try {
      await pref.remove(_authInfoKey);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
