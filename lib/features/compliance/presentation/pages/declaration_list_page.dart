import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../domain/entities/social_fiscal_declaration.dart';
import '../../domain/enums/declaration_status.dart';
import '../../domain/enums/declaration_type.dart';
import '../../domain/value_objects/compliance_access.dart';
import '../../domain/value_objects/compliance_requests.dart';
import '../providers/compliance_providers.dart';
import '../widgets/compliance_widgets.dart';

class DeclarationListPage extends ConsumerStatefulWidget {
  const DeclarationListPage({super.key});

  @override
  ConsumerState<DeclarationListPage> createState() =>
      _DeclarationListPageState();
}

class _DeclarationListPageState extends ConsumerState<DeclarationListPage> {
  // Stored as a field so Riverpod family caching works correctly:
  // the same object reference across rebuilds means the same provider instance.
  ListDeclarationsQuery _query = const ListDeclarationsQuery();
  DeclarationType? _typeFilter;
  DeclarationStatus? _statusFilter;

  void _applyFilters({DeclarationType? type, DeclarationStatus? status}) {
    setState(() {
      _typeFilter = type;
      _statusFilter = status;
      final newType = type;
      final newStatus = status;
      if (newType == null && newStatus == null) {
        _query = const ListDeclarationsQuery();
      } else {
        _query = ListDeclarationsQuery(type: newType, status: newStatus);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final access = ref.watch(complianceAccessProvider);
    final declarationsAsync = ref.watch(declarationsProvider(_query));

    return Scaffold(
      appBar: AppBar(title: const Text('Déclarations')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (access.isReadOnly) const ComplianceReadOnlyBanner(),
          _FilterBar(
            selectedType: _typeFilter,
            selectedStatus: _statusFilter,
            onTypeChanged: (t) => _applyFilters(type: t, status: _statusFilter),
            onStatusChanged: (s) => _applyFilters(type: _typeFilter, status: s),
            onClear: () => _applyFilters(),
          ),
          Expanded(
            child: declarationsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_, _) => ComplianceErrorState(
                message: 'Impossible de charger les déclarations.',
                onRetry: () => ref.invalidate(declarationsProvider(_query)),
              ),
              data: (declarations) => declarations.isEmpty
                  ? ComplianceEmptyState(
                      message: 'Aucune déclaration.',
                      actionLabel: access.canGenerate ? 'Générer' : null,
                      onAction: access.canGenerate
                          ? () => context.goNamed(
                              AppRoute.complianceGenerate.name,
                            )
                          : null,
                    )
                  : _DeclarationList(
                      declarations: declarations,
                      access: access,
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: access.canGenerate
          ? FloatingActionButton.extended(
              onPressed: () =>
                  context.goNamed(AppRoute.complianceGenerate.name),
              icon: const Icon(Icons.add),
              label: const Text('Générer'),
            )
          : null,
    );
  }
}

class _FilterBar extends StatelessWidget {
  const _FilterBar({
    required this.selectedType,
    required this.selectedStatus,
    required this.onTypeChanged,
    required this.onStatusChanged,
    required this.onClear,
  });

  final DeclarationType? selectedType;
  final DeclarationStatus? selectedStatus;
  final ValueChanged<DeclarationType?> onTypeChanged;
  final ValueChanged<DeclarationStatus?> onStatusChanged;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    final active = [
      DeclarationType.cnss,
      DeclarationType.cnamgs,
      DeclarationType.irpp,
    ];
    final hasFilter = selectedType != null || selectedStatus != null;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          ...active.map(
            (t) => Padding(
              padding: const EdgeInsets.only(right: 6),
              child: FilterChip(
                label: Text(typeLabel(t)),
                selected: selectedType == t,
                onSelected: (_) => onTypeChanged(selectedType == t ? null : t),
              ),
            ),
          ),
          const SizedBox(width: 4),
          FilterChip(
            label: Text(statusLabel(DeclarationStatus.draft)),
            selected: selectedStatus == DeclarationStatus.draft,
            onSelected: (_) => onStatusChanged(
              selectedStatus == DeclarationStatus.draft
                  ? null
                  : DeclarationStatus.draft,
            ),
          ),
          const SizedBox(width: 6),
          FilterChip(
            label: Text(statusLabel(DeclarationStatus.readyToReview)),
            selected: selectedStatus == DeclarationStatus.readyToReview,
            onSelected: (_) => onStatusChanged(
              selectedStatus == DeclarationStatus.readyToReview
                  ? null
                  : DeclarationStatus.readyToReview,
            ),
          ),
          if (hasFilter) ...[
            const SizedBox(width: 8),
            ActionChip(
              label: const Text('Effacer'),
              avatar: const Icon(Icons.close, size: 14),
              onPressed: onClear,
            ),
          ],
        ],
      ),
    );
  }
}

class _DeclarationList extends StatelessWidget {
  const _DeclarationList({required this.declarations, required this.access});

  final List<SocialFiscalDeclaration> declarations;
  final ComplianceAccess access;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: declarations.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) =>
          _DeclarationTile(declaration: declarations[index]),
    );
  }
}

class _DeclarationTile extends StatelessWidget {
  const _DeclarationTile({required this.declaration});

  final SocialFiscalDeclaration declaration;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        leading: ComplianceTypeChip(declaration.type),
        title: Text(
          '${typeLabel(declaration.type)} – ${declaration.createdAt.year}',
        ),
        subtitle: Text(
          'Salaire brut : ${declaration.totalGrossSalary.displayValue}',
        ),
        trailing: ComplianceStatusChip(declaration.status),
        onTap: () => context.goNamed(
          AppRoute.complianceDeclarationDetail.name,
          pathParameters: {'declarationId': declaration.id},
        ),
      ),
    );
  }
}
