# Compliance Social & Tax - UI Reference

## Purpose

UI reference for the Wiloo Compliance Social & Tax module (Gabon-focused HR platform).
This document guides UI design only. It does not change architecture, data, or business rules.

Hard product facts that shape every screen:

- Declarations are **preparatory only**. Wiloo never performs official/automated submission.
- Active declaration types: **CNSS, CNAMGS, IRPP**. **IS is disabled / not available**.
- `admin` and `hr` can act. `manager` is **read-only**. `employee/supervisor/time_terminal` have no access.
- Backend is the source of truth. The UI only displays backend-provided totals and statuses.
- No tax/social amount is ever computed in Flutter.

## Mobbin research note (tool status)

Research was attempted through the Mobbin MCP. At the time of writing, only app lookup
(`mobbin_quick_search`) was operational; the screen, flow, and pattern endpoints
(`get_app_screens`, `get_app_flows`, `search_flows`, `popular_apps`) returned 404 / SSR
errors, so per-screen images and Mobbin pattern metadata could not be extracted. Per MCP
rules, no browser scraping fallback was used.

Confirmed-relevant reference apps on Mobbin (look these up directly for live screens):

- **Gusto** (web) - HR/payroll dashboards, run-payroll flows, tax documents.
- **Deel** (web) - global payroll & compliance, document status, approvals.
- **QuickBooks** (web) - finance dashboards, tax/document status, export/download.
- **Employment Hero** (web) - all-in-one HR/payroll dashboards.
- **Remote** (web) - HR & contractor management, compliance documents.

The patterns below are proven, widely-used patterns in this product class (HR/payroll/finance
SaaS), corroborated by the apps above. Where a pattern maps to a known reference, it is noted.

---

## 1. Patterns found

| # | Pattern | Seen in (class) |
| --- | --- | --- |
| P1 | KPI/summary cards row at top of dashboard (counts by status, next due) | Gusto, QuickBooks, Employment Hero |
| P2 | Period selector (month/quarter/year) as primary scoping control | Gusto run-payroll, QuickBooks tax center |
| P3 | Status-driven data table/list with colored status chips | Deel, QuickBooks, Gusto |
| P4 | Filter + search toolbar above the list (type, status, period) | Deel, QuickBooks |
| P5 | Detail "record" screen: header summary + tabbed/sectioned body (totals, lines, exports, history) | Deel, QuickBooks invoices |
| P6 | Stepper / guided create flow with explicit confirm step | Gusto run-payroll, QuickBooks |
| P7 | Document status timeline (Draft -> Ready -> Validated -> Exported -> Submitted) | Deel, QuickBooks |
| P8 | Export dialog/sheet with format choice (PDF/Excel/CSV) then generated-file row | QuickBooks, Gusto reports |
| P9 | Action bar / overflow menu gated by permissions; disabled with reason | Deel, Gusto |
| P10 | Archive as a filtered view of the same list, not a separate dataset | QuickBooks, Deel |
| P11 | Empty-state with single primary call to action | Gusto, Employment Hero |
| P12 | Read-only "viewer" mode that hides/greys destructive actions | Deel (role-based seats) |
| P13 | Warning/anomaly banners surfaced on records before action | QuickBooks tax review |
| P14 | Responsive table -> card list collapse on small screens | Most finance web apps' responsive views |

## 2. Why each pattern is relevant to Wiloo

- **P1 KPI cards**: compliance work is deadline-driven; admins need "what is due / what is blocked" at a glance. Counts come from backend lists, not computed.
- **P2 Period selector**: declarations are organized by `DeclarationPeriod` (MONTHLY/QUARTERLY/YEARLY). Scoping by period matches the domain model.
- **P3 Status chips**: the 6 backend statuses (`DRAFT, READY_TO_REVIEW, VALIDATED, EXPORTED, SUBMITTED_MANUALLY, ARCHIVED`) map naturally to colored chips for fast scanning.
- **P4 Filter toolbar**: backend list filters (`declarationPeriodId, type, status`) should be exposed exactly, no invented filters.
- **P5 Detail record**: a declaration aggregates totals, lines, exports, attachments - a sectioned record screen is the standard, reviewable layout.
- **P6 Guided generate**: generation is a deliberate, role-gated action; a confirm step reduces accidental triggers and sets expectations (preparatory, synchronous).
- **P7 Status timeline**: the confirmed transition table is a state machine; a timeline communicates where a declaration is and what is next.
- **P8 Export dialog**: export creates a `DeclarationExport` then a separate binary download; a two-stage UI (request format -> download generated file) mirrors backend behavior (no signed URL).
- **P9 Permission-gated actions**: RBAC differs by role; disabling with a reason is clearer than hiding everything.
- **P10 Archive as filter**: backend exposes archive via `status=ARCHIVED` on the same list; reuse the list UI.
- **P11 Empty state CTA**: new tenants/periods start empty; a single CTA (e.g. "Create a period") guides first use.
- **P12 Read-only mode**: managers must see data without any action affordance.
- **P13 Anomaly banners**: backend returns `warnings[]`; surfacing them prevents validating/exporting bad data.
- **P14 Responsive collapse**: Wiloo targets mobile/tablet/desktop; tables must degrade to cards.

