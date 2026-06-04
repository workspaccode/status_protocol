import 'package:flutter_test/flutter_test.dart';
import 'package:status_protocol/status_protocol.dart';

void main() {
  group('StatusResolver', () {
    test('resolves known 4xx codes', () {
      final config = resolve(404);
      expect(config.code, 404);
      expect(config.title, 'Not Found');
      expect(config.category, StatusCategory.clientError);
    });

    test('resolves known 5xx codes', () {
      final config = resolve(500);
      expect(config.code, 500);
      expect(config.title, 'Server Error');
      expect(config.category, StatusCategory.serverError);
    });

    test('falls back to generic 4xx for unknown 4xx', () {
      final config = resolve(418);
      expect(config.code, 418);
      expect(config.title, 'Client Error');
      expect(config.category, StatusCategory.clientError);
    });

    test('falls back to generic 5xx for unknown 5xx', () {
      final config = resolve(520);
      expect(config.code, 520);
      expect(config.title, 'Server Error');
      expect(config.category, StatusCategory.serverError);
    });

    test('returns no-internet for code 0', () {
      final config = resolve(0);
      expect(config.title, 'No Internet');
    });

    test('returns unknown for negative codes', () {
      final config = resolve(-1);
      expect(config.title, 'Unknown Error');
      expect(config.category, StatusCategory.serverError);
    });
  });
}
