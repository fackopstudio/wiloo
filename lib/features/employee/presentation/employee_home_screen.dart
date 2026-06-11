import 'package:flutter/material.dart';

import '../../../shared/widgets/wiloo_scaffold.dart';

class EmployeeHomeScreen extends StatelessWidget {
  const EmployeeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const WilooScaffold(
      title: 'Espace employe',
      children: [Text('Tableau de bord employe: presence, conges et profil.')],
    );
  }
}
