import 'package:flutter/material.dart';

import '../../../shared/widgets/wiloo_scaffold.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const WilooScaffold(
      title: 'Connexion',
      children: [
        Text(
          'Authentification Better Auth a brancher sur le backend existant.',
        ),
      ],
    );
  }
}
