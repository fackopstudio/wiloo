# Backend API Reference - Wiloo

## But du document

Ce document sert de repere backend pour brancher l'application Flutter `wiloo` sur l'API NestJS existante.

Source auditee:

```text
/Users/moussavoulionelstephen/Wiloo-app-mobile/apps/backend
```

## Stack backend existante

- NestJS 11
- TypeORM
- PostgreSQL
- Better Auth
- Better Auth TypeORM adapter
- Swagger/OpenAPI via `@nestjs/swagger`
- cookie-parser
- compression
- nestjs-pino / Pino
- Socket.IO gateway pour notifications
- Jest pour tests unitaires/integration/e2e

## Configuration globale

Fichier principal:

```text
src/main.ts
```

Comportements globaux:

- prefix API global: `/api`
- Swagger: `/api-docs`
- CORS avec credentials active
- origines autorisees: `FRONTEND_URL`, `localhost:3001`, `localhost:3002`, `localhost:3006`
- cookie parser actif
- validation globale stricte:
  - whitelist
  - forbidNonWhitelisted
  - transform
- filtre d'erreurs global
- interceptors globaux:
  - logging
  - transform response
- correlation id via middleware et header `X-Correlation-Id`

Implication mobile:

- Ajouter les origines web ne suffit pas pour mobile natif; les appels natifs ne sont pas soumis au meme CORS, mais le backend doit accepter les cookies/session selon le transport choisi.
- Le mobile doit envoyer `X-Correlation-Id` pour debug end-to-end.
- Le mobile doit parser l'enveloppe de reponse standardisee.

## Auth Better Auth

Better Auth est monte via:

```text
@Controller('auth')
@All('*')
```

Donc endpoints sous:

```text
/api/auth/*
```

Config:

```text
src/auth/auth.config.ts
```

Plugins:

- organization
- twoFactor

Champs user additionnels:

- role
- tenantId
- authMethod
- hardwareSecret
- managerId

Champs session additionnels:

- scope, defaut `BACKOFFICE`
- tenantId
- deviceId
- isTerminalSession

Roles backend:

```text
admin
hr
manager
supervisor
employee
time_terminal
```

Regle mobile:

- Ne pas creer de systeme JWT parallele.
- Lire la session via Better Auth ou via un flux mobile officiellement expose par le backend.
- La session doit fournir role, scope et tenant/org context.

## Multi-tenancy

Le backend utilise:

- `tenantId` cote user/session
- organizations Better Auth
- `TenantInterceptor`
- `@TenantId()` decorator

Le mobile doit considerer `tenantId` comme donnees backend, pas comme simple preference locale.

## Modules backend principaux

Modules charges dans `AppModule`:

- Auth
- Users
- Employees
- Attendance
- LeaveRequests
- Dashboard
- Payroll
- Notifications
- Companies
- AuditLogs
- Migration
- Webhooks
- Timeclock
- Planning
- Compliance

## Routes principales utiles au mobile

Toutes les routes ci-dessous sont prefixees par `/api`.

### Auth

```text
/api/auth/*
```

Better Auth gere notamment sign-in, sign-up, get-session selon ses conventions.

Routes vues cote web:

```text
POST /api/auth/sign-in/email
POST /api/auth/sign-up/email
GET  /api/auth/get-session
```

### Employees

Controleur: `employees`

```text
POST   /api/employees
POST   /api/employees/admin-create
GET    /api/employees
GET    /api/employees/me
GET    /api/employees/my-team
GET    /api/employees/:id
POST   /api/employees/:id/regenerate-pin
PATCH  /api/employees/:id
DELETE /api/employees/:id
```

Protections:

- BetterAuthGuard
- RolesGuard
- TenantInterceptor

Roles notables:

- creation: admin, hr
- liste: admin, hr, manager, supervisor
- team: manager, admin, hr

### Attendance

Controleur: `attendance`

