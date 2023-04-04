import 'dart:async' show Future;
import 'dart:convert';
import 'package:flutter/material.dart' show debugPrint;
import 'package:flutter/services.dart' show rootBundle;

class AppSecret {
  final String baseUrl;

  const AppSecret({this.baseUrl = ""});

  factory AppSecret.fromJson(Map<String, dynamic> jsonMap) => AppSecret(
        baseUrl: jsonMap["base_url"],
      );
}

class AppSecretLoader {
  static Future<AppSecret> load({String filePath = "secrets.json"}) async =>
      await rootBundle.loadStructuredData(filePath, (secretJsonStr) async {
        AppSecret secret;

        try {
          secret = AppSecret.fromJson(json.decode(secretJsonStr));
        } catch (exception) {
          secret = const AppSecret();
          debugPrint(exception.toString());
        }

        return secret;
      });
}
