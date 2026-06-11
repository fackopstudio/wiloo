import 'package:flutter/material.dart';

import '../../../../shared/widgets/wiloo_scaffold.dart';

class DeclarationDetailPage extends StatelessWidget {
  const DeclarationDetailPage({required this.declarationId, super.key});

  final String declarationId;

  @override
  Widget build(BuildContext context) {
    return WilooScaffold(
      title: 'Detail declaration',
      children: [
        Text('Declaration: $declarationId'),
        const Text('Les montants affiches viendront du backend.'),
      ],
    );
  }
}
