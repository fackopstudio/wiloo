# Frontend Web Reference - Wiloo/NexoraRH

## But du document

Ce document sert de repere pour comprendre le frontend web existant avant d'implementer les flux equivalents dans l'application Flutter `wiloo`.

Source auditee:

```text
/Users/moussavoulionelstephen/Wiloo-app-mobile/nexorarh/apps/frontend
```

## Stack web existante

- Next.js 16
- React 19
- TypeScript
- Tailwind CSS v4
- Axios
- Better Auth client
- Zustand pour un store auth local
- Framer Motion / Motion
- Lucide React
- Playwright pour les tests e2e
- PWA: manifest, service worker, offline page

## Structure fonctionnelle

```text
src/app/
  (auth)/login
  (auth)/signup
  (dashboard)/dashboard
  (dashboard)/attendance
  (dashboard)/leaves
  (dashboard)/planning
  (dashboard)/profile
  (dashboard)/admin
  (dashboard)/manager
  terminal

src/services/
  api/axios.ts
  api/timeclock.service.ts
  auth.service.ts
  employee.service.ts
  attendance.service.ts
  leave.service.ts
  dashboard.service.ts
  manager.service.ts
  payroll.service.ts
  admin.service.ts

src/components/
  auth/
  layout/
  timeclock/
  ui/
```

## Client API web general

Le client general est `src/services/api/axios.ts`.

Comportements importants:

- base URL: `NEXT_PUBLIC_API_URL` ou `http://localhost:3000/api`
- `withCredentials: true` pour envoyer les cookies Better Auth
- header `X-Correlation-Id` ajoute a chaque requete
- timeout 30 secondes
- deballage automatique de l'enveloppe backend `{ success, data, error, meta }`
- redirection vers `/login` en cas de `401`
- logs API centralises

Equivalent mobile attendu:

- un `Dio` central dans `core/network`
- gestion des cookies/session Better Auth a clarifier pour Flutter
- header `X-Correlation-Id`
- parsing coherent de l'enveloppe API
- erreurs mappees vers des failures/domain errors, pas traitees dans les widgets

## Better Auth cote web

Le client Better Auth est dans `src/lib/auth-client.ts`.

Point cle:

```text
NEXT_PUBLIC_API_URL = http://localhost:3000/api
Better Auth baseURL = http://localhost:3000
```

Better Auth gere ses endpoints sous `/api/auth/*`.

Plugins utilises:

- organization
- twoFactor

Equivalent mobile attendu:

- ne pas creer d'auth parallele JWT-only
- verifier si le backend Better Auth accepte proprement les clients mobiles avec cookies
- si besoin, definir cote backend un flux mobile officiel au lieu d'improviser dans Flutter

## Store auth et roles web

`src/store/auth.store.ts` contient un store Zustand persiste.

Roles web connus:

```text
employee
manager
supervisor
hr
admin
```

Le store conserve:

- user
- accessToken
- sessionScope
- isAuthenticated

Attention:

- Le backend repose surtout sur Better Auth/session cookies.
- `accessToken` existe dans le store web, mais le modele de reference reste Better Auth.
- Le mobile doit eviter de deduire un modele token si le backend ne le formalise pas.

## Navigation et protection web

Navigation principale: `src/config/navigation.ts`.

Routes par role:

- employee: dashboard, planning, attendance, leaves
- manager/supervisor: employee + team + validation
- hr/admin: employee management, admin dashboard, settings selon role

Protection:

- `src/proxy.ts` valide les cookies et appelle `/api/auth/get-session`
- `RoleGuard` protege les layouts dashboard cote client
- `RoleRedirectMap` redirige selon role

Regles importantes:

- utilisateur non authentifie sur une route protegee -> `/terminal`
- scope `TIMECLOCK` interdit admin/manager
- scope `BACKOFFICE` applique les redirections par role

Equivalent mobile attendu:

- `go_router` doit avoir une redirection centralisee par session, role et scope
- la logique de redirection ne doit pas etre dispersee dans les widgets
- les roles/scopes doivent venir de la session backend, pas d'un etat local invente

## Module terminal web

Page principale:

```text
src/app/terminal/page.tsx
```

Service:

```text
src/services/api/timeclock.service.ts
```

Flux implemente:

1. Idle
2. PIN ou QR
3. Face scan
4. Selection du type de pointage
5. Enregistrement du pointage

Endpoints consommes:

```text
POST /api/timeclock/pin
POST /api/timeclock/qr
POST /api/timeclock/nfc
POST /api/timeclock/face-verify
POST /api/timeclock/clock
GET  /api/timeclock/status/:employeeId
```

Headers obligatoires:

```text
x-terminal-device-id
x-terminal-api-key
```

Le web lit ces valeurs via:

```text
NEXT_PUBLIC_TERMINAL_DEVICE_ID
NEXT_PUBLIC_TERMINAL_API_KEY
```

Attention mobile:

- stocker une API key terminal en clair dans l'app mobile est risqué
- prevoir un vrai flux de provisioning terminal: QR d'enrolement, validation admin, ou configuration MDM
- les credentials terminal doivent etre stockes via `flutter_secure_storage`
- le terminal mobile doit rester compatible avec le flux challengeToken du backend

## Services metier web reperes

### Auth

`auth.service.ts` utilise:

```text
POST auth/sign-in/email
POST auth/sign-up/email
GET  employees/me
```

Note: le service contient aussi des anciens endpoints `terminal/pin-login`, `terminal/nfc-login`, `terminal/faceid-login` qui ne correspondent pas au controleur timeclock actuel. Pour le mobile, utiliser le module `/timeclock/*` documente dans le backend.

### Employee

`employee.service.ts`:

```text
GET employees/me
```

### Attendance

`attendance.service.ts`:

```text
POST attendance/clock-in
POST attendance/clock-out
POST attendance/break/start
POST attendance/break/end
GET  attendance/today
GET  attendance/my-history
GET  attendance/stats/monthly
GET  attendance/team
GET  attendance/admin/all
```

### Leaves

`leave.service.ts`:

```text
POST   leaves
GET    leaves/me
GET    leaves/balances
GET    leaves/team
GET    leaves
GET    leaves/calendar
POST   leaves/:id/approve
POST   leaves/:id/reject
DELETE leaves/:id
```

## Ce que le mobile doit reprendre

- Structure par modules: auth, timeclock, employee, manager, hr_admin
- Navigation par role/scope
- Separation client API general vs client terminal
- Correlation ID
- Gestion d'enveloppe API standardisee
- Flux terminal en 3 etapes
- Roles: employee, manager, supervisor, hr, admin
- Scopes: BACKOFFICE, TIMECLOCK

## Ce que le mobile doit adapter

- Remplacer Zustand par Riverpod
- Remplacer Axios par Dio
- Remplacer middleware Next par redirection `go_router`
- Remplacer camera web par plugin Flutter `camera`
- Remplacer QR browser API par `mobile_scanner`
- Remplacer localStorage/cookies web par une strategie session mobile claire
- Ne pas exposer de credentials terminal via variables publiques compilees

## Risques et questions ouvertes

1. Session Better Auth mobile: cookies natifs, cookie jar Dio, ou endpoint mobile dedie ?
2. Provisioning terminal: comment associer une installation mobile a un terminal/device backend ?
3. Offline: faut-il mettre en file d'attente les pointages si reseau absent ?
4. Face AI: le backend a un port/stub, mais l'integration IA finale reste a definir.
5. Certaines routes anciennes dans le web ne doivent pas etre reprises sans validation.
