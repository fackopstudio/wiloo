import 'package:flutter/material.dart';

import '../../../shared/widgets/wiloo_scaffold.dart';

class UnauthorizedScreen extends StatelessWidget {
  const UnauthorizedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const WilooScaffold(
      title: 'Acces refuse',
      children: [
        Text('Vous n\'avez pas les droits pour acceder a cette page.'),
      ],
    );
  }
}
