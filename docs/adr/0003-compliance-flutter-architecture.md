# ADR 0003 - Compliance Flutter Architecture

## Status

Accepted.

## Context

The backend Compliance API contract is confirmed in `docs/BACKEND-API-REFERENCE.md` under the "Compliance social & fiscal" section.

The Flutter app must implement the Social & Tax Compliance module as a client of the existing backend API. Flutter must display, trigger, validate user input, export, and download files, but it must never calculate tax or social contribution rules locally.

The backend controller base path is:

```text
/api/compliance
```

The backend protects Compliance with:

- `BetterAuthGuard`
- `RolesGuard`
- `TenantInterceptor`

There is no dedicated Compliance scope string today. The effective access model is role + tenant.

## Decision

The Flutter Compliance feature will live under:

```text
lib/features/compliance/
  data/
  domain/
  presentation/
```

The backend remains the source of truth for:

- tenant resolution;
- role-based access;
- declaration periods;
- social/fiscal declarations;
- declaration transitions;
- generated totals;
- exports;
- archived state;
- validation and transition errors.

Flutter uses `GeneralApiClient` only for Compliance. The Timeclock terminal client must not be used for Compliance.

Flutter must never send a locally selected `tenantId` to Compliance endpoints. Tenant context comes from the authenticated backend session and the backend `TenantInterceptor`.

Flutter must never calculate tax, fiscal, or social contribution amounts. It displays backend-provided totals as-is. Backend totals may arrive as numbers or strings, so Flutter may parse them for formatting only, without performing fiscal/social arithmetic.

## Confirmed Backend Routes

Flutter will map the Compliance repository to the confirmed backend routes:

```text
GET  /api/compliance/periods
POST /api/compliance/periods

GET  /api/compliance/declarations
POST /api/compliance/declarations/generate
GET  /api/compliance/declarations/:id

POST /api/compliance/declarations/:id/mark-ready
POST /api/compliance/declarations/:id/validate
POST /api/compliance/declarations/:id/export
GET  /api/compliance/declarations/:id/exports/:exportId/download
POST /api/compliance/declarations/:id/mark-submitted
POST /api/compliance/declarations/:id/archive
```

JSON routes return the global API envelope:

```json
{
  "success": true,
  "data": {},
  "error": null,
  "meta": {}
}
```

Errors must map to Flutter `Failure` types before reaching presentation widgets.

## Dashboard

There is no Compliance dashboard endpoint in the confirmed backend contract.

`ComplianceDashboardPage` must be composed from:

- `GET /api/compliance/periods`
- `GET /api/compliance/declarations`

The dashboard may aggregate counts and visual summaries for display, but must not calculate fiscal/social totals or legal compliance rules.

## Export And Download

Export is synchronous.

`POST /api/compliance/declarations/:id/export` creates and stores a `DeclarationExport` on the backend. The backend stores the generated file through `storageKey`.

The backend does not return a signed URL for export download.

The runtime-confirmed `POST /api/compliance/declarations/:id/export` response
is a composite payload:

```json
{
  "declaration": {},
  "export": { "id": "..." },
  "download": { "exportId": "...", "fileName": "...", "mimeType": "..." }
}
```

Flutter must preserve the raw export snapshot while reading the download id
from the confirmed locations, in this order:

1. top-level `id` or `exportId` for backward compatibility;
2. nested `export.id` or `export.exportId`;
3. nested `download.exportId` or `download.id`.

Download uses a binary stream:

```text
GET /api/compliance/declarations/:id/exports/:exportId/download
```

The download response must bypass the JSON envelope decoder. Flutter must handle it as binary data and read headers such as:

- `Content-Type`
- `Content-Disposition`
- `X-Content-Type-Options`

## Declaration Types

Confirmed declaration types:

- `CNSS`
- `CNAMGS`
- `IRPP`
- `IS`

