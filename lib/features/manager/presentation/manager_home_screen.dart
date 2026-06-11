import 'package:flutter/material.dart';

import '../../../shared/widgets/wiloo_scaffold.dart';

class ManagerHomeScreen extends StatelessWidget {
  const ManagerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const WilooScaffold(
      title: 'Espace manager',
      children: [Text('Pilotage equipe, validations et alertes.')],
    );
  }
}
