import 'package:daily_us/common/secrets.dart';
import 'package:flutter_test/flutter_test.dart';

final secretTest = {"base_url": "baseUrlTest"};

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Secrets test', () {
    test('should be able to parse json string', () {
      final secret = AppSecret.fromJson(secretTest);
      expect(secret.baseUrl, 'baseUrlTest');
    });

    test('should return the right data type', () async {
      expect(AppSecretLoader.load(), isA<Future<AppSecret>>());
      expect(await AppSecretLoader.load(), isA<AppSecret>());
    });

    test('should have the proper keys', () async {
      AppSecret secret =
          await AppSecretLoader.load(filePath: 'secrets.test.json');
      expect(secret.baseUrl, 'yourBaseUrlHere');
    });
  });
}