`IS` exists in the backend enum but is not ready as a full mobile feature. Flutter must gate it as unavailable until the backend implementation is ready.

Flutter must not present `IS` as a complete supported workflow.

## Declaration Statuses

Confirmed statuses:

- `DRAFT`
- `READY_TO_REVIEW`
- `VALIDATED`
- `EXPORTED`
- `SUBMITTED_MANUALLY`
- `ARCHIVED`

Flutter may use the confirmed transition table to enable or disable UI actions, but the backend remains authoritative. Invalid transitions are expected to return backend errors, including `400`.

## RBAC

Confirmed route access:

- `admin`: read + write
- `hr`: read + write
- `manager`: read-only on explicitly opened read routes
- `employee`: no access
- `supervisor`: no access
- `time_terminal`: no access

Manager read-only means:

- may read periods;
- may read declarations;
- may read declaration details;
- may not create periods;
- may not generate declarations;
- may not mark ready;
- may not validate;
- may not export;
- may not download exports;
- may not mark submitted;
- may not archive.

Flutter route guards and UI permissions are UX safeguards only. Backend RBAC remains the source of truth.

## Flutter Feature Architecture

The feature will use Clean Architecture by feature:

```text
lib/features/compliance/
  data/
    datasources/
    dtos/
    mappers/
    repositories/
  domain/
    entities/
    enums/
    value_objects/
    repositories/
  presentation/
    pages/
    providers/
    widgets/
```

Data layer responsibilities:

- call the confirmed `/api/compliance/*` routes through `GeneralApiClient`;
- decode JSON envelope responses;
- bypass the JSON decoder for binary downloads;
- map backend errors to `Failure`;
- map DTOs to domain models.
- keep raw nested DTO snapshots for compatibility while exposing only runtime-
  confirmed convenience fields.

Domain layer responsibilities:

- represent declaration periods, declarations, exports, attachments, and access capabilities;
- represent backend enums exactly;
- keep fiscal/social amounts as backend-provided display values;
- expose repository interfaces.

Presentation layer responsibilities:

- render the seven target screens;
- use Riverpod providers/controllers;
- trigger repository commands;
- show loading, success, and failure states;
- avoid direct API calls in widgets;
- avoid local fiscal/social calculations.

## Target Screens

The Compliance module will provide:

- `ComplianceDashboardPage`
- `DeclarationPeriodsPage`
- `DeclarationListPage`
- `DeclarationDetailPage`
- `DeclarationGeneratePage`
- `DeclarationExportPage`
- `DeclarationArchivePage`

`DeclarationArchivePage` should use the confirmed declaration list route filtered by `status=ARCHIVED`; no separate archive endpoint is confirmed.

## Pending Confirmations Before Final Data Layer

Before implementing final DTOs and mappers, confirm the following fields and response details from the full backend contract or backend source:

- exact `DeclarationAttachment` fields;
- pagination behavior for `GET /periods` and `GET /declarations`.

`DeclarationLine`, `DeclarationExport`, and the composite export response shape
are now runtime-confirmed for the smoke test dataset, so Flutter may expose
stable convenience fields for those values while preserving the original raw
snapshots. `DeclarationAttachment` was not present in sampled runtime payloads
and must remain raw/untyped until a real payload confirms its structure.

## Non-Negotiable Rules

- Backend remains the source of truth.
- Use `GeneralApiClient` only for Compliance.
- Never use the Timeclock terminal client for Compliance.
- Never send `tenantId` locally to bypass or select tenant context.
- Never calculate tax or social contribution rules in Flutter.
- Display backend-provided totals as-is.
- Map all errors to `Failure` before presentation.
- Do not call APIs directly from widgets.
- Do not invent endpoints, statuses, DTO fields, export behavior, or pagination.
- Gate `IS` as unavailable until backend support is complete.
- Respect RBAC exactly: `admin/hr` read-write, `manager` read-only, `employee/supervisor/time_terminal` no access.
