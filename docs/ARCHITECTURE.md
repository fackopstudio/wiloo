# Architecture Wiloo Mobile

## Objectif

Base Flutter scalable pour une application RH multi-plateforme Android, iOS et desktop.

## Principes

- Clean Architecture par feature.
- UI passive: pas de logique metier dans les widgets.
- API uniquement via repositories/datasources dans `data/`.
- Domain modele les roles, scopes et regles applicatives.
- Presentation contient les widgets, controllers Riverpod et etats d'ecran.

## Structure

```text
lib/
  app/
    app.dart
    router/
    theme/
  core/
    config/
    network/
    storage/
  shared/
  features/
    auth/
    timeclock/
    employee/
    manager/
    hr_admin/
```

## Navigation

`go_router` est centralise dans `lib/app/router`.

La suite doit brancher les redirections selon:

- session authentifiee ou invite
- role: employee, manager, admin
- scope: backoffice, timeclock

## Environnements

`AppConfig` lit:

- `APP_ENV`: dev, staging, prod
- `API_BASE_URL`: URL API NestJS

Ces valeurs sont passees via `--dart-define`.

## Reseau

`Dio` est fourni par Riverpod dans `core/network`.

Les prochaines etapes ajouteront:

- gestion cookies/session Better Auth
- correlation id
- refresh/session bootstrap si necessaire
- erreurs API normalisees

## Stockage securise

`flutter_secure_storage` est isole dans `core/storage` pour eviter les acces directs disperses.
