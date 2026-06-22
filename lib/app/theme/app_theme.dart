import 'package:flutter/material.dart';

/// Shared design tokens for the Wiloo app.
///
/// Centralizes spacing, radius and content-width values so screens stay
/// visually consistent across mobile, tablet and desktop.
class WilooTokens {
  const WilooTokens._();

  // Spacing scale (8pt-based).
  static const double space2 = 2;
  static const double space4 = 4;
  static const double space8 = 8;
  static const double space12 = 12;
  static const double space16 = 16;
  static const double space20 = 20;
  static const double space24 = 24;
  static const double space28 = 28;
  static const double space32 = 32;
  static const double space40 = 40;

  // Corner radii.
  static const double radiusSm = 10;
  static const double radiusMd = 14;
  static const double radiusLg = 20;

  // Max readable content width on large screens.
  static const double maxContentWidth = 1200;
}

/// Single source of truth for Wiloo brand and semantic colors.
///
/// Wiloo uses a coherent **blue** brand identity. Status colors are semantic
/// and must never be used as the global brand color. Onboarding illustrations
/// may use the decorative accent palette below, but product surfaces should
/// rely on the [ColorScheme] derived from [WilooColors.brand].
class WilooColors {
  const WilooColors._();

  // ── Brand (blue) ──────────────────────────────────────────────────────────
  /// Primary brand blue — Wiloo official primary (#2D59F0).
  /// Used as the Material 3 seed and all primary action surfaces.
  static const Color brand = Color(0xFF2D59F0);

  /// Brand highlight / light variant for charts and dark-mode accents.
  static const Color brandLight = Color(0xFF5A7FF5);

  /// Hover / pressed state for brand primary.
  static const Color brandPressed = Color(0xFF1A3FCC);

  /// Deep navy used on immersive brand panels (e.g. auth illustration overlay).
  /// Corresponds to wilooBlue900 in the web palette.
  static const Color brandDark = Color(0xFF0E1F66);

  /// Tonal brand tints for subtle surfaces and borders.
  static const Color brand50 = Color(0xFFEEF2FE);
  static const Color brand100 = Color(0xFFD9E2FD);
  static const Color brand200 = Color(0xFFB3C5FB);

  // ── Semantic status ───────────────────────────────────────────────────────
  static const Color success = Color(0xFF18794E);
  static const Color warning = Color(0xFFB45309);
  static const Color info = brand;

  // ── Decorative onboarding accents (intentional, not brand) ─────────────────
  static const Color accentOrange = Color(0xFFE85D3F);
  static const Color accentGreen = Color(0xFF18794E);
  static const Color accentTeal = Color(0xFF0F766E);
  static const Color accentPurple = Color(0xFF7C5CFC);

  // ── Neutrals ────────────────────────────────────────────────────────────────
  /// Soft app canvas used behind onboarding/auth.
  static const Color canvas = Color(0xFFF5F8FA);

  /// Inactive indicator / hairline neutral.
  static const Color neutral300 = Color(0xFFCBD5E1);
}

class AppTheme {
  const AppTheme._();

  static const _seed = WilooColors.brand;

  /// Brand accent and tonal tints — aliases of [WilooColors] for call sites
  /// that predate the consolidated token layer.
  static const Color wilooBlue = WilooColors.brand;
  static const Color wilooBlue50 = WilooColors.brand50;
  static const Color wilooBlue100 = WilooColors.brand100;

  static ThemeData get light => _build(Brightness.light);

  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _seed,
      brightness: brightness,
    );

    final base = ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      visualDensity: VisualDensity.standard,
    );

    return base.copyWith(
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: false,
        titleTextStyle: base.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        color: colorScheme.surface,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(WilooTokens.radiusMd),
          side: BorderSide(color: colorScheme.outlineVariant),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: WilooTokens.space20,
            vertical: WilooTokens.space12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(WilooTokens.radiusSm),
          ),
          textStyle: base.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            horizontal: WilooTokens.space20,
            vertical: WilooTokens.space12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(WilooTokens.radiusSm),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: WilooTokens.space16,
          vertical: WilooTokens.space16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(WilooTokens.radiusSm),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(WilooTokens.radiusSm),
          borderSide: BorderSide(color: colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(WilooTokens.radiusSm),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(WilooTokens.radiusLg),
        ),
        side: BorderSide.none,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(WilooTokens.radiusSm),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colorScheme.outlineVariant,
        space: 1,
        thickness: 1,
      ),
    );
  }
}
