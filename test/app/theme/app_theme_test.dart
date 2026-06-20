import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/app/theme/app_theme.dart';

void main() {
  group('AppTheme (Wiloo theme)', () {
    test('light theme is Material 3 with light brightness', () {
      final theme = AppTheme.light;
      expect(theme.useMaterial3, isTrue);
      expect(theme.colorScheme.brightness, Brightness.light);
    });

    test('brand token is blue (blue channel dominant)', () {
      const brand = WilooColors.brand;
      expect(brand.b, greaterThan(brand.r));
      expect(brand.b, greaterThan(brand.g));
    });

    test('wilooBlue aliases resolve to the blue brand tokens', () {
      expect(AppTheme.wilooBlue, WilooColors.brand);
      expect(AppTheme.wilooBlue50, WilooColors.brand50);
      expect(AppTheme.wilooBlue100, WilooColors.brand100);
    });

    test('primary is blue-leaning, not a green fallback', () {
      final primary = AppTheme.light.colorScheme.primary;
      expect(primary.b, greaterThan(primary.r));
      expect(primary.b, greaterThan(primary.g));
    });

    test('dark theme stays in the same blue family', () {
      final darkPrimary = AppTheme.dark.colorScheme.primary;
      expect(darkPrimary.b, greaterThan(darkPrimary.r));
    });

    test('semantic status colors are distinct from the brand', () {
      expect(WilooColors.success, isNot(WilooColors.brand));
      expect(WilooColors.warning, isNot(WilooColors.brand));
      // success stays green-leaning, warning amber-leaning.
      expect(WilooColors.success.g, greaterThan(WilooColors.success.b));
    });
  });
}
