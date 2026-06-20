# Wiloo Brand Reference

Source audited: `/Users/moussavoulionelstephen/Wiloo-app-mobile/apps/frontend`

This document captures the visual identity currently used by the Wiloo web frontend so the Flutter app can reuse it consistently.

## Assets

Primary Flutter-ready assets:

- `assets/brand/wiloo_logo_horizontal.png`
  - Source: `apps/frontend/public/wiloo-logos-final/logo-wilo-b-s.png`
  - Size: `1795 x 487`
  - Use for login, splash-adjacent surfaces, app bars with enough horizontal space.
- `assets/brand/wiloo_auth_illustration.jpg`
  - Source: `apps/frontend/public/wiloo-logos-final/IA-willo.jpg`
  - Size: `853 x 1280`
  - Use only where a rich auth/onboarding/terminal illustration is wanted.
- `assets/brand/wiloo-logos-final/`
  - Raw copied logo variants from the web repo.
  - Keep as reference assets. Prefer the normalized asset names above in Flutter widgets.

The web manifest references `/icons/*`, `/screenshots/*`, and `/og-image.png`, but those files are not currently present in `apps/frontend/public`. Do not depend on them in Flutter until real source assets are added.

## Typography

Web source: `apps/frontend/src/app/layout.tsx`

- Font: `Inter`
- Web loading: `next/font/google`
- CSS variable: `--font-inter`
- Fallback stack: `system-ui, -apple-system, sans-serif`

Flutter guidance:

- Prefer a single app-wide text theme.
- Use Inter if the project adds local font files or an approved font dependency.
- Until then, keep platform defaults close to Inter proportions and avoid per-widget font overrides.

## Core Palette

Web source: `apps/frontend/src/app/globals.css`

| Token | Hex | Intended use |
| --- | --- | --- |
| `wilooBlue` | `#2D59F0` | Primary brand color, buttons, active nav, focus ring |
| `wilooBlueLight` | `#5A7FF5` | Brand highlight, charts, dark-mode primary accent |
| `wilooBlueDark` | `#1A3FCC` | Primary hover/pressed state |
| `wilooBlue50` | `#EEF2FE` | Pale primary surface |
| `wilooBlue100` | `#D9E2FD` | Soft primary border/surface |
| `wilooBlue200` | `#B3C5FB` | Primary shadow/border accent |
| `wilooBlue900` | `#0E1F66` | Deep primary contrast |
| `wilooGrey` | `#E9F1FC` | Secondary/muted light surface |
| `wilooGreyDark` | `#DDE5EF` | Border/input |
| `wilooWhite` | `#FFFFFF` | Light surface |

## Semantic Colors

Light mode:

| Token | Hex |
| --- | --- |
| `background` | `#f8fafc` |
| `foreground` | `#0f172a` |
| `card` | `#ffffff` |
| `primary` | `#2D59F0` |
| `secondary` | `#E9F1FC` |
| `mutedForeground` | `#64748b` |
| `accent` | `#EEF2FE` |
| `destructive` | `#ef4444` |
| `border` | `#DDE5EF` |
| `input` | `#DDE5EF` |
| `ring` | `#2D59F0` |

Dark mode:

| Token | Hex |
| --- | --- |
| `background` | `#020617` |
| `foreground` | `#f8fafc` |
| `card` | `#0f172a` |
| `secondary` | `#1e293b` |
| `mutedForeground` | `#94a3b8` |
| `accent` | `#1e293b` |
| `border` | `#1e293b` |
| `input` | `#1e293b` |
| `destructive` | `#7f1d1d` |

Supporting data/status colors:

- Emerald: `#34d399`
- Amber: `#f59e0b`
- Violet: `#8b5cf6`
- Pink: `#ec4899`
- Rose/destructive web variants: `#ef4444`, `#fb7185`

## Shape And Elevation

Web tokens and patterns:

- Base radius: `0.625rem` / `10px`
- Buttons and inputs: usually `12px`
- Cards: usually `16px`, with larger auth surfaces up to `32px`
- Focus ring: brand blue at low opacity
- Primary button shadow: brand blue at low opacity
- Card shadow: subtle slate/black shadow, not heavy decoration

Flutter guidance:

- Use Material 3.
- Keep HR/SaaS screens calm, dense, and legible.
- Prefer theme tokens/extensions over hardcoded widget colors.
- Use 12px controls and 16px cards as the normal mobile baseline.
- Reserve larger radii for auth/onboarding surfaces only.

## Web UI Cues To Preserve

- Clean light surfaces with slate text and blue action emphasis.
- Dark theme support exists on the web, with deep slate backgrounds.
- Primary actions use Wiloo blue.
- Secondary actions use pale blue surfaces.
- Forms use 48px-ish fields, rounded corners, slate borders, and blue focus states.
- Navigation active state uses blue accent plus pale blue background.
- Error states use rose/red surfaces and text.

## Flutter Usage Rules

- Do not calculate business, tax, payroll, or compliance values in UI.
- Do not introduce new brand colors directly in widgets.
- Do not depend on missing web manifest icons until actual files are available.
- Use `assets/brand/wiloo_logo_horizontal.png` instead of raw filenames with spaces.
- Keep wording and layout aligned with the web product, but adapt density and navigation to mobile/tablet/desktop Flutter patterns.