---

## 3. Layout recommendations per screen

### ComplianceDashboardPage (`/compliance`)

- Composed view (no dashboard endpoint): aggregates `GET /periods` + `GET /declarations` for display counts only.
- Top: page title + current period context.
- KPI cards row (P1): e.g. "Draft", "Ready to review", "Validated", "Exported", "Submitted (manual)", plus "Next due period".
- Secondary: "Recent declarations" short list (P3) with status chips, tap to detail.
- Primary actions (admin/hr only): "Create period", "Generate declaration". Hidden for manager.
- Quick links to Periods, Declarations, Archive.

### DeclarationPeriodsPage (`/compliance/periods`)

- List/table of periods (P3): period label, type (MONTHLY/QUARTERLY/YEARLY), date range, status.
- Filter toolbar (P4): periodType, status, year.
- Primary action "Create period" (admin/hr); absent for manager.
- Row tap -> declarations filtered by that `declarationPeriodId`.

### DeclarationListPage (`/compliance/declarations`)

- Filter toolbar (P4): period, type (CNSS/CNAMGS/IRPP; IS shown disabled), status.
- Table/cards (P3): type chip, period, status chip, key total (display-only), updatedAt.
- Row tap -> detail. "Generate" entry point (admin/hr).
- Manager: list is fully readable, no row actions.

### DeclarationDetailPage (`/compliance/declarations/:id`)

- Header summary: type, period, status chip, last updated.
- Status timeline (P7) reflecting confirmed transitions.
- Sections (P5):
  - Totals (display-only `MoneyAmount`): gross salary, taxable base, employee/employer contributions, withholdings.
  - Anomalies/warnings banner (P13) if `warnings[]` present.
  - Lines (read-only list; fields finalize once backend confirms `DeclarationLine`).
  - Exports list with per-export download (admin/hr).
  - Attachments (read-only).
- Action bar (P9), gated and transition-aware: Mark ready, Validate, Export, Mark submitted (manual), Archive. Disabled with tooltip when the transition is not allowed.
- Manager: sections visible, action bar hidden.

### DeclarationGeneratePage (`/compliance/declarations/generate`)

- Guided form/stepper (P6): 1) choose period, 2) choose type (CNSS/CNAMGS/IRPP; IS disabled), 3) optional ruleSet, 4) confirm.
- Explicit "preparatory" notice near the confirm action.
- Synchronous result -> navigate to the created declaration's detail.
- admin/hr only (route guard already blocks others).

### DeclarationExportPage (`/compliance/declarations/:id/export`)

- Two-stage (P8): pick format (PDF/EXCEL/CSV) and optional template version -> request export -> show generated `DeclarationExport` row -> download (binary).
- Show existing exports for the declaration.
- Make clear that export is a preparatory document, not a submission.
- admin/hr only.

### DeclarationArchivePage (`/compliance/archive`)

- Reuse DeclarationList UI (P10) pinned to `status=ARCHIVED`.
- Read-first; archived records are historical. No re-activation unless backend confirms it.
- Manager can view (per access rules, archive is a write area: keep manager out per current route guard; see risks).

---

## 4. Component recommendations (Material 3 / Flutter)

- App shell: `NavigationRail` (tablet/desktop) / `NavigationBar` or `Drawer` (mobile).
- KPI cards: `Card` (filled/outlined) with `Text` numerals; consistent radius and spacing.
- Lists/tables:
  - Desktop/tablet: `DataTable` / `DataTable2`-style with sticky header.
  - Mobile: `ListView` of `Card`/`ListTile` (P14 collapse).
- Status: Material 3 `Chip` (assist/suggestion) with a documented color token per status.
- Filters: `SegmentedButton` (type/status), `DropdownMenu`, `SearchBar`.
- Generate flow: `Stepper` or a `Form` with `FilledButton` confirm; `DropdownMenu` for period/type.
- Export: `Dialog` or `ModalBottomSheet` for format; `SnackBar` for download result; `ListTile` rows for generated files.
- Detail: `Card` sections, `ExpansionPanel`/`ExpansionTile` for lines, a simple vertical timeline widget for status.
- Action affordances: `FilledButton`/`OutlinedButton`/`MenuAnchor` overflow; disabled state with `Tooltip` reason.
- Banners: Material 3 `Banner`/`MaterialBanner` for warnings; `Badge` for unavailable (IS) and counts.
- Feedback: `CircularProgressIndicator`/skeletons (loading), `SnackBar` (transient), inline error cards (recoverable).

