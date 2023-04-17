import 'package:daily_us/common/logger.dart';
import 'package:daily_us/common/secrets.dart';
import 'package:dio/dio.dart';

class DailyUsApiClient {
  static Dio? _client;

  static Dio getInstance(AppSecret appSecret) {
    Logger.logWithTag("ApiClient", "BaseUrl: ${appSecret.baseUrl}");

    _client ??= Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        baseUrl: appSecret.baseUrl,
      ),
    );

    return _client!;
  }
}
