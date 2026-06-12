import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../domain/entities/declaration_period.dart';
import '../../domain/enums/period_type.dart';
import '../../domain/value_objects/compliance_requests.dart';
import '../providers/compliance_providers.dart';
import '../widgets/compliance_widgets.dart';

class DeclarationPeriodsPage extends ConsumerWidget {
  const DeclarationPeriodsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final access = ref.watch(complianceAccessProvider);
    final periodsAsync = ref.watch(
      declarationPeriodsProvider(const ListDeclarationPeriodsQuery()),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Périodes déclaratives')),
      floatingActionButton: access.canCreatePeriod
          ? FloatingActionButton.extended(
              onPressed: () => _showPlaceholder(context),
              icon: const Icon(Icons.add),
              label: const Text('Nouvelle période'),
            )
          : null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (access.isReadOnly) const ComplianceReadOnlyBanner(),
          Expanded(
            child: periodsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => ComplianceErrorState(
                message: 'Impossible de charger les périodes.',
                onRetry: () => ref.invalidate(
                  declarationPeriodsProvider(
                    const ListDeclarationPeriodsQuery(),
                  ),
                ),
              ),
              data: (periods) => periods.isEmpty
                  ? ComplianceEmptyState(
                      message: 'Aucune période déclarative.',
                      actionLabel: access.canCreatePeriod
                          ? 'Créer une période'
                          : null,
                      onAction: access.canCreatePeriod
                          ? () => _showPlaceholder(context)
                          : null,
                    )
                  : _PeriodList(periods: periods),
            ),
          ),
        ],
      ),
    );
  }

  void _showPlaceholder(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Création de période : sera disponible prochainement.'),
      ),
    );
  }
}

class _PeriodList extends StatelessWidget {
  const _PeriodList({required this.periods});

  final List<DeclarationPeriod> periods;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: periods.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) => _PeriodCard(period: periods[index]),
    );
  }
}

class _PeriodCard extends StatelessWidget {
  const _PeriodCard({required this.period});

  final DeclarationPeriod period;

  String _periodSubtitle() {
    return switch (period.periodType) {
      PeriodType.monthly =>
        period.month != null ? 'Mois ${period.month}' : '${period.year}',
      PeriodType.quarterly =>
        period.quarter != null
            ? 'T${period.quarter} ${period.year}'
            : '${period.year}',
      PeriodType.yearly => '${period.year}',
    };
  }

  String _periodTypeLabel() => switch (period.periodType) {
    PeriodType.monthly => 'Mensuelle',
    PeriodType.quarterly => 'Trimestrielle',
    PeriodType.yearly => 'Annuelle',
  };

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: const Icon(Icons.calendar_month_outlined),
        title: Text('${_periodTypeLabel()} ${period.year}'),
        subtitle: Text(_periodSubtitle()),
        trailing: ComplianceStatusChip(period.status),
        onTap: () => context.goNamed(AppRoute.complianceDeclarations.name),
      ),
    );
  }
}
