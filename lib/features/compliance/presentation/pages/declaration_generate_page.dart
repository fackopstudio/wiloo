import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/enums/declaration_type.dart';
import '../widgets/compliance_widgets.dart';

class DeclarationGeneratePage extends ConsumerStatefulWidget {
  const DeclarationGeneratePage({super.key});

  @override
  ConsumerState<DeclarationGeneratePage> createState() =>
      _DeclarationGeneratePageState();
}

class _DeclarationGeneratePageState
    extends ConsumerState<DeclarationGeneratePage> {
  DeclarationType? _selectedType;

  static const _activeTypes = [
    DeclarationType.cnss,
    DeclarationType.cnamgs,
    DeclarationType.irpp,
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Générer une déclaration')),
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
                const ComplianceSectionTitle('Type de déclaration'),
                ..._activeTypes.map(
                  (type) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: _TypeOption(
                      type: type,
                      selected: _selectedType == type,
                      onTap: () => setState(() => _selectedType = type),
                    ),
                  ),
                ),
                // IS – gated as unavailable
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _DisabledTypeOption(
                    type: DeclarationType.isTax,
                    reason: 'Type IS non disponible dans cette version.',
                  ),
                ),
                const SizedBox(height: 24),
                if (_selectedType != null) ...[
                  _ConfirmCard(selectedType: _selectedType!),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () => _generate(context),
                    icon: const Icon(Icons.play_arrow_outlined),
                    label: const Text('Générer la déclaration préparatoire'),
                  ),
                ] else
                  OutlinedButton(
                    onPressed: null,
                    child: Text(
                      'Sélectionner un type de déclaration',
                      style: TextStyle(color: cs.onSurfaceVariant),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _generate(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Génération préparatoire ${typeLabel(_selectedType!)} : '
          'sera connectée au backend.',
        ),
      ),
    );
  }
}

class _TypeOption extends StatelessWidget {
  const _TypeOption({
    required this.type,
    required this.selected,
    required this.onTap,
  });

  final DeclarationType type;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: selected ? cs.primaryContainer : cs.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: selected
            ? BorderSide(color: cs.primary, width: 2)
            : BorderSide.none,
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(
                selected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
                color: selected ? cs.primary : cs.onSurfaceVariant,
              ),
              const SizedBox(width: 12),
              Text(
                typeLabel(type),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: selected ? cs.onPrimaryContainer : cs.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DisabledTypeOption extends StatelessWidget {
  const _DisabledTypeOption({required this.type, required this.reason});

  final DeclarationType type;
  final String reason;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: cs.surfaceContainerHighest,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: cs.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(Icons.radio_button_unchecked, color: cs.outlineVariant),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${typeLabel(type)} – non disponible',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: cs.onSurfaceVariant,
                    ),
                  ),
                  Text(
                    reason,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: cs.outlineVariant),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConfirmCard extends StatelessWidget {
  const _ConfirmCard({required this.selectedType});

  final DeclarationType selectedType;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      elevation: 0,
      color: cs.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Confirmation',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Vous allez générer une déclaration préparatoire de type '
              '${typeLabel(selectedType)}. '
              'Cette opération est synchrone et ne constitue pas '
              'une soumission officielle.',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