## 5. Empty / loading / error states

- Loading:
  - Lists/dashboard: skeleton rows/cards (avoid full-screen spinners on desktop).
  - Detail: section-level shimmer; keep header stable.
  - Actions (generate/export/download): button-local progress + disable; do not block the whole screen.
- Empty:
  - No periods: illustration + one CTA "Create a period" (admin/hr); for manager, neutral "No periods yet".
  - No declarations: "No declarations for this period" + "Generate" (admin/hr).
  - No exports on a declaration: "No export generated yet".
  - Archive empty: "No archived declarations".
- Error (map to `Failure` types):
  - `forbidden` (403): "You do not have permission" - do not expose action controls.
  - `invalidStateTransition` (400): inline message "This action is not available for the current status"; refresh the record.
  - `network`: retry affordance.
  - `server`: generic "Something went wrong, try again", with correlation context for support.
  - Download failure: keep the export row, allow retry; never imply the declaration changed.

## 6. Mobile / tablet / desktop behavior

- Mobile (<600dp):
  - Single column; tables become card lists.
  - Filters in a bottom sheet; primary action as `FilledButton` or FAB (admin/hr).
  - Detail sections stacked; action bar as bottom bar or overflow menu.
- Tablet (600-1240dp):
  - `NavigationRail`; two-pane optional (list + detail) in landscape.
  - Tables fit with key columns; secondary columns hidden behind a toggle.
- Desktop (>1240dp):
  - Persistent rail/sidebar; full `DataTable` with sticky header and pagination if backend confirms paging.
  - Detail as a wide record with side column for status timeline + exports.
- Kiosk/timeclock surfaces are unrelated; Compliance is a backoffice (BACKOFFICE) experience.

## 7. Wording guidelines

Use clear French (Gabon HR context). Key rules:

- Never use submission/teletransmission wording that implies official filing.
  - Prefer: "Preparer", "Generer (preparatoire)", "Exporter", "Marquer comme transmis manuellement".
  - Avoid: "Teletransmettre", "Soumettre a la CNSS/DGI", "Declaration officielle envoyee".
- Label types explicitly: CNSS, CNAMGS, IRPP. Show IS as "IS - bientot disponible" / disabled, never actionable.
- Status labels (suggested FR):
  - DRAFT -> "Brouillon"
  - READY_TO_REVIEW -> "A verifier"
  - VALIDATED -> "Validee"
  - EXPORTED -> "Exportee"
  - SUBMITTED_MANUALLY -> "Transmise manuellement"
  - ARCHIVED -> "Archivee"
- Export wording: "Document preparatoire" / "Export genere". Make explicit it is not proof of filing.
- Manager: any actionable verb must be absent; use neutral, descriptive labels.
- Amounts: present as provided by backend with currency; never label them as "calcule par Wiloo".
- Confirmations: state the consequence plainly ("Generer une declaration preparatoire CNSS pour juin 2026 ?").

## 8. Risks to avoid

- Implying official submission. The module is preparatory; wording and icons must not suggest filing to CNSS/CNAMGS/DGI.
- Showing IS as ready. Keep it disabled with a clear "not available" treatment.
- Computing or "helpfully" recomputing totals/taxes client-side. Display backend values verbatim.
- Letting manager see action affordances. Read-only must hide, not just disable-without-context, destructive/active controls.
- Treating archive as a different dataset. It is the declarations list filtered by `ARCHIVED`.
- Manager + archive mismatch: access rules list manager read access for dashboard/periods/declarations/detail only; the current route guard blocks manager on `/compliance/archive`. Align UI nav (do not show an archive entry to manager) or revisit the access rule before exposing it. Backend remains authoritative.
- Treating the binary download as JSON. Download bypasses the envelope; surface file errors without mutating record state.
- Inventing filters, statuses, or columns not in the backend contract.
- Blocking the whole screen on a single action's spinner; keep actions local.
- Over-dense mobile tables; collapse to cards.
- Hardcoding CNSS/CNAMGS/IRPP rates anywhere in the UI layer.

---

## Suggested next step

Re-run the Mobbin MCP screen/flow tools once the backend endpoints are healthy to attach concrete
screenshots (Gusto run-payroll, Deel compliance documents, QuickBooks tax center) to patterns
P1-P14, then validate the per-screen layouts above against those references.
