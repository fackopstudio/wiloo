# API Contracts

## Source de verite

Le backend NestJS existant est la source de verite. Le mobile doit s'aligner sur Swagger/OpenAPI et les contrats exposes par la plateforme backend/web.

## Base URL

Dev par defaut:

```text
http://localhost:3000/api
```

Configurable avec:

```bash
--dart-define=API_BASE_URL=...
```

## Auth

Better Auth est expose sous:

```text
/api/auth/*
```

Ne pas creer de systeme JWT parallele.

## Timeclock

Headers terminal requis:

```text
x-terminal-device-id
x-terminal-api-key
```

Flux:

```text
POST /api/timeclock/pin
POST /api/timeclock/qr
POST /api/timeclock/nfc
POST /api/timeclock/face-verify
POST /api/timeclock/clock
GET  /api/timeclock/status/:employeeId
```

## DTO Flutter

Les DTO seront crees dans `features/*/data` et generes avec `freezed` + `json_serializable` lorsque les endpoints seront branches.
