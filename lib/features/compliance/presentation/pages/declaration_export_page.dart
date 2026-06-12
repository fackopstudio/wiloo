import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/enums/export_format.dart';
import '../providers/compliance_providers.dart';
import '../widgets/compliance_widgets.dart';

class DeclarationExportPage extends ConsumerStatefulWidget {
  const DeclarationExportPage({required this.declarationId, super.key});

  final String declarationId;

  @override
  ConsumerState<DeclarationExportPage> createState() =>
      _DeclarationExportPageState();
}

class _DeclarationExportPageState extends ConsumerState<DeclarationExportPage> {
  ExportFormat _selectedFormat = ExportFormat.pdf;

  @override
  Widget build(BuildContext context) {
    final declarationAsync = ref.watch(
      declarationDetailProvider(widget.declarationId),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Exporter la déclaration')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 720;
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: wide ? constraints.maxWidth * 0.2 : 16,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CompliancePreparatoryNotice(),
                const SizedBox(height: 8),
                _ExportDisclaimer(),
                const ComplianceSectionTitle('Déclaration'),
                declarationAsync.when(
                  loading: () => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (_, _) => ComplianceErrorState(
                    message: 'Impossible de charger la déclaration.',
                    onRetry: () => ref.invalidate(
                      declarationDetailProvider(widget.declarationId),
                    ),
                  ),
                  data: (declaration) => Card(
                    elevation: 0,
                    child: ListTile(
                      leading: ComplianceTypeChip(declaration.type),
                      title: Text(typeLabel(declaration.type)),
                      subtitle: Text(
                        'Statut : ${statusLabel(declaration.status)}',
                      ),
                      trailing: ComplianceStatusChip(declaration.status),
                    ),
                  ),
                ),
                const ComplianceSectionTitle('Format'),
                ..._formatRows(),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: () => _requestExport(context),
                  icon: const Icon(Icons.download_outlined),
                  label: const Text('Générer le document préparatoire'),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _formatRows() {
    final cs = Theme.of(context).colorScheme;
    return ExportFormat.values.map((format) {
      final label = switch (format) {
        ExportFormat.pdf => 'PDF',
        ExportFormat.excel => 'Excel (.xlsx)',
        ExportFormat.csv => 'CSV',
      };
      final selected = _selectedFormat == format;
      return Card(
        elevation: 0,
        color: selected ? cs.primaryContainer : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: selected
              ? BorderSide(color: cs.primary, width: 2)
              : BorderSide.none,
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () => setState(() => _selectedFormat = format),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Icon(
                  selected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_unchecked,
                  color: selected ? cs.primary : cs.onSurfaceVariant,
                ),
                const SizedBox(width: 12),
                Text(label),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  void _requestExport(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Export ${_selectedFormat.apiValue} demandé : '
          'sera connecté au backend.',
        ),
      ),
    );
  }
}

class _ExportDisclaimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.file_download_outlined,
              size: 18,
              color: cs.onSurfaceVariant,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                'Ce document est préparatoire. '
                'Il ne constitue pas un justificatif de dépôt officiel '
                'auprès de la CNSS, CNAMGS ou de la DGI.',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
