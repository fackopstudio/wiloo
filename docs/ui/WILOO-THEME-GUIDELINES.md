# Wiloo Theme Guidelines

Wiloo has **one** theme source of truth: `lib/app/theme/app_theme.dart`
(`AppTheme` + `WilooColors` + `WilooTokens`). All product surfaces must derive
their colors from the active `ColorScheme` or from `WilooColors`. Do not invent
ad-hoc colors in widgets.

## 1. Brand identity

Wiloo uses a **coherent blue brand**. The Material 3 `ColorScheme` is generated
from a single seed (`WilooColors.brand`, `#2563EB`). The palette must look the
same on iOS, Android, macOS and physical devices.

Why it was inconsistent before:

- The theme had **no `themeMode`**, so each device followed its own OS dark/light
  setting and rendered a different palette. It is now pinned to
  `ThemeMode.light`.
- The seed used to be teal-green (`#1D766F`) while onboarding hardcoded blue, so
  different screens looked like different brands. The seed is now blue and the
  `wilooBlue*` tokens are blue aliases.

## 2. Color tokens

### Brand (blue)
| Token | Hex | Use |
|-------|-----|-----|
| `WilooColors.brand` | `#2D59F0` | Seed, primary actions, brand accents |
| `WilooColors.brandLight` | `#5A7FF5` | Brand highlight / dark-mode accent |
| `WilooColors.brandPressed` | `#1A3FCC` | Hover / pressed state |
| `WilooColors.brandDark` | `#0E1F66` | Immersive brand panels / overlays |
| `WilooColors.brand50` | `#EEF2FE` | Subtle tinted surfaces |
| `WilooColors.brand100` | `#D9E2FD` | Tinted borders |
| `WilooColors.brand200` | `#B3C5FB` | Shadow / border accents |

`AppTheme.wilooBlue` / `wilooBlue50` / `wilooBlue100` are aliases of the brand
tokens (kept for backwards compatibility).

### Semantic status (never use as brand)
| Token | Hex | Meaning |
|-------|-----|---------|
| `WilooColors.success` | `#18794E` | Success / validated |
| `WilooColors.warning` | `#B45309` | Warning / attention |
| `WilooColors.info` | `#2563EB` | Informational (brand blue) |
| `ColorScheme.error` | theme | Errors / destructive |

Compliance status chips use **`ColorScheme` containers** (`primaryContainer`,
`secondaryContainer`, `tertiaryContainer`, …) — keep them semantic; never reuse a
status color as a global brand color.

### Decorative onboarding accents (intentional)
`accentOrange`, `accentGreen`, `accentTeal`, `accentPurple` are used **only** for
onboarding illustrations to differentiate topics. They are not product UI colors.

### Neutrals
`WilooColors.canvas` (`#F5F8FA`) for onboarding/auth canvas; `neutral300`
(`#CBD5E1`) for inactive indicators / hairlines.

## 3. Light theme rules

- `MaterialApp.themeMode` is pinned to `ThemeMode.light` for now.
- `darkTheme` is defined but not used; a dark rollout must be deliberate and
  validated separately (see "Do / Don't").
- Never read `MediaQuery.platformBrightness` to swap palettes.

## 4. Spacing, radius, width (`WilooTokens`)

- Spacing: 8pt scale (`space4 … space40`).
- Radius: `radiusSm` (10), `radiusMd` (14), `radiusLg` (20).
- `maxContentWidth` (1200) caps content on large screens (`PageContainer`).

## 5. Responsive principles

- Use `context.formFactor` / `WilooBreakpoints` (mobile < 600, tablet < 1024,
  desktop ≥ 1024). Prefer these over bespoke per-widget breakpoints.
- Wrap pages in `PageContainer` for centered, max-width, adaptively-padded layout.
- Use `ResponsiveCardGrid` for equal-width card rows.
- Backoffice shell shows a `NavigationRail` on wide layouts and a bottom
  `NavigationBar` on narrow.

## 6. Animation principles

- Use `flutter_animate` via `wilooEntrance` / `wilooScaleIn`: subtle fade +
  short slide/scale, finite (never looping on content).
- Shimmer (`ShimmerBox/Card/List`) only for transient loading states.
- No bouncing, no attention-grabbing motion, never block input.
- Keep durations ~300ms with small staggers (~55ms).

## 7. App modes

- `APP_MODE=backoffice` and `APP_MODE=terminal` may differ in **layout** but must
  share the **same brand palette**. Theme is global and mode-independent.
- Terminal/kiosk can be more focused, but must still read as Wiloo (blue brand).

## 8. Do / Don't

**Do**
- `Theme.of(context).colorScheme.primary` for brand actions.
- `WilooColors.success/warning` for status semantics.
- `WilooTokens` for spacing/radius.

**Don't**
- Don't hardcode `Color(0xFF…)` brand/blue/green in widgets.
- Don't use a status color (green/orange) as a global brand accent.
- Don't branch the palette on platform, role, or app mode.
- Don't enable dynamic color (Material You) — it breaks cross-device consistency.