```text
POST /api/attendance/clock-in
POST /api/attendance/clock-out
POST /api/attendance/break/start
POST /api/attendance/break/end
GET  /api/attendance/today
GET  /api/attendance/my-history
GET  /api/attendance/stats/monthly
GET  /api/attendance/admin/all
GET  /api/attendance/team/today
GET  /api/attendance/team/stats
GET  /api/attendance/team
```

Protection:

- BetterAuthGuard global
- RolesGuard sur routes manager/admin

Usage mobile:

- Espace employe: today, my-history, stats monthly, clock-in/out si le produit garde un mode pointage personnel hors terminal.
- Espace manager/admin: team, admin/all, stats.

### Leaves

Controleur: `leaves`

```text
POST   /api/leaves
GET    /api/leaves/balances
GET    /api/leaves/me
GET    /api/leaves/calendar
GET    /api/leaves/team
GET    /api/leaves
GET    /api/leaves/:id
DELETE /api/leaves/:id
POST   /api/leaves/:id/approve
POST   /api/leaves/:id/reject
PATCH  /api/leaves/:id
```

Protection:

- BetterAuthGuard
- RolesGuard

Roles notables:

- team/all/approve/reject: manager, admin, hr selon endpoint

### Timeclock terminal

Controleur: `timeclock`

Headers obligatoires:

```text
x-terminal-device-id
x-terminal-api-key
```

Routes:

```text
POST /api/timeclock/pin
POST /api/timeclock/nfc
POST /api/timeclock/qr
POST /api/timeclock/face-verify
POST /api/timeclock/clock
GET  /api/timeclock/status/:employeeId
```

Protection:

- TerminalAuthGuard
- TenantInterceptor
- TimeclockExceptionFilter

Flux backend:

1. `POST /pin`, `/nfc` ou `/qr`
   - identifie l'employe
   - retourne un `challengeToken`
2. `POST /face-verify`
   - recoit `challengeToken` + `faceData`
   - verifie le visage via le port FaceRecognitionService
3. `POST /clock`
   - recoit `challengeToken` + type de pointage
   - enregistre l'evenement

Types de pointage:

```text
ARRIVAL
BREAK_START
BREAK_END
DEPARTURE
```

### Timeclock admin

Controleur: `timeclock/admin`

```text
POST  /api/timeclock/admin/identities
PUT   /api/timeclock/admin/identities/:employeeId
PATCH /api/timeclock/admin/identities/:employeeId/status
GET   /api/timeclock/admin/identities
GET   /api/timeclock/admin/status/:employeeId
GET   /api/timeclock/admin/entries
```

Protection:

- BetterAuthGuard
- RolesGuard
- TenantInterceptor
- roles admin/hr par defaut
- `entries` autorise admin/manager

### Dashboard

Controleur: `dashboard`

```text
GET /api/dashboard/stats
GET /api/dashboard/admin-stats
GET /api/dashboard/activity
```

### Payroll

Controleur: `payroll`

```text
POST /api/payroll/generate
POST /api/payroll/validate-month
POST /api/payroll/:id/validate
POST /api/payroll/:id/pay
GET  /api/payroll/stats
GET  /api/payroll/me
GET  /api/payroll
GET  /api/payroll/:id
GET  /api/payroll/:id/details
```

Note: deux fichiers controleurs payroll existent (`src/payroll/payroll.controller.ts` et `src/payroll/presentation/payroll.controller.ts`). A verifier avant extension pour eviter doublons.

### Compliance social & fiscal

Source de verite backend:

```text
/Users/moussavoulionelstephen/Wiloo-app-mobile/docs/COMPLIANCE-API-CONTRACT.md
/Users/moussavoulionelstephen/Wiloo-app-mobile/apps/backend/src/compliance
```

Base controller:

```text
/api/compliance
```

Protection globale:

