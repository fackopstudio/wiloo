import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/declaration_export.dart';
import '../../domain/enums/export_format.dart';
import '../../domain/value_objects/compliance_requests.dart';
import '../../domain/value_objects/declaration_transition.dart';
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
  DeclarationExport? _lastExport;
  String? _lastExportId;

  @override
  Widget build(BuildContext context) {
    final access = ref.watch(complianceAccessProvider);
    final declarationAsync = ref.watch(
      declarationDetailProvider(widget.declarationId),
    );
    final statusAllowsExport = declarationAsync.maybeWhen(
      data: (declaration) => DeclarationTransition.canApply(
        DeclarationAction.export,
        declaration.status,
      ),
      orElse: () => false,
    );
    final exportState = ref.watch(exportDeclarationControllerProvider);
    final downloadState = ref.watch(downloadExportControllerProvider);

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
                const _ExportDisclaimer(),
                const ComplianceSectionTitle('Déclaration'),
                declarationAsync.when(
                  loading: () => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (error, _) => ComplianceErrorState(
                    message: complianceErrorMessage(error),
                    onRetry: () => ref.invalidate(
                      declarationDetailProvider(widget.declarationId),
                    ),
                  ),
                  data: (declaration) {
                    final statusAllowsExport = DeclarationTransition.canApply(
                      DeclarationAction.export,
                      declaration.status,
                    );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Card(
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
                        if (!access.canExport)
                          const ComplianceErrorState(
                            message:
                                "Accès refusé. Vous n'êtes pas autorisé à exporter.",
                          )
                        else if (!statusAllowsExport)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              "L'état actuel ne permet pas l'export. Le backend confirmera la transition autorisée.",
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                if (access.canExport) ...[
                  const ComplianceSectionTitle('Format'),
                  ..._formatRows(exportState.isLoading),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: exportState.isLoading || !statusAllowsExport
                        ? null
                        : () => _requestExport(context),
                    icon: exportState.isLoading
                        ? const SizedBox.square(
                            dimension: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.download_outlined),
                    label: const Text('Générer le document préparatoire'),
                  ),
                ],
                if (_lastExport != null) ...[
                  const ComplianceSectionTitle('Export généré'),
                  _GeneratedExportCard(
                    export: _lastExport!,
                    exportId: _lastExportId,
                    isDownloading: downloadState.isLoading,
                    onDownload:
                        access.canDownloadExport &&
                            _lastExportId != null &&
                            !downloadState.isLoading
                        ? () => _downloadExport(context, _lastExportId!)
                        : null,
                  ),
                ],
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }

  List<Widget> _formatRows(bool disabled) {
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
          onTap: disabled
              ? null
              : () => setState(() => _selectedFormat = format),
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

  Future<void> _requestExport(BuildContext context) async {
    await ref
        .read(exportDeclarationControllerProvider.notifier)
        .export(
          widget.declarationId,
          ExportDeclarationRequest(format: _selectedFormat),
        );

    if (!context.mounted) {
      return;
    }

    ref
        .read(exportDeclarationControllerProvider)
        .when(
          data: (declarationExport) {
            if (declarationExport == null) {
              showComplianceSnackBar(
                context,
                'Export terminé, mais aucune référence exploitable n’a été retournée.',
                isError: true,
              );
              ref.invalidate(declarationDetailProvider(widget.declarationId));
              return;
            }

            final exportId = exportIdFromRaw(declarationExport);
            setState(() {
              _lastExport = declarationExport;
              _lastExportId = exportId;
            });

            if (exportId == null) {
              showComplianceSnackBar(
                context,
                "Export généré, mais l'identifiant de téléchargement n'est pas confirmé par le snapshot backend.",
                isError: true,
              );
              ref.invalidate(declarationDetailProvider(widget.declarationId));
              return;
            }

            showComplianceSnackBar(
              context,
              'Export généré. Le téléchargement est disponible.',
            );
          },
          error: (error, _) => showComplianceSnackBar(
            context,
            complianceErrorMessage(error),
            isError: true,
          ),
          loading: () {},
        );
  }

  Future<void> _downloadExport(BuildContext context, String exportId) async {
    await ref
        .read(downloadExportControllerProvider.notifier)
        .download(widget.declarationId, exportId);

    if (!context.mounted) {
      return;
    }

    ref
        .read(downloadExportControllerProvider)
        .when(
          data: (download) {
            if (download == null) {
              return;
            }
            showComplianceSnackBar(
              context,
              'Fichier reçu : ${download.fileName} (${download.contentType}, ${download.bytes.length} octets).',
            );
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

class _GeneratedExportCard extends StatelessWidget {
  const _GeneratedExportCard({
    required this.export,
    required this.exportId,
    required this.isDownloading,
    required this.onDownload,
  });

  final DeclarationExport export;
  final String? exportId;
  final bool isDownloading;
  final VoidCallback? onDownload;

  @override
  Widget build(BuildContext context) {
    final idText = exportId == null
        ? 'Identifiant indisponible dans le snapshot backend'
        : 'Export ID : $exportId';

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              idText,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Text(
              export.raw.isEmpty
                  ? 'Snapshot backend vide.'
                  : 'Snapshot backend conservé sans champs inventés.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: onDownload,
              icon: isDownloading
                  ? const SizedBox.square(
                      dimension: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.file_download_outlined),
              label: const Text('Télécharger'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExportDisclaimer extends StatelessWidget {
  const _ExportDisclaimer();

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
