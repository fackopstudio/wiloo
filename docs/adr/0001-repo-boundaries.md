# ADR 0001 - Repository Boundaries

## Status

Accepted.

## Context

Wiloo is split across two repository responsibilities.

The historical `wiloo` platform repository contains the existing product backend and web frontend:

- `apps/backend`: NestJS backend, Better Auth, business API, database access, guards, tenant logic, and domain rules.
- `apps/frontend`: existing Next.js web application that consumes the backend API.

The `wiloo-app-mobile` repository contains only the Flutter mobile application for Android, iOS, and desktop targets.

The mobile app must integrate with the existing backend instead of redefining backend behavior locally.

## Decision

`wiloo-app-mobile` is a Flutter client repository only.

The backend remains the source of truth for:

- authentication and session validity;
- roles and scopes;
- tenant/org context;
- business rules;
- persistence;
- API contracts;
- Timeclock terminal authorization.

Flutter consumes the existing API exposed by the platform backend. Flutter must not create backend endpoints, backend models, backend guards, database migrations, or server-side auth flows from this repository.

Any backend change required by mobile must be proposed and implemented in the backend/platform repository, not in `wiloo-app-mobile`.

## Implications

Flutter may define client-side DTOs, repositories, state controllers, route guards, and UI flows that mirror backend contracts. These client-side pieces must remain consumers of backend behavior, not replacements for it.

Flutter can enforce navigation and display decisions locally for user experience, but authorization remains backend-controlled. A Flutter route guard is a UX and safety layer, not the source of business permission truth.

API compatibility must be checked against backend documentation, Swagger/OpenAPI, or the backend implementation before creating Flutter DTOs.

## Allowed In This Repository

- Flutter application code.
- Flutter route configuration.
- Flutter state management.
- Flutter DTOs and API clients generated from or aligned with backend contracts.
- Mobile-specific UI and platform integration.
- Mobile documentation, ADRs, and Cursor rules.
- Tests for Flutter behavior.

## Not Allowed In This Repository

- Backend endpoint implementation.
- Backend authentication flows.
- Backend guards, interceptors, or decorators.
- Database schema or migration changes.
- Business rule rewrites that belong to the backend.
- Custom mobile auth endpoints.
- JWT systems outside Better Auth.
- Copies of the web frontend as Flutter business logic.

## Non-Negotiable Rules

- The backend is the source of truth.
- Flutter consumes the existing API.
- Flutter does not create backend endpoints.
- Flutter does not modify backend code from this repository.
- Flutter does not duplicate backend business rules beyond client-side UX guards.
- API DTOs must be aligned with backend contracts.
- Any backend requirement discovered during mobile development must be documented and handled in the platform/backend repository.
