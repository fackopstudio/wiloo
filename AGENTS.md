# Wiloo Mobile Agent Notes

## Project

Flutter mobile application for Wiloo.

## Commands

```bash
flutter analyze
flutter test
flutter run
```

## Architecture

- `lib/app`: app shell, routing, theme
- `lib/core`: cross-cutting config, network, storage
- `lib/shared`: reusable UI and utilities
- `lib/features`: Clean Architecture by feature

## Guardrails

- No API calls in widgets.
- No business logic in UI.
- Backend is the source of truth.
- Better Auth remains the auth reference.
- Use `--dart-define` for environments.
