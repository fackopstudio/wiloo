import 'package:flutter/material.dart';

import '../../../../shared/widgets/wiloo_scaffold.dart';

class DeclarationGeneratePage extends StatelessWidget {
  const DeclarationGeneratePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const WilooScaffold(
      title: 'Generer une declaration',
      children: [
        Text(
          'La generation est declenchee par Flutter et executee par le backend.',
        ),
      ],
    );
  }
}
