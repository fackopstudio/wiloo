import 'package:flutter/material.dart';

import '../../../../shared/widgets/wiloo_scaffold.dart';

class DeclarationPeriodsPage extends StatelessWidget {
  const DeclarationPeriodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const WilooScaffold(
      title: 'Periodes declaratives',
      children: [Text('Liste des periodes fournies par le backend.')],
    );
  }
}
