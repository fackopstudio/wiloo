import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../domain/entities/declaration_line.dart';
import '../../domain/entities/social_fiscal_declaration.dart';
import '../../domain/enums/declaration_status.dart';
import '../../domain/value_objects/compliance_access.dart';
import '../../domain/value_objects/compliance_requests.dart';
import '../../domain/value_objects/declaration_transition.dart';
import '../providers/compliance_providers.dart';
import '../widgets/compliance_widgets.dart';

class DeclarationDetailPage extends ConsumerWidget {
  const DeclarationDetailPage({required this.declarationId, super.key});

  final String declarationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final access = ref.watch(complianceAccessProvider);
    final declarationAsync = ref.watch(
      declarationDetailProvider(declarationId),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Détail déclaration')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (access.isReadOnly) const ComplianceReadOnlyBanner(),
          Expanded(
            child: declarationAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => ComplianceErrorState(
                message: 'Impossible de charger la déclaration.',
                onRetry: () =>
                    ref.invalidate(declarationDetailProvider(declarationId)),
              ),
              data: (declaration) =>
                  _DetailBody(declaration: declaration, access: access),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.declaration, required this.access});

  final SocialFiscalDeclaration declaration;
  final ComplianceAccess access;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Header chip row
        Row(
          children: [
            ComplianceTypeChip(declaration.type),
            const SizedBox(width: 8),
            ComplianceStatusChip(declaration.status),
          ],
        ),
        const SizedBox(height: 12),
        const CompliancePreparatoryNotice(),
        const SizedBox(height: 20),

        // Status timeline
        const ComplianceSectionTitle('Progression'),
        _StatusTimeline(status: declaration.status),
        const SizedBox(height: 8),

        // Warnings banner
        if (declaration.warnings?.isNotEmpty ?? false) ...[
          _WarningsBanner(warnings: declaration.warnings!),
          const SizedBox(height: 8),
        ],

        // Totals (display-only, from backend)
        const ComplianceSectionTitle('Montants préparatoires'),
        _TotalsCard(declaration: declaration),
        const SizedBox(height: 8),

        const ComplianceSectionTitle('Lignes de déclaration'),
        _DeclarationLinesSection(lines: declaration.lines),
        const SizedBox(height: 8),

        // Action bar (admin/hr only)
        if (!access.isReadOnly) ...[
          const ComplianceSectionTitle('Actions'),
          _ActionBar(declaration: declaration, access: access),
        ],

        const SizedBox(height: 24),
      ],
    );
  }
}

// ── Declaration Lines ────────────────────────────────────────────────────────

class _DeclarationLinesSection extends StatelessWidget {
  const _DeclarationLinesSection({required this.lines});

  final List<DeclarationLine>? lines;

  @override
  Widget build(BuildContext context) {
    final declarationLines = lines ?? const <DeclarationLine>[];
    if (declarationLines.isEmpty) {
      return const ComplianceEmptyState(
        message:
            'Aucune ligne de déclaration retournée par le backend pour cette déclaration préparatoire.',
      );
    }

    return Column(
      children: [
        for (final line in declarationLines)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: _DeclarationLineCard(line: line),
          ),
      ],
    );
  }
}

class _DeclarationLineCard extends StatelessWidget {
  const _DeclarationLineCard({required this.line});

  final DeclarationLine line;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final warnings = line.warnings ?? const <String>[];

