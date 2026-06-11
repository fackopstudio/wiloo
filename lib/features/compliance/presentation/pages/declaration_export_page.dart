import 'package:flutter/material.dart';

import '../../../../shared/widgets/wiloo_scaffold.dart';

class DeclarationExportPage extends StatelessWidget {
  const DeclarationExportPage({required this.declarationId, super.key});

  final String declarationId;

  @override
  Widget build(BuildContext context) {
    return WilooScaffold(
      title: 'Exporter une declaration',
      children: [
        Text('Declaration: $declarationId'),
        const Text('Le telechargement sera traite comme un flux binaire.'),
      ],
    );
  }
}