- `BetterAuthGuard`
- `RolesGuard`
- `TenantInterceptor`
- tenant obligatoire via session Better Auth ou `user.tenantId`
- pas de scope string dedie Compliance aujourd'hui; le scope effectif est role + tenant

Roles:

```text
admin   read/write
hr      read/write
manager read-only sur les routes explicitement ouvertes
employee forbidden
```

Routes implementees:

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

Acces par route:

| Route | Roles |
| --- | --- |
| `GET /periods` | admin, hr, manager |
| `POST /periods` | admin, hr |
| `GET /declarations` | admin, hr, manager |
| `POST /declarations/generate` | admin, hr |
| `GET /declarations/:id` | admin, hr, manager |
| `POST /declarations/:id/mark-ready` | admin, hr |
| `POST /declarations/:id/validate` | admin, hr |
| `POST /declarations/:id/export` | admin, hr |
| `GET /declarations/:id/exports/:exportId/download` | admin, hr |
| `POST /declarations/:id/mark-submitted` | admin, hr |
| `POST /declarations/:id/archive` | admin, hr |

Types de declaration:

```text
CNSS
CNAMGS
IRPP
IS
```

Etat reel:

- `CNSS`: generation preparatoire implementee, export implemente.
- `CNAMGS`: generation preparatoire implementee, export implemente.
- `IRPP`: generation preparatoire implementee, export implemente; pas de calcul fiscal final sans `ComplianceRuleSet` valide.
- `IS`: enum et generation generique disponibles, mais pas de calcul ni export specifique; hors MVP RH strict.

Statuts:

```text
DRAFT
READY_TO_REVIEW
VALIDATED
EXPORTED
SUBMITTED_MANUALLY
ARCHIVED
```

Transitions valides:

| Action | Depuis | Vers |
| --- | --- | --- |
| generation CNSS ou IS generique | none | `DRAFT` |
| generation CNAMGS/IRPP incomplete | none | `DRAFT` |
| generation CNAMGS/IRPP complete | none | `READY_TO_REVIEW` |
| `mark-ready` | `DRAFT` | `READY_TO_REVIEW` |
| `validate` | `READY_TO_REVIEW` | `VALIDATED` |
| `export` | `VALIDATED` | `EXPORTED` |
| `export` | `READY_TO_REVIEW` | reste `READY_TO_REVIEW` |
| `export` | `EXPORTED` | reste `EXPORTED` |
| `mark-submitted` | `VALIDATED`, `EXPORTED` | `SUBMITTED_MANUALLY` |
| `archive` | `DRAFT`, `READY_TO_REVIEW`, `VALIDATED`, `EXPORTED`, `SUBMITTED_MANUALLY` | `ARCHIVED` |

Toute transition non listee retourne `400`.

DTOs principaux:

```ts
type CreateDeclarationPeriodDto = {
  companyId?: string;
  periodType: "MONTHLY" | "QUARTERLY" | "YEARLY";
  year: number;
  month?: number;
  quarter?: number;
  startDate: string;
  endDate: string;
  payrollMonth?: number;
  payrollYear?: number;
  metadata?: Record<string, unknown>;
};

type GenerateDeclarationDto = {
  declarationPeriodId: string;
  type: "CNSS" | "CNAMGS" | "IRPP" | "IS";
  ruleSetId?: string;
  metadata?: Record<string, unknown>;
};

type ExportDeclarationDto = {
  format: "PDF" | "EXCEL" | "CSV";
  templateVersion?: string;
};

type MarkSubmittedDeclarationDto = {
  submittedAt?: string;
  notes?: string;
  supportingDocument?: {
    fileName: string;
    storageKey: string;
    checksum?: string;
    description?: string;
    type?: string;
  };
};

type ArchiveDeclarationDto = {
  reason?: string;
};
```

Filtres:

