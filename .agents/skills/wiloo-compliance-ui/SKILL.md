---
name: wiloo-compliance-ui
description: Use when implementing or reviewing Wiloo Social & Tax Compliance UI, including declaration periods, preparatory declarations, CNSS/CNAMGS/IRPP screens, exports, archive/validation actions, and role-based visibility.
---

# Wiloo Compliance UI

## Trigger Conditions

Use this skill for any Flutter UI work under the Compliance feature:

- declaration periods
- social/fiscal declarations
- CNSS, CNAMGS, IRPP workflows
- export/download screens or actions
- validation, archive, mark-ready or manual-submission UX
- role-based Compliance navigation or visibility

## Product Language

- Use the wording `preparatory declarations`.
- Never imply official automated submission.
- Manual submission can be displayed only as a recorded status/supporting document workflow.
- `CNSS`, `CNAMGS` and `IRPP` are active.
- `IS` is disabled/not available yet in the Flutter UI.

## Backend Contract Rules

- The backend is the source of truth.
- Flutter must not calculate tax or social contribution amounts.
- Flutter must not hardcode CNSS, CNAMGS or IRPP rates.
- `MoneyAmount` is display-only.
- Never send `tenantId` from Flutter to choose or override tenant scope.
- Do not invent statuses, declaration types or transitions.
- Use the existing Compliance repository/controller APIs.
- Binary export/download must use the existing repository/controller only.

## Access Rules

Mirror backend RBAC for UX only:

- `admin`: full access
- `hr`: full access
- `manager`: read-only
- `employee`: no access
- `supervisor`: no access
- `time_terminal`: no access

The backend still enforces authorization on every request. UI checks are for navigation, visibility and clearer user experience only.

## UI Behavior

- Show backend warnings/anomalies prominently but calmly.
- Distinguish `DRAFT`, `READY_TO_REVIEW`, `VALIDATED`, `EXPORTED`, `SUBMITTED_MANUALLY` and `ARCHIVED`.
- Disable or hide write actions when the role or status does not allow them.
- Do not expose `IS` as production-ready.
- Do not label exports as official filings.
- Treat export download as binary data, not a JSON response.

## Tests

Add or update tests for:

- role-based visibility
- status-based action availability
- empty/loading/error states
- export download entry points
- no local calculation assumptions

Run `flutter analyze` and `flutter test` before handoff.
