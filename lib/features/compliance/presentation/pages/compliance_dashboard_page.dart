import 'package:flutter/material.dart';

import '../../../../shared/widgets/wiloo_scaffold.dart';

class ComplianceDashboardPage extends StatelessWidget {
  const ComplianceDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const WilooScaffold(
      title: 'Conformite sociale et fiscale',
      children: [
        Text(
          'Tableau de bord compose depuis les periodes et declarations backend.',
        ),
      ],
    );
  }
}
