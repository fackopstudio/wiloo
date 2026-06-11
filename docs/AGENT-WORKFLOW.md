# Agent Workflow

## Repository Awareness

This repository is currently the backend/web platform repository. Treat Flutter mobile work as a separate repository unless explicitly told otherwise.

## Before Coding

1. Read the relevant app/package manifest.
2. Read existing services/controllers/components before creating new patterns.
3. Check contracts and DTOs before inventing request/response shapes.
4. Keep business rules aligned with backend implementation.

## Backend/Web Verification

Use focused checks first:

```bash
cd nexorarh/apps/backend
yarn test
yarn build
```

```bash
cd nexorarh/apps/frontend
yarn lint
yarn build
```

## Mobile Verification

In the future Flutter repository:

```bash
flutter analyze
flutter test
flutter run
```

## Cursor Usage

Use `.cursor/rules` as durable project memory.

Do not use Cursor prompts that ask for large rewrites unless the user explicitly wants a rewrite.
Prefer small, verified steps:
- inspect
- implement
- test
- document
