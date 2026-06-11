# ADR 0002 - Better Auth Mobile Session Strategy

## Status

Accepted.

## Context

`wiloo-app-mobile` is the Flutter client for the existing Wiloo platform. The backend lives in the historical `wiloo` platform repository under `apps/backend` and uses Better Auth for session-based authentication.

The mobile app must authenticate against the existing Better Auth backend. It must not create a parallel JWT system, a custom mobile auth endpoint, or local authorization rules that replace backend decisions.

The backend exposes Better Auth under:

```text
/api/auth/*
```

The authenticated backoffice surface uses Better Auth session state, role, scope, and tenant/org context. The expected roles are:

- `admin`
- `hr`
- `manager`
- `supervisor`
- `employee`
- `time_terminal`

The expected scopes are:

- `BACKOFFICE`
- `TIMECLOCK`

The Timeclock terminal flow is separate from user authentication. It uses terminal credentials:

- `x-terminal-device-id`
- `x-terminal-api-key`

Those headers are required for `/api/timeclock/*` and must not be replaced by a user bearer token.

## Options Rejected

### Cookie Jar Dio as the primary session transport

This keeps Better Auth cookies as the Flutter transport and persists them through a Dio cookie jar.

It is rejected as the primary strategy because it adds platform and environment complexity without enough benefit:

- cookie persistence must be secured explicitly;
- production `Secure` cookie behavior differs from local HTTP development;
- domain/path matching and cookie rotation add operational fragility;
- the backend can support a cleaner official native transport.

Cookie Jar may remain a fallback only if the official Better Auth Bearer plugin cannot be used correctly.

### Custom mobile authentication endpoint

This would add backend endpoints dedicated to Flutter and issue a custom token for mobile clients.

It is rejected because it risks creating a parallel auth system, especially a JWT-like model outside Better Auth. That would violate Wiloo's constraints and could duplicate role, scope, session, tenant, revocation, and 2FA behavior.

No custom mobile auth endpoint should be created if the official Better Auth Bearer plugin works.

### Local session state as the source of truth

This would trust cached Flutter state, decoded client-side claims, or persisted user data to determine access.

It is rejected because role, scope, tenant/org context, revocation, and session validity must come from the backend. Flutter may cache a last known UI state for convenience, but authorization decisions and route guards must be based on `/api/auth/get-session`.

## Decision

Wiloo Mobile will use the official Better Auth Bearer plugin as the session transport for native clients, if available and validated against the backend.

The Better Auth session token returned by the backend will be stored in `flutter_secure_storage`. Flutter will send it on authenticated backoffice API requests as:

```text
Authorization: Bearer <better-auth-session-token>
```

The token is an opaque Better Auth session token. It is not a JWT and must not be decoded or treated as a source of claims in Flutter.

`/api/auth/get-session` is the single source of truth for:

- authentication state;
- user identity;
- role;
- scope;
- tenant/org context;
- session validity.

The app will use separate API clients:

- a general API client for Better Auth and protected backoffice endpoints;
- a Timeclock terminal client for `/api/timeclock/*`.

The Timeclock terminal client uses `x-terminal-device-id` and `x-terminal-api-key`. It must not send or depend on the user bearer token.

## Backend Impact

Backend changes are not made from `wiloo-app-mobile`. If the backend does not already support the official Better Auth Bearer plugin, that work must be done in the backend/platform repository.

The backend must:

- enable or expose the official Better Auth Bearer plugin behavior;
- keep browser/web authentication compatible with existing cookie-based Better Auth sessions;
- ensure `auth.api.getSession()` and existing guards resolve sessions from `Authorization: Bearer <token>`;
- verify that `BetterAuthGuard`, `RolesGuard`, and `TenantInterceptor` behave the same for bearer sessions as for cookie sessions;
- ensure session response data exposes role, scope, and tenant/org context needed by Flutter;
- verify the two-factor flow remains compatible with the bearer session strategy;
- avoid adding custom mobile auth endpoints while the Bearer plugin works;
- avoid issuing JWTs for Flutter.

Backend validation should include an end-to-end flow:

1. sign in with email/password;
2. capture the `set-auth-token` response header;
3. call `/api/auth/get-session` with `Authorization: Bearer <token>`;
4. confirm the session includes role, scope, and tenant/org context;
5. call a protected role-scoped endpoint with the same bearer token.

## Flutter Impact

Flutter must:

- store the Better Auth token only in `flutter_secure_storage`;
- never store the token in plain preferences, logs, source code, or public dart defines;
- inject `Authorization: Bearer <token>` only in the general API client;
- capture `set-auth-token` on successful auth responses and token rotation;
- call `/api/auth/get-session` during app bootstrap and after auth changes;
- drive session state from `/api/auth/get-session`;
- guard routes by session state, role, scope, and tenant/org context when applicable;
- align role modeling with `admin`, `hr`, `manager`, `supervisor`, `employee`, and `time_terminal`;
- align scope modeling with `BACKOFFICE` and `TIMECLOCK`;
- keep Timeclock terminal requests in a separate Dio client using terminal headers;
- clear the stored token and return to guest state on `401` or invalid session.

Flutter must not:

- decode the Better Auth token;
- infer roles or scopes from local storage;
- create a JWT-only auth model;
- create backend endpoints;
- touch backend code from this repository;
- send user bearer tokens to terminal-only endpoints as a substitute for terminal credentials.

## Risks

### Bearer plugin compatibility

There is a risk that the backend Better Auth integration does not read the bearer header correctly in the current NestJS adapter or middleware chain.

Mitigation: validate this in the backend/platform repository before Flutter depends on it.

### Token leakage on device

The session token is sensitive. If the device is compromised, the token may be extracted.

Mitigation: store it in `flutter_secure_storage`, avoid logging, support backend revocation, and use reasonable session lifetime settings.

### Token rotation not persisted

If Better Auth rotates or refreshes the session token and Flutter ignores the `set-auth-token` header, the app may keep an outdated token.

Mitigation: capture `set-auth-token` on every general API response, not only on login.

### Role and scope drift

Flutter may model only a subset of backend roles or scopes.

Mitigation: keep role and scope enums aligned with the backend and always resolve current access through `/api/auth/get-session`.

### Confusing terminal and user authentication

The terminal flow is protected by terminal device credentials, not by user sessions.

Mitigation: maintain separate API clients and never mix terminal headers with the user bearer interceptor.

## Non-Negotiable Rules

- Use the official Better Auth Bearer plugin for native user sessions if available.
- Store the Better Auth session token in `flutter_secure_storage`.
- Treat `/api/auth/get-session` as the only source of truth for authenticated user state.
- Never create a parallel JWT auth system.
- Never create a custom mobile auth endpoint if the Better Auth Bearer plugin works.
- Never infer role, scope, tenant, or session validity from the local token.
- Keep the general API client separate from the Timeclock terminal client.
- The general API client may use `Authorization: Bearer <token>`.
- The Timeclock terminal client must use `x-terminal-device-id` and `x-terminal-api-key`.
- The Timeclock terminal client must not rely on the user bearer token.
- Respect backend roles: `admin`, `hr`, `manager`, `supervisor`, `employee`, `time_terminal`.
- Respect backend scopes: `BACKOFFICE`, `TIMECLOCK`.
- Do not modify backend code from `wiloo-app-mobile`.