    return Card(
      elevation: 0,
      color: cs.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.person_outline, color: cs.primary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _employeeLabel(line),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _employeeReference(line),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            _LineAmountsGrid(line: line),
            if (warnings.isNotEmpty) ...[
              const SizedBox(height: 12),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: cs.errorContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Anomalies ligne',
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: cs.onErrorContainer,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      for (final warning in warnings)
                        Text(
                          '• $warning',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: cs.onErrorContainer),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _LineAmountsGrid extends StatelessWidget {
  const _LineAmountsGrid({required this.line});

  final DeclarationLine line;

  @override
  Widget build(BuildContext context) {
    final rows = [
      ('Salaire brut', line.grossSalary?.displayValue),
      ('Base taxable', line.taxableSalary?.displayValue),
      ('Base cotisations', line.socialContributionBase?.displayValue),
      ('Cotisations salariales', line.employeeContributionAmount?.displayValue),
      ('Cotisations patronales', line.employerContributionAmount?.displayValue),
      ('Retenues', line.withholdingAmount?.displayValue),
    ].where((row) => row.$2 != null).toList();

    if (rows.isEmpty) {
      return Text(
        'Aucun montant détaillé retourné pour cette ligne.',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      );
    }

    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        for (final row in rows)
          SizedBox(
            width: 180,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  row.$1,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(
                  row.$2!,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

String _employeeLabel(DeclarationLine line) {
  final snapshot = line.employeeSnapshot;
  if (snapshot != null) {
    final name = _stringValue(snapshot, 'name');
    if (name != null) {
      return name;
    }

    final email = _stringValue(snapshot, 'email');
    if (email != null) {
      return email;
    }
  }

  return 'Employé non identifié';
}

String _employeeReference(DeclarationLine line) {
  final snapshot = line.employeeSnapshot;
  final snapshotEmployeeId = snapshot == null
      ? null
      : _stringValue(snapshot, 'employeeId');
  final snapshotEmail = snapshot == null
      ? null
      : _stringValue(snapshot, 'email');
  final reference =
      snapshotEmployeeId ?? line.employeeId ?? line.userId ?? line.id;
  final parts = <String>[
    if (reference != null) 'Référence : $reference',
    ?snapshotEmail,
  ];

  if (parts.isEmpty) {
    return 'Référence employé indisponible';
  }

  return parts.join(' · ');
}

String? _stringValue(Map<String, Object?> source, String key) {
  final value = source[key];
  return value is String && value.isNotEmpty ? value : null;
}

// ── Status Timeline ──────────────────────────────────────────────────────────

const _timelineSteps = [
  DeclarationStatus.draft,
  DeclarationStatus.readyToReview,
  DeclarationStatus.validated,
  DeclarationStatus.exported,
  DeclarationStatus.submittedManually,
];

class _StatusTimeline extends StatelessWidget {
  const _StatusTimeline({required this.status});

  final DeclarationStatus status;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isArchived = status == DeclarationStatus.archived;
    final currentIndex = isArchived
        ? _timelineSteps.length
        : _timelineSteps.indexOf(status);

    return Column(
      children: _timelineSteps.asMap().entries.map((entry) {
        final index = entry.key;
        final step = entry.value;
        final isDone = isArchived || index <= currentIndex;
        final isCurrent = !isArchived && step == status;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Icon(
                isDone ? Icons.check_circle : Icons.radio_button_unchecked,
                size: 20,
                color: isCurrent
                    ? cs.primary
                    : isDone
                    ? cs.primary
                    : cs.outline,
              ),
              const SizedBox(width: 10),
              Text(
                statusLabel(step),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isCurrent
                      ? cs.primary
                      : isDone
                      ? cs.onSurface
                      : cs.outline,
                  fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// ── Warnings Banner ──────────────────────────────────────────────────────────

class _WarningsBanner extends StatelessWidget {
  const _WarningsBanner({required this.warnings});

  final List<String> warnings;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: cs.errorContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.warning_amber_outlined,
                  size: 18,
                  color: cs.onErrorContainer,
                ),
                const SizedBox(width: 6),
                Text(
                  'Anomalies à vérifier (${warnings.length})',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: cs.onErrorContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ...warnings.map(
              (w) => Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  '• $w',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: cs.onErrorContainer),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Totals Card ──────────────────────────────────────────────────────────────

class _TotalsCard extends StatelessWidget {
  const _TotalsCard({required this.declaration});

  final SocialFiscalDeclaration declaration;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final rows = [
      ('Salaire brut total', declaration.totalGrossSalary.displayValue),
      ('Base taxable totale', declaration.totalTaxableBase.displayValue),
      (
        'Cotisations salariales',
        declaration.totalEmployeeContributions.displayValue,
      ),
      (
        'Cotisations patronales',
        declaration.totalEmployerContributions.displayValue,
      ),
      ('Retenues à la source', declaration.totalWithholdings.displayValue),
    ];

    return Card(
      elevation: 0,
      color: cs.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Valeurs fournies par le backend. Aucun calcul fiscal côté application.',
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(color: cs.onSurfaceVariant),
            ),
            const Divider(height: 16),
            ...rows.map(
              (row) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        row.$1,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      row.$2,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Action Bar ───────────────────────────────────────────────────────────────

class _ActionBar extends ConsumerWidget {
  const _ActionBar({required this.declaration, required this.access});

  final SocialFiscalDeclaration declaration;
  final ComplianceAccess access;

  bool _can(DeclarationAction action) {
    final allowedByRole = switch (action) {
      DeclarationAction.markReady => access.canMarkReady,
      DeclarationAction.validate => access.canValidate,
      DeclarationAction.export => access.canExport,
      DeclarationAction.markSubmitted => access.canMarkSubmitted,
      DeclarationAction.archive => access.canArchive,
    };

    return allowedByRole &&
        DeclarationTransition.canApply(action, declaration.status);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isBusy =
        ref.watch(markReadyControllerProvider).isLoading ||
        ref.watch(validateDeclarationControllerProvider).isLoading ||
        ref.watch(markSubmittedControllerProvider).isLoading ||
        ref.watch(archiveDeclarationControllerProvider).isLoading;

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        if (_can(DeclarationAction.markReady))
          OutlinedButton.icon(
            onPressed: isBusy ? null : () => _markReady(context, ref),
            icon: const Icon(Icons.check_outlined),
            label: const Text('Marquer prêt'),
          ),
        if (_can(DeclarationAction.validate))
          FilledButton.icon(
            onPressed: isBusy ? null : () => _validate(context, ref),
            icon: const Icon(Icons.verified_outlined),
            label: const Text('Valider'),
          ),
        if (_can(DeclarationAction.export))
          OutlinedButton.icon(
            onPressed: isBusy
                ? null
                : () => context.goNamed(
                    AppRoute.complianceExport.name,
                    pathParameters: {'declarationId': declaration.id},
                  ),
            icon: const Icon(Icons.download_outlined),
            label: const Text('Exporter'),
          ),
        if (_can(DeclarationAction.markSubmitted))
          OutlinedButton.icon(
            onPressed: isBusy ? null : () => _markSubmitted(context, ref),
            icon: const Icon(Icons.send_outlined),
            label: const Text('Transmis manuellement'),
          ),
        if (_can(DeclarationAction.archive))
          TextButton.icon(
            onPressed: isBusy ? null : () => _archive(context, ref),
            icon: const Icon(Icons.archive_outlined),
            label: const Text('Archiver'),
          ),
      ],
    );
  }

  Future<void> _markReady(BuildContext context, WidgetRef ref) async {
    await ref
        .read(markReadyControllerProvider.notifier)
        .markReady(declaration.id);
    if (!context.mounted) {
      return;
    }
    _handleDeclarationCommand(
      context,
      ref.read(markReadyControllerProvider),
      successMessage: 'Déclaration marquée prête à vérifier.',
    );
  }

  Future<void> _validate(BuildContext context, WidgetRef ref) async {
    final confirmed = await _confirm(
      context,
      title: 'Valider la déclaration ?',
      message:
          'Cette validation humaine confirme la déclaration préparatoire avant export. Le backend reste la source de vérité.',
      actionLabel: 'Valider',
    );
    if (!confirmed || !context.mounted) {
      return;
    }

    await ref
        .read(validateDeclarationControllerProvider.notifier)
        .validate(declaration.id);
    if (!context.mounted) {
      return;
    }
    _handleDeclarationCommand(
      context,
      ref.read(validateDeclarationControllerProvider),
      successMessage: 'Déclaration validée.',
    );
  }

  Future<void> _markSubmitted(BuildContext context, WidgetRef ref) async {
    final request = await showDialog<MarkSubmittedDeclarationRequest>(
      context: context,
      builder: (_) => const _MarkSubmittedDialog(),
    );
    if (request == null || !context.mounted) {
      return;
    }

    await ref
        .read(markSubmittedControllerProvider.notifier)
        .markSubmitted(declaration.id, request);
    if (!context.mounted) {
      return;
    }
    _handleDeclarationCommand(
      context,
      ref.read(markSubmittedControllerProvider),
      successMessage: 'Transmission manuelle enregistrée.',
    );
  }

  Future<void> _archive(BuildContext context, WidgetRef ref) async {
    final request = await showDialog<ArchiveDeclarationRequest>(
      context: context,
      builder: (_) => const _ArchiveDialog(),
    );
    if (request == null || !context.mounted) {
      return;
    }

    await ref
        .read(archiveDeclarationControllerProvider.notifier)
        .archive(declaration.id, request);
    if (!context.mounted) {
      return;
    }
    _handleDeclarationCommand(
      context,
      ref.read(archiveDeclarationControllerProvider),
      successMessage: 'Déclaration archivée.',
    );
  }

  Future<bool> _confirm(
    BuildContext context, {
    required String title,
    required String message,
    required String actionLabel,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(actionLabel),
          ),
        ],
      ),
    );

    return confirmed ?? false;
  }

  void _handleDeclarationCommand(
    BuildContext context,
    AsyncValue<SocialFiscalDeclaration?> state, {
    required String successMessage,
  }) {
    state.when(
      data: (updated) {
        if (updated == null) {
          return;
        }
        showComplianceSnackBar(context, successMessage);
      },
      error: (error, _) => showComplianceSnackBar(
        context,
        complianceErrorMessage(error),
        isError: true,
      ),
      loading: () {},
    );
  }
}

class _MarkSubmittedDialog extends StatefulWidget {
  const _MarkSubmittedDialog();

  @override
  State<_MarkSubmittedDialog> createState() => _MarkSubmittedDialogState();
}

class _MarkSubmittedDialogState extends State<_MarkSubmittedDialog> {
  final _notesController = TextEditingController();
  DateTime? _submittedAt = DateTime.now();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Marquer comme transmis manuellement ?'),
      content: SizedBox(
        width: 480,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Cette action enregistre une transmission manuelle. Elle ne déclenche aucune télétransmission officielle.',
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _pickSubmittedAt,
              icon: const Icon(Icons.event_outlined),
              label: Text(
                _submittedAt == null
                    ? 'Date de transmission : non renseignée'
                    : 'Date de transmission : ${formatComplianceDate(_submittedAt!)}',
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () => setState(() => _submittedAt = null),
                child: const Text('Retirer la date'),
              ),
            ),
            TextField(
              controller: _notesController,
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Notes',
                hintText: 'Optionnel',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop(
              MarkSubmittedDeclarationRequest(
                submittedAt: _submittedAt,
                notes: _emptyToNull(_notesController.text),
              ),
            );
          },
          child: const Text('Enregistrer'),
        ),
      ],
    );
  }

  Future<void> _pickSubmittedAt() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _submittedAt ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() => _submittedAt = picked);
    }
  }
}

class _ArchiveDialog extends StatefulWidget {
  const _ArchiveDialog();

  @override
  State<_ArchiveDialog> createState() => _ArchiveDialogState();
}

class _ArchiveDialogState extends State<_ArchiveDialog> {
  final _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Archiver la déclaration ?'),
      content: SizedBox(
        width: 480,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'La déclaration restera consultable en archive. Aucun rétablissement n’est proposé tant que le backend ne le supporte pas.',
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reasonController,
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Motif',
                hintText: 'Optionnel',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.of(context).pop(
              ArchiveDeclarationRequest(
                reason: _emptyToNull(_reasonController.text),
              ),
            );
          },
          child: const Text('Archiver'),
        ),
      ],
    );
  }
}

String? _emptyToNull(String value) {
  final trimmed = value.trim();
  return trimmed.isEmpty ? null : trimmed;
}
