# Wiloo Mobile App Trajectory

## Executive Decision

Create the Flutter mobile app in a separate repository, recommended name: `wiloo-app-mobile`.

This current repository already contains:
- the NestJS backend
- the Next.js web/PWA frontend
- shared TypeScript contracts
- infrastructure and deployment files

Keeping Flutter in a separate repository will make mobile tooling, release management, CI/CD, native signing and store deployment cleaner.

## Current Backend Surface

The existing backend is a NestJS API with:
- Better Auth session-based authentication
- PostgreSQL through TypeORM
- multi-tenant organization concepts
- role and scope guards
- timeclock endpoints protected by terminal headers
- Swagger available at `/api-docs`
- global API prefix `/api`

Important mobile-facing modules:
- Auth: `/api/auth/*`
- Timeclock: `/api/timeclock/*`
- Attendance
- Leave requests
- Employees
- Dashboard
- Payroll
- Planning

## Current Web Surface

The web/PWA app is a Next.js app under `nexorarh/apps/frontend`.

It already covers:
- login/signup
- dashboard routes
- admin, manager and employee pages
- terminal page
- API services using Axios
- socket provider
- PWA files

The Flutter app should reuse product behavior from this frontend, but it should not be placed inside the Next.js app.

## Recommended Repositories

Recommended split:

```text
wiloo-platform/
  backend + web + contracts + infra

wiloo-app-mobile/
  Flutter Android/iOS/macOS app
```

Future option:
- publish API contracts from `wiloo-platform` to a package or generate OpenAPI clients for Flutter.

## Flutter Setup Path

On macOS:

```bash
brew install --cask android-studio
brew install --cask flutter
flutter doctor
flutter config --enable-macos-desktop
flutter devices
```

Then create the mobile repository:

```bash
flutter create wiloo-app-mobile
cd wiloo-app-mobile
flutter run
```

Correct every issue reported by `flutter doctor`, especially:
- Xcode
- CocoaPods
- Android Studio
- Android SDK licences
- iOS and Android simulators
- macOS desktop support

## Flutter Architecture

Target structure:

```text
lib/
  app/
  core/
  shared/
  features/
    auth/
      data/
      domain/
      presentation/
    timeclock/
      data/
      domain/
      presentation/
    employee/
    manager/
    hr_admin/
```

Recommended packages:
- Riverpod
- go_router
- Dio
- Freezed
- json_serializable
- flutter_secure_storage
- camera
- mobile_scanner or qr_code_scanner
- local_auth if biometric device auth becomes useful

## First Mobile Milestone

MVP mobile should start with:
- environment config
- API client
- auth/session bootstrap
- terminal device config
- timeclock PIN flow
- face capture placeholder
- clock event submission
- role-based employee dashboard shell

Avoid starting with the full HR admin dashboard. The timeclock flow is the strongest mobile-native value.

## Open Questions

Before implementation:
- Will mobile be employee-first, kiosk-first, or both from day one?
- Should terminal credentials be provisioned manually, by QR enrollment, or by admin approval?
- Will the Flutter app use Better Auth cookies directly, or a backend-supported mobile session exchange?
- Should the mobile app support offline queueing for timeclock events?
- Which face recognition provider will replace the current backend stub?
