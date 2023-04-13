import 'package:daily_us/common/secrets.dart';
import 'package:dio/dio.dart';

class DailyUsApiClient {
  Dio? _client;

  Dio getInstance(AppSecret appSecret) {
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
