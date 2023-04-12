import 'dart:convert';

import 'package:daily_us/domain/entities/auth_info.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

abstract class DailyUsLocalCacheDataSource {
  AuthInfo getAuthInfo();

  Future<bool> updateAuthInfo(AuthInfo authInfo);

  void clearAuthInfo();
}

class DailyUsLocalCacheDataSourceImpl implements DailyUsLocalCacheDataSource {
  final SharedPreferences pref;
  final String _key = "daily_us_local_cache_key";

  DailyUsLocalCacheDataSourceImpl({required this.pref});

  @override
  AuthInfo getAuthInfo() {
    try {
      var authInfoJson = pref.getString(_key);

      if (authInfoJson != null) {
        return AuthInfo.fromJson(json.decode(authInfoJson));
      } else {
        return const AuthInfo(
          isAlreadyLoggedIn: false,
          user: null,
        );
      }
    } catch (e) {
      return const AuthInfo(
        isAlreadyLoggedIn: false,
        user: null,
      );
    }
  }

  @override
  Future<bool> updateAuthInfo(AuthInfo authInfo) async {
    try {
      await pref.setString(_key, authInfo.toJson());
      return true;
    } catch (exception) {
      return false;
    }
  }

  @override
  void clearAuthInfo() async {
    try {
      await pref.clear();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
