---
name: wiloo-flutter-ui
description: Use when implementing or reviewing Flutter UI in Wiloo, including pages, widgets, responsive layouts, Material 3 styling, Riverpod-backed UI states, accessibility, or widget tests.
---

# Wiloo Flutter UI

## Trigger Conditions

Use this skill whenever the task touches Flutter UI in Wiloo:

- pages, widgets, layout, navigation surfaces, dialogs, forms, lists, dashboards
- responsive mobile/tablet/desktop behavior
- Material 3 visual treatment
- loading, empty, error, success or forbidden states
- widget tests for visible UI behavior

## Core Rules

- Use Material 3 and the existing Wiloo app theme/design tokens.
- Keep the visual style clean, restrained and HR/SaaS oriented.
- Design for mobile first, then tablet and desktop.
- Use responsive constraints, not viewport-scaled fonts.
- Do not make direct API calls inside widgets.
- Do not put business logic or calculations inside widgets.
- Use existing Riverpod providers and feature repositories.
- Keep backend behavior as the source of truth.
- Keep widgets accessible: readable contrast, semantic labels where needed, sane tap targets and keyboard/screen-reader friendly structure.

## UI States

Every important UI surface should account for:

- loading
- empty
- data-ready
- error
- unauthorized or forbidden when applicable

Prefer state-specific widgets or small helpers over large conditional blocks in build methods.

## Implementation Guidance

- Reuse `WilooScaffold`, existing app routes, existing theme values and shared widgets before adding new UI primitives.
- Keep widgets focused on rendering and user intent dispatch.
- Put orchestration in providers/controllers, not widgets.
- Avoid decorative card-heavy layouts for operational HR screens.
- Use concise labels and actionable empty/error copy.
- Keep repeated items scannable and dense enough for backoffice workflows.

## Tests

Add or update widget tests for important visible behavior:

- role-dependent visibility
- loading/empty/error states
- route-level access outcomes
- key commands such as validate/export/archive when UI exposes them

Run `flutter analyze` and `flutter test` before handing off.
