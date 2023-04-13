import 'package:daily_us/common/secrets.dart';
import 'package:dio/dio.dart';

class DailyUsAPIClient {
  Dio? _client;

  BaseOptions provideOptions(String baseUrl) => BaseOptions(
        baseUrl: baseUrl,
      );

  Dio getInstance(AppSecret appSecret) {
    _client ??= Dio(
      provideOptions(appSecret.baseUrl),
    );

    return _client!;
  }
}
