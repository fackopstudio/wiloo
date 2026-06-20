import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/core/config/app_config.dart';
import 'package:wiloo/core/config/app_mode.dart';

void main() {
  group('AppConfig', () {
    test('defaults to backoffice mode when APP_MODE is not provided', () {
      // No --dart-define=APP_MODE is passed in the test runner.
      expect(AppConfig.appMode, AppMode.backoffice);
    });

    test('apiBaseUrl is honored from dart-define with a visible dev default',
        () {
      const injected = String.fromEnvironment('API_BASE_URL');

      if (injected.isEmpty) {
        // No override: the safe dev default is used and flagged as such.
        expect(AppConfig.usesDefaultApiBaseUrl, isTrue);
        expect(AppConfig.apiBaseUrl, 'http://localhost:3002/api');
      } else {
        expect(AppConfig.apiBaseUrl, injected);
        expect(AppConfig.usesDefaultApiBaseUrl, isFalse);
      }
    });

    test('summary surfaces the effective mode and api base url', () {
      expect(AppConfig.summary, contains('mode=${AppConfig.appMode.name}'));
      expect(AppConfig.summary, contains('apiBaseUrl=${AppConfig.apiBaseUrl}'));
    });
  });

  group('AppMode.fromName', () {
    test('parses known modes', () {
      expect(AppMode.fromName('backoffice'), AppMode.backoffice);
      expect(AppMode.fromName('terminal'), AppMode.terminal);
    });

    test('falls back to backoffice for unknown values', () {
      expect(AppMode.fromName('kiosk'), AppMode.backoffice);
      expect(AppMode.fromName(''), AppMode.backoffice);
    });
  });
}
