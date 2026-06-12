import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../domain/entities/social_fiscal_declaration.dart';
import '../../domain/enums/declaration_status.dart';
import '../../domain/value_objects/compliance_access.dart';
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

        // Action bar (admin/hr only)
        if (!access.isReadOnly) ...[
          const ComplianceSectionTitle('Actions'),
          _ActionBar(declaration: declaration),
        ],

        const SizedBox(height: 24),
      ],
    );
  }
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

class _ActionBar extends StatelessWidget {
  const _ActionBar({required this.declaration});

  final SocialFiscalDeclaration declaration;

  bool _can(DeclarationAction action) =>
      DeclarationTransition.canApply(action, declaration.status);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        if (_can(DeclarationAction.markReady))
          OutlinedButton.icon(
            onPressed: () => _placeholder(context, 'Marquer comme prêt'),
            icon: const Icon(Icons.check_outlined),
            label: const Text('Marquer prêt'),
          ),
        if (_can(DeclarationAction.validate))
          FilledButton.icon(
            onPressed: () => _placeholder(context, 'Valider'),
            icon: const Icon(Icons.verified_outlined),
            label: const Text('Valider'),
          ),
        if (_can(DeclarationAction.export))
          OutlinedButton.icon(
            onPressed: () => context.goNamed(
              AppRoute.complianceExport.name,
              pathParameters: {'declarationId': declaration.id},
            ),
            icon: const Icon(Icons.download_outlined),
            label: const Text('Exporter'),
          ),
        if (_can(DeclarationAction.markSubmitted))
          OutlinedButton.icon(
            onPressed: () =>
                _placeholder(context, 'Marquer comme transmis manuellement'),
            icon: const Icon(Icons.send_outlined),
            label: const Text('Transmis manuellement'),
          ),
        if (_can(DeclarationAction.archive))
          TextButton.icon(
            onPressed: () => _placeholder(context, 'Archiver'),
            icon: const Icon(Icons.archive_outlined),
            label: const Text('Archiver'),
          ),
      ],
    );
  }

  void _placeholder(BuildContext context, String action) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$action : sera connecté au backend.')),
    );
  }
}
