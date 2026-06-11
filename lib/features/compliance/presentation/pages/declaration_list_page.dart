import 'package:flutter/material.dart';

import '../../../../shared/widgets/wiloo_scaffold.dart';

class DeclarationListPage extends StatelessWidget {
  const DeclarationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const WilooScaffold(
      title: 'Declarations',
      children: [Text('Liste des declarations sociales et fiscales.')],
    );
  }
}
