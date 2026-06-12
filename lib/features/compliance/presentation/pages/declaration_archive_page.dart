import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/app_routes.dart';
import '../../domain/entities/social_fiscal_declaration.dart';
import '../../domain/enums/declaration_status.dart';
import '../../domain/value_objects/compliance_requests.dart';
import '../providers/compliance_providers.dart';
import '../widgets/compliance_widgets.dart';

class DeclarationArchivePage extends ConsumerWidget {
  const DeclarationArchivePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Uses the confirmed list route filtered to ARCHIVED – no separate endpoint.
    final access = ref.watch(complianceAccessProvider);
    final archivedAsync = ref.watch(
      declarationsProvider(
        const ListDeclarationsQuery(status: DeclarationStatus.archived),
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Archives')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (access.isReadOnly) const ComplianceReadOnlyBanner(),
          Expanded(
            child: archivedAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => ComplianceErrorState(
                message: complianceErrorMessage(error),
                onRetry: () => ref.invalidate(
                  declarationsProvider(
                    const ListDeclarationsQuery(
                      status: DeclarationStatus.archived,
                    ),
                  ),
                ),
              ),
              data: (declarations) => declarations.isEmpty
                  ? const ComplianceEmptyState(
                      message: 'Aucune déclaration archivée.',
                    )
                  : _ArchiveList(declarations: declarations),
            ),
          ),
        ],
      ),
    );
  }
}

class _ArchiveList extends StatelessWidget {
  const _ArchiveList({required this.declarations});

  final List<SocialFiscalDeclaration> declarations;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: declarations.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) =>
          _ArchiveTile(declaration: declarations[index]),
    );
  }
}

class _ArchiveTile extends StatelessWidget {
  const _ArchiveTile({required this.declaration});

  final SocialFiscalDeclaration declaration;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: cs.surfaceContainerHighest,
      child: ListTile(
        leading: ComplianceTypeChip(declaration.type),
        title: Text(
          '${typeLabel(declaration.type)} – ${declaration.createdAt.year}',
        ),
        subtitle: Text(
          'Archivée le ${formatComplianceDate(declaration.updatedAt)}',
        ),
        trailing: const ComplianceStatusChip(DeclarationStatus.archived),
        onTap: () => context.goNamed(
          AppRoute.complianceDeclarationDetail.name,
          pathParameters: {'declarationId': declaration.id},
        ),
      ),
    );
  }
}