```ts
type ListDeclarationPeriodsQuery = {
  companyId?: string;
  periodType?: "MONTHLY" | "QUARTERLY" | "YEARLY";
  status?: DeclarationStatus;
  year?: number;
  month?: number;
  quarter?: number;
  payrollMonth?: number;
  payrollYear?: number;
};

type ListDeclarationsQuery = {
  declarationPeriodId?: string;
  companyId?: string;
  type?: "CNSS" | "CNAMGS" | "IRPP" | "IS";
  status?: DeclarationStatus;
};
```

Reponses principales:

```ts
type DeclarationPeriod = {
  id: string;
  tenantId: string;
  companyId: string | null;
  periodType: "MONTHLY" | "QUARTERLY" | "YEARLY";
  year: number;
  month: number | null;
  quarter: number | null;
  startDate: string;
  endDate: string;
  payrollMonth: number | null;
  payrollYear: number | null;
  status: DeclarationStatus;
  metadata: Record<string, unknown> | null;
  createdAt: string;
  updatedAt: string;
};

type SocialFiscalDeclaration = {
  id: string;
  tenantId: string;
  companyId: string | null;
  declarationPeriodId: string;
  type: "CNSS" | "CNAMGS" | "IRPP" | "IS";
  status: DeclarationStatus;
  ruleSetId: string | null;
  totalGrossSalary: number | string;
  totalTaxableBase: number | string;
  totalEmployeeContributions: number | string;
  totalEmployerContributions: number | string;
  totalWithholdings: number | string;
  warnings: string[] | null;
  metadata: Record<string, unknown> | null;
  validatedBy: string | null;
  validatedAt: string | null;
  exportedAt: string | null;
  submittedManuallyAt: string | null;
  period?: DeclarationPeriod;
  lines?: DeclarationLine[];
  exports?: DeclarationExport[];
  attachments?: DeclarationAttachment[];
  createdAt: string;
  updatedAt: string;
};
```

Note Flutter: les montants TypeORM/PostgreSQL peuvent arriver en `string`; parser prudemment en decimal cote mobile.

Generation:

- Synchrone.
- Cree la declaration et les lignes dans la meme requete applicative.
- Utilise employees actifs, payrolls `VALIDATED` ou `PAID`, company/organization snapshot et `ComplianceRuleSet` si disponible.
- Ne fait pas de teletransmission officielle.
- Ne doit pas etre reinterpretee comme calcul legal final cote mobile.

Export:

- Formats supportes: `PDF`, `EXCEL`, `CSV`.
- Synchrone.
- Cree un `DeclarationExport`.
- Stocke le fichier cote backend via `storageKey`.
- Ne retourne pas d'URL signee.
- Le `POST /api/compliance/declarations/:id/export` retourne une enveloppe
  dont `data` est un payload composite confirme en runtime:

```ts
type ExportDeclarationResponse = {
  declaration: SocialFiscalDeclaration;
  export: DeclarationExport;
  download: {
    exportId: string;
    fileName: string;
    mimeType: string;
  };
};
```

- L'identifiant a utiliser pour le telechargement est `data.export.id`;
  `data.download.exportId` expose le meme identifiant pour faciliter le flux
  client.
- Le telechargement se fait par stream binaire:

```text
GET /api/compliance/declarations/:id/exports/:exportId/download
```

Headers de reponse attendus:

```text
Content-Type: application/pdf | application/vnd.ms-excel | text/csv; charset=utf-8
Content-Disposition: attachment; filename="<fileName>"
X-Content-Type-Options: nosniff
```

Enveloppe de reponse:

- Les routes JSON retournent l'enveloppe globale `{ success, data, error, meta }`.
- Le download d'export doit etre traite comme binaire, pas comme JSON.
- Les erreurs retournent aussi l'enveloppe globale avec `success: false`.

Ce que Flutter peut faire:

