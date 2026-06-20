import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../app/theme/app_theme.dart';

/// Information screen for the invitation-only MVP account provisioning policy.
///
/// No registration request is built or sent from Flutter. Role, tenant,
/// organization ownership and scope are assigned exclusively by the backend.
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static const invitationMessage =
      'La création de compte se fait sur invitation de votre organisation.';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(WilooTokens.space24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(WilooTokens.space24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          key: const Key('register_back_to_welcome'),
                          tooltip: 'Retour à l’accueil',
                          onPressed: () => context.go(AppRoute.welcome.path),
                          icon: const Icon(Icons.arrow_back),
                        ),
                      ),
                      Image.asset(
                        'assets/brand/wiloo_logo_horizontal.png',
                        height: 46,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: WilooTokens.space24),
                      CircleAvatar(
                        radius: 34,
                        backgroundColor: colors.primaryContainer,
                        child: Icon(
                          Icons.mark_email_read_outlined,
                          size: 32,
                          color: colors.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: WilooTokens.space20),
                      Text(
                        'Accès sur invitation',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: WilooTokens.space12),
                      Text(
                        invitationMessage,
                        key: const Key('register_invitation_message'),
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: colors.onSurfaceVariant,
                          height: 1.45,
                        ),
                      ),
                      const SizedBox(height: WilooTokens.space16),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: colors.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(
                            WilooTokens.radiusSm,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(WilooTokens.space16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.admin_panel_settings_outlined,
                                color: colors.primary,
                              ),
                              const SizedBox(width: WilooTokens.space12),
                              const Expanded(
                                child: Text(
                                  'Votre administrateur Wiloo vous communiquera '
                                  'les informations nécessaires pour accéder à '
                                  'votre espace sécurisé.',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: WilooTokens.space24),
                      FilledButton.icon(
                        key: const Key('register_login_link'),
                        onPressed: () => context.go(AppRoute.auth.path),
                        icon: const Icon(Icons.login),
                        label: const Text('Revenir à la connexion'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
