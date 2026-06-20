import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../../../shared/motion/wiloo_motion.dart';
import '../../../../shared/responsive/responsive.dart';
import '../../../../shared/widgets/wiloo_shimmer.dart';
import '../../domain/entities/compliance_dashboard_view.dart';
import '../../domain/enums/declaration_status.dart';
import '../../domain/value_objects/compliance_access.dart';
import '../providers/compliance_providers.dart';
import '../widgets/compliance_widgets.dart';

class ComplianceDashboardPage extends ConsumerWidget {
  const ComplianceDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final access = ref.watch(complianceAccessProvider);
    final dashboardAsync = ref.watch(complianceDashboardProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Conformité sociale et fiscale')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (access.isReadOnly) const ComplianceReadOnlyBanner(),
          Expanded(
            child: dashboardAsync.when(
              loading: () => const _DashboardLoading(),
              error: (_, _) => ComplianceErrorState(
                message: 'Impossible de charger le tableau de bord.',
                onRetry: () => ref.invalidate(complianceDashboardProvider),
              ),
              data: (view) => _DashboardBody(view: view, access: access),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody({required this.view, required this.access});

  final ComplianceDashboardView view;
  final ComplianceAccess access;

  Map<DeclarationStatus, int> _statusCounts() {
    final counts = <DeclarationStatus, int>{};
    for (final d in view.declarations) {
      counts[d.status] = (counts[d.status] ?? 0) + 1;
    }
    return counts;
  }

  @override
  Widget build(BuildContext context) {
    final counts = _statusCounts();

    return PageContainer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
        const CompliancePreparatoryNotice(),
        const SizedBox(height: 20),
        const ComplianceSectionTitle("Vue d'ensemble"),
        _KpiGrid(counts: counts, totalPeriods: view.periods.length),
        const ComplianceSectionTitle('Navigation'),
        _NavCard(
          icon: Icons.calendar_month_outlined,
          title: 'Périodes déclaratives',
          subtitle: '${view.periods.length} période(s)',
          routeName: AppRoute.compliancePeriods.name,
        ),
        _NavCard(
          icon: Icons.description_outlined,
          title: 'Déclarations',
          subtitle: '${view.declarations.length} déclaration(s)',
          routeName: AppRoute.complianceDeclarations.name,
        ),
        if (access.canArchive)
          _NavCard(
            icon: Icons.archive_outlined,
            title: 'Archives',
            subtitle: '${counts[DeclarationStatus.archived] ?? 0} archivée(s)',
            routeName: AppRoute.complianceArchive.name,
          ),
        if (access.canGenerate) ...[
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => context.goNamed(AppRoute.complianceGenerate.name),
            icon: const Icon(Icons.add),
            label: const Text('Générer une déclaration préparatoire'),
          ),
        ],
        const SizedBox(height: 16),
        ],
      ),
    ).wilooEntrance();
  }
}

class _DashboardLoading extends StatelessWidget {
  const _DashboardLoading();

  @override
  Widget build(BuildContext context) {
    return const PageContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ShimmerBox(height: 56),
          SizedBox(height: 20),
          ShimmerList(itemCount: 4),
        ],
      ),
    );
  }
}

class _KpiGrid extends StatelessWidget {
  const _KpiGrid({required this.counts, required this.totalPeriods});

  final Map<DeclarationStatus, int> counts;
  final int totalPeriods;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cols = constraints.maxWidth >= 480 ? 3 : 2;
        final itemWidth = (constraints.maxWidth - (cols - 1) * 8) / cols;
        final items = [
          (
            statusLabel(DeclarationStatus.draft),
            counts[DeclarationStatus.draft] ?? 0,
          ),
          (
            statusLabel(DeclarationStatus.readyToReview),
            counts[DeclarationStatus.readyToReview] ?? 0,
          ),
          (
            statusLabel(DeclarationStatus.validated),
            counts[DeclarationStatus.validated] ?? 0,
          ),
          (
            statusLabel(DeclarationStatus.exported),
            counts[DeclarationStatus.exported] ?? 0,
          ),
          (
            statusLabel(DeclarationStatus.submittedManually),
            counts[DeclarationStatus.submittedManually] ?? 0,
          ),
          ('Périodes', totalPeriods),
        ];

        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items
              .map(
                (item) => SizedBox(
                  width: itemWidth,
                  child: ComplianceKpiCard(label: item.$1, value: '${item.$2}'),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class _NavCard extends StatelessWidget {
  const _NavCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.routeName,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.goNamed(routeName),
      ),
    );
  }
}
