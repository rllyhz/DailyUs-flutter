import 'dart:convert';

import 'package:daily_us/data/datasources/local/local_cache_model.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:shared_preferences/shared_preferences.dart';

class DailyUsLocalCacheClient {
  final SharedPreferences pref;
  final String _key = "daily_us_local_cache_key";

  DailyUsLocalCacheClient({required this.pref});

  LocalCacheModel getLocalCacheData() {
    try {
      var cachedData = pref.getString(_key);

      if (cachedData != null) {
        return LocalCacheModel.fromJson(json.decode(cachedData));
      } else {
        return LocalCacheModel(
          isAlreadyLoggedIn: false,
          userId: "",
          userName: "",
          userToken: "",
        );
      }
    } catch (e) {
      return LocalCacheModel(
        isAlreadyLoggedIn: false,
        userId: "",
        userName: "",
        userToken: "",
      );
    }
  }

  Future<bool> updateLocalCacheData(LocalCacheModel cacheModel) async {
    try {
      await pref.setString(_key, cacheModel.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  void clearLocalCacheData() async {
    try {
      await pref.clear();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
