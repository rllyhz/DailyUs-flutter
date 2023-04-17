import 'package:daily_us/common/helpers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Helpers test', () {
    group('getFormattedName test', () {
      test('Should return only first name and middle name', () {
        expect(getFormattedName('Rully Ihza Mahendra'), 'Rully Ihza');
        expect(getFormattedName('Nur Aisyah'), 'Nur Aisyah');
        expect(getFormattedName('Hadi'), 'Hadi');
      });

      test(
          'Should return only first name and abbreviations for the rest if length > 10',
          () {
        expect(getFormattedName('Muhammad Haikal F'), 'Muhammad HF');
        expect(getFormattedName('Ahmad Syahrawi Alrahma'), 'Ahmad SA');
      });
    });
  });
}
