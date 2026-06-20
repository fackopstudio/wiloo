# Wiloo Mobile

Application Flutter multi-plateforme pour Wiloo, plateforme RH et pointage intelligent.

## Stack

- Flutter / Dart
- Riverpod
- go_router
- Dio
- Freezed
- json_serializable
- flutter_secure_storage
- Material 3

## Plateformes cible

- Android
- iOS
- macOS desktop
- Windows desktop plus tard

## Architecture

```text
lib/
  app/
    router/
    theme/
  core/
    config/
    network/
    storage/
  shared/
    widgets/
  features/
    auth/
      application/
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

Regles:

- Clean Architecture par feature.
- Aucun appel API directement dans les widgets.
- Aucune logique metier dans la UI.
- Navigation preparee pour roles et scopes.
- Environnements via `--dart-define`.

## Environnements

Dev par defaut:

```bash
flutter run
```

Le fallback local pointe vers le backend Docker Wiloo:

```text
http://localhost:3002/api
```

Pour Android emulator, utiliser l'adresse de l'hote Android:

```bash
flutter run -d emulator --dart-define=API_BASE_URL=http://10.0.2.2:3002/api
```

Pour un appareil physique, utiliser l'adresse IP locale du Mac ou son nom
reseau local. Le nom peut etre obtenu avec `scutil --get LocalHostName`:

```bash
flutter run -d <DEVICE_ID> --dart-define=API_BASE_URL=http://<NOM_DU_MAC>.local:3002/api
```

Staging:

```bash
flutter run --dart-define=APP_ENV=staging --dart-define=API_BASE_URL=https://staging-api.wiloo.app/api
```

Production:

```bash
flutter run --dart-define=APP_ENV=prod --dart-define=API_BASE_URL=https://api.wiloo.app/api
```

## Verification

```bash
flutter analyze
flutter test
```

## Backend

Le backend NestJS existant reste la source de verite. L'application mobile doit consommer les endpoints existants, notamment Better Auth et le module timeclock.
