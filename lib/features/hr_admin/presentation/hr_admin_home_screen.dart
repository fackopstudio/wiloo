import 'package:flutter/material.dart';

import '../../../shared/widgets/wiloo_scaffold.dart';

class HrAdminHomeScreen extends StatelessWidget {
  const HrAdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const WilooScaffold(
      title: 'Administration RH',
      children: [Text('Employes, presences, conges et preparation paie.')],
    );
  }
}
