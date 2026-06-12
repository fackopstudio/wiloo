import 'package:flutter/material.dart';

import '../../domain/enums/declaration_status.dart';
import '../../domain/enums/declaration_type.dart';

// ── Labels ──────────────────────────────────────────────────────────────────

String statusLabel(DeclarationStatus status) => switch (status) {
  DeclarationStatus.draft => 'Brouillon',
  DeclarationStatus.readyToReview => 'À vérifier',
  DeclarationStatus.validated => 'Validée',
  DeclarationStatus.exported => 'Exportée',
  DeclarationStatus.submittedManually => 'Transmise manuellement',
  DeclarationStatus.archived => 'Archivée',
};

String typeLabel(DeclarationType type) => switch (type) {
  DeclarationType.cnss => 'CNSS',
  DeclarationType.cnamgs => 'CNAMGS',
  DeclarationType.irpp => 'IRPP',
  DeclarationType.isTax => 'IS',
};

Color statusChipColor(BuildContext context, DeclarationStatus status) {
  final cs = Theme.of(context).colorScheme;
  return switch (status) {
    DeclarationStatus.draft => cs.primaryContainer,
    DeclarationStatus.readyToReview => cs.secondaryContainer,
    DeclarationStatus.validated => cs.tertiaryContainer,
    DeclarationStatus.exported => cs.surfaceContainerHighest,
    DeclarationStatus.submittedManually => cs.primaryContainer,
    DeclarationStatus.archived => cs.outlineVariant,
  };
}

// ── ComplianceStatusChip ─────────────────────────────────────────────────────

class ComplianceStatusChip extends StatelessWidget {
  const ComplianceStatusChip(this.status, {super.key});

  final DeclarationStatus status;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: statusChipColor(context, status),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          statusLabel(status),
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: cs.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ── ComplianceTypeChip ───────────────────────────────────────────────────────

class ComplianceTypeChip extends StatelessWidget {
  const ComplianceTypeChip(this.type, {super.key});

  final DeclarationType type;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final disabled = type == DeclarationType.isTax;
    final label = disabled
        ? '${typeLabel(type)} – non disponible'
        : typeLabel(type);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: disabled ? cs.surfaceContainerHighest : cs.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: disabled ? Border.all(color: cs.outlineVariant) : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: disabled ? cs.onSurfaceVariant : cs.onPrimaryContainer,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ── CompliancePreparatoryNotice ──────────────────────────────────────────────

class CompliancePreparatoryNotice extends StatelessWidget {
  const CompliancePreparatoryNotice({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: cs.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info_outline, size: 18, color: cs.onSecondaryContainer),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Ces déclarations sont préparatoires. '
                'Elles ne constituent pas une transmission officielle '
                'à la CNSS, CNAMGS ou à la DGI.',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: cs.onSecondaryContainer),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── ComplianceReadOnlyBanner ─────────────────────────────────────────────────

class ComplianceReadOnlyBanner extends StatelessWidget {
  const ComplianceReadOnlyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ColoredBox(
      color: cs.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Icon(
              Icons.visibility_outlined,
              size: 16,
              color: cs.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Text(
              'Consultation uniquement',
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: cs.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

// ── ComplianceEmptyState ─────────────────────────────────────────────────────

class ComplianceEmptyState extends StatelessWidget {
  const ComplianceEmptyState({
    required this.message,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.folder_open_outlined, size: 56, color: cs.outline),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 24),
              FilledButton(onPressed: onAction, child: Text(actionLabel!)),
            ],
          ],
        ),
      ),
    );
  }
}

// ── ComplianceErrorState ─────────────────────────────────────────────────────

class ComplianceErrorState extends StatelessWidget {
  const ComplianceErrorState({required this.message, this.onRetry, super.key});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 56, color: cs.error),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: cs.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              OutlinedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: const Text('Réessayer'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ── ComplianceKpiCard ────────────────────────────────────────────────────────

class ComplianceKpiCard extends StatelessWidget {
  const ComplianceKpiCard({
    required this.label,
    required this.value,
    this.onTap,
    super.key,
  });

  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: cs.surfaceContainerHighest,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium?.copyWith(color: cs.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── ComplianceSectionTitle ───────────────────────────────────────────────────

class ComplianceSectionTitle extends StatelessWidget {
  const ComplianceSectionTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 8),
      child: Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