- afficher les periodes, declarations, lignes, anomalies, exports et justificatifs selon le role
- permettre a `admin/hr` de creer une periode
- permettre a `admin/hr` de lancer une generation preparatoire
- permettre a `admin/hr` de marquer `READY_TO_REVIEW`
- permettre a `admin/hr` de valider une declaration
- permettre a `admin/hr` de demander un export
- permettre a `admin/hr` de telecharger l'export via endpoint protege
- permettre a `admin/hr` d'archiver
- afficher en lecture seule au manager les routes autorisees par le backend

Ce que Flutter ne doit jamais faire:

- calculer les montants fiscaux ou sociaux localement
- hardcoder des taux CNSS, CNAMGS ou IRPP
- inventer des statuts ou transitions
- bypasser RBAC backend
- envoyer un `tenantId` choisi localement pour contourner la session
- considerer un export comme une soumission officielle
- creer un JWT ou une auth parallele pour Compliance
- afficher `IS` comme module pret tant que le backend ne l'implemente pas completement

### Planning

Controleurs:

```text
shifts
reconciliation
```

Routes:

```text
POST   /api/shifts
POST   /api/shifts/site/:siteId/publish
GET    /api/shifts
GET    /api/shifts/site/:siteId
GET    /api/shifts/me
DELETE /api/shifts/:id
GET    /api/reconciliation/site/:siteId/daily
```

### Companies / Sites / Cellules

```text
/api/companies
/api/entity-sites
/api/cellules
```

Ces routes structurent l'organisation terrain: entreprise, sites, cellules.

## Reponses API

Le frontend web attend souvent l'enveloppe:

```json
{
  "success": true,
  "data": {},
  "error": null,
  "meta": {
    "timestamp": "...",
    "correlationId": "...",
    "path": "..."
  }
}
```

Mais certains endpoints, notamment Better Auth ou certains endpoints timeclock, peuvent retourner un format direct selon le filtre/interceptor utilise.

Regle mobile:

- Prevoir un decoder tolerant:
  - si enveloppe `{ success, data }`, extraire `data`
  - sinon accepter le body direct pour endpoints Better Auth/timeclock si confirme
- Normaliser ensuite dans les repositories Flutter.

## Strategie de connectivite mobile recommandeee

### Client backoffice

Pour auth, employee, attendance, leaves, payroll, planning, compliance:

- Dio general
- base URL via `API_BASE_URL`
- cookies/session Better Auth ou mecanisme mobile valide
- `X-Correlation-Id`
- repositories par feature

### Client terminal

Pour pointage kiosk/mobile:

- Dio dedie timeclock
- headers `x-terminal-device-id` et `x-terminal-api-key`
- credentials stockes dans `flutter_secure_storage`
- pas d'API key hardcodee dans l'application
- flux de provisioning a definir

### Environnements

Flutter doit utiliser:

```text
APP_ENV=dev|staging|prod
API_BASE_URL=https://...
```

## Points a clarifier avant implementation mobile avancee

1. Quelle strategie officielle pour Better Auth sur Flutter ?
2. Comment provisionner un terminal mobile sans exposer l'API key ?
3. Le mobile doit-il offrir un mode pointage personnel via `/attendance/*`, ou uniquement le terminal `/timeclock/*` ?
4. Faut-il supporter offline pour le terminal ?
5. L'app mobile doit-elle inclure admin complet en V1 ou commencer par terminal + employe + manager ?
6. L'integration Face AI finale remplacera le stub backend actuel: fournisseur, payload, seuils, stockage reference visage.

## Garde-fous pour le repo Flutter

- Ne pas coder de logique metier backend dans Flutter.
- Ne pas dupliquer les regles RBAC localement autrement que pour l'affichage/navigation.
- Ne pas inventer de DTO sans verifier Swagger/OpenAPI ou les controleurs.
- Ne pas reprendre les anciens endpoints web `terminal/*` sans confirmation; utiliser `/timeclock/*`.
- Documenter chaque ecart backend/web avant implementation.
