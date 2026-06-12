---
name: wiloo-design-review
description: Use before committing Wiloo UI work or when asked to review UI, especially Flutter screens, responsive layouts, role-based visibility, accessibility, Compliance wording, and test coverage.
---

# Wiloo Design Review

## Trigger Conditions

Use this skill before committing UI work, or when reviewing Flutter UI for Wiloo.

## Review Checklist

Check the implemented UI for:

- responsive behavior on mobile, tablet and desktop
- clear visual hierarchy for operational HR/SaaS workflows
- consistent Material 3 usage and existing theme/design tokens
- role-based visibility and access messaging
- accessibility: contrast, labels, tap targets, keyboard/screen-reader friendliness
- no invented backend fields
- no direct API calls inside widgets
- no business logic in UI
- no fiscal/social calculation in Flutter
- no hardcoded tax/social rates
- no official automated submission wording
- loading, empty and error states
- tests updated for important states and role behavior

## Compliance-Specific Review

For Compliance UI, also verify:

- wording uses `preparatory declarations`
- `IS` is disabled/not available yet
- manager remains read-only
- employee, supervisor and time_terminal have no access
- export/download uses the existing repository/controller path
- `MoneyAmount` remains display-only
- Flutter never sends tenantId to override backend scope

## Validation

Before final handoff, run:

```bash
flutter analyze
flutter test
```

Report any known limitations or intentionally deferred backend-contract gaps.
