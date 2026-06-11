import 'package:flutter/material.dart';

import '../../../../shared/widgets/wiloo_scaffold.dart';

class DeclarationArchivePage extends StatelessWidget {
  const DeclarationArchivePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const WilooScaffold(
      title: 'Archives declaratives',
      children: [
        Text('Archive composee depuis la liste des declarations ARCHIVED.'),
      ],
    );
  }
}
