import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../app/theme/app_theme.dart';
import '../../../core/config/app_config.dart';
import '../../../core/config/app_environment.dart';
import '../../../shared/motion/wiloo_motion.dart';
import '../../../shared/responsive/responsive.dart';
import '../../auth/application/session_controller.dart';
import '../../auth/domain/user_role.dart';
import '../../compliance/domain/value_objects/compliance_access.dart';

/// Backoffice landing page, rendered as content inside [BackofficeShell].
///
/// No Scaffold or AppBar: the shell owns the chrome. This page surfaces
/// the available and upcoming modules for the authenticated role.
class BackofficeDashboardPage extends ConsumerWidget {
  const BackofficeDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionControllerProvider);
    final access = ComplianceAccess.forRole(session.role);
    final user = session.user;
    final cs = Theme.of(context).colorScheme;

    return PageContainer(
      scrollable: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Welcome header ─────────────────────────────────────────────
          _WelcomeHeader(
            displayName: user?.name ?? user?.email,
            role: session.role,
          ).wilooEntrance(index: 0),
          const SizedBox(height: WilooTokens.space28),

          // ── Active modules ─────────────────────────────────────────────
          _SectionLabel(
            icon: Icons.check_circle_outline,
            label: 'Modules disponibles',
            color: cs.primary,
          ).wilooEntrance(index: 1),
          const SizedBox(height: WilooTokens.space12),
          ResponsiveCardGrid(
            maxColumns: 2,
            minTileWidth: 320,
            children: [
              if (access.canView)
                _ComplianceCard(access: access),
              const _TimeclockCard(),
            ],
          ).wilooEntrance(index: 2),
          const SizedBox(height: WilooTokens.space24),

          // ── Coming soon ────────────────────────────────────────────────
          _SectionLabel(
            icon: Icons.schedule_outlined,
            label: 'Bientôt disponible',
            color: cs.onSurfaceVariant,
          ).wilooEntrance(index: 3),
          const SizedBox(height: WilooTokens.space12),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 720;
              return isWide
                  ? const _ComingSoonGrid(key: Key('coming_soon_grid'))
                  : const _ComingSoonList(key: Key('coming_soon_list'));
            },
          ).wilooEntrance(index: 4),
        ],
      ),
    );
  }
}

// ── Welcome header ─────────────────────────────────────────────────────────────

class _WelcomeHeader extends StatelessWidget {
  const _WelcomeHeader({this.displayName, this.role});

  final String? displayName;
  final UserRole? role;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayName != null
                    ? 'Bonjour, ${_firstName(displayName!)} 👋'
                    : 'Bienvenue dans le backoffice Wiloo',
                key: const Key('welcome_title'),
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                _subtitle(role),
                key: const Key('welcome_subtitle'),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: WilooTokens.space12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (role != null)
              Chip(
                key: const Key('dashboard_role_badge'),
                avatar: Icon(
                  _roleIcon(role!),
                  size: 16,
                  color: cs.onSecondaryContainer,
                ),
                label: Text(
                  _roleLabel(role!),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: cs.onSecondaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                backgroundColor: cs.secondaryContainer,
                side: BorderSide.none,
                padding: const EdgeInsets.symmetric(horizontal: 4),
              ),
            if (AppConfig.environment != AppEnvironment.prod) ...[
              const SizedBox(height: 6),
              _EnvIndicator(),
            ],
          ],
        ),
      ],
    );
  }

  String _firstName(String displayName) {
    final parts = displayName.split(RegExp(r'[\s@]'));
    final first = parts.firstOrNull ?? displayName;
    if (first.isEmpty) return displayName;
    return first[0].toUpperCase() + first.substring(1);
  }

  String _subtitle(UserRole? role) => switch (role) {
    UserRole.admin => 'Vous avez accès complet à tous les modules disponibles.',
    UserRole.hr => 'Accès complet aux modules RH et à la conformité sociale.',
    UserRole.manager =>
      'Consultation de la conformité et pilotage de votre équipe.',
    UserRole.supervisor ||
    UserRole.employee => 'Votre espace de travail Wiloo.',
    UserRole.timeTerminal || null => 'Espace Wiloo.',
  };
}

class _EnvIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      key: const Key('dashboard_env_indicator'),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: cs.tertiaryContainer,
        borderRadius: BorderRadius.circular(WilooTokens.radiusLg),
      ),
      child: Text(
        '${AppConfig.environment.name.toUpperCase()} · ${AppConfig.appMode.name}',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: cs.onTertiaryContainer,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ── Section label ──────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: color),
        ),
      ],
    );
  }
}

// ── Compliance card ────────────────────────────────────────────────────────────

class _ComplianceCard extends StatelessWidget {
  const _ComplianceCard({required this.access});

  final ComplianceAccess access;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      key: const Key('compliance_card'),
      elevation: 0,
      color: cs.primaryContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(WilooTokens.radiusMd),
        side: BorderSide(color: cs.primary.withValues(alpha: 0.25)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(WilooTokens.space20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: cs.primary,
                  child: Icon(
                    Icons.fact_check_outlined,
                    color: cs.onPrimary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: WilooTokens.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Conformité sociale & fiscale',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: cs.onPrimaryContainer,
                            ),
                      ),
                      Text(
                        'Déclarations préparatoires CNSS, CNAMGS, IRPP',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: cs.onPrimaryContainer.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: WilooTokens.space12),
            Text(
              access.isReadOnly
                  ? 'Consultez les déclarations préparatoires générées par '
                        'votre équipe RH. Lecture seule.'
                  : 'Créez des périodes, générez les déclarations '
                        'préparatoires CNSS/CNAMGS/IRPP, exportez en PDF/Excel '
                        'et suivez les soumissions manuelles.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: cs.onPrimaryContainer),
            ),
            const SizedBox(height: WilooTokens.space16),
            FilledButton.icon(
              key: const Key('compliance_open_button'),
              onPressed: () => context.push(AppRoute.compliance.path),
              icon: const Icon(Icons.arrow_forward),
              label: Text(
                access.isReadOnly
                    ? 'Consulter la conformité'
                    : 'Ouvrir la conformité',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Timeclock card ───────────────────────────────────────────────────────────────

class _TimeclockCard extends StatelessWidget {
  const _TimeclockCard();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      key: const Key('timeclock_card'),
      elevation: 0,
      color: cs.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(WilooTokens.radiusMd),
        side: BorderSide(color: cs.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(WilooTokens.space20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: cs.secondaryContainer,
                  child: Icon(
                    Icons.access_time_outlined,
                    color: cs.onSecondaryContainer,
                    size: 20,
                  ),
                ),
                const SizedBox(width: WilooTokens.space12),
                Expanded(
                  child: Text(
                    'Pointage / Terminal',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: WilooTokens.space12),
            Text(
              'Ouvrez le terminal de pointage (PIN, QR code).',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: WilooTokens.space16),
            OutlinedButton.icon(
              key: const Key('timeclock_open_button'),
              onPressed: () => context.push(AppRoute.terminal.path),
              icon: const Icon(Icons.open_in_new),
              label: const Text('Ouvrir le terminal'),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Coming soon ────────────────────────────────────────────────────────────────

const _comingSoonItems = [
  (Icons.badge_outlined, 'Employés', 'Gestion des dossiers et contrats.'),
  (
    Icons.access_time_outlined,
    'Présences',
    'Pointages et suivi du temps de travail.',
  ),
  (Icons.payments_outlined, 'Paie', 'Bulletins de salaire et virements.'),
  (Icons.beach_access_outlined, 'Congés', 'Demandes, soldes et planification.'),
];

class _ComingSoonList extends StatelessWidget {
  const _ComingSoonList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final (icon, title, subtitle) in _comingSoonItems)
          _ComingSoonTile(
            key: Key('coming_soon_$title'),
            icon: icon,
            title: title,
            subtitle: subtitle,
          ),
      ],
    );
  }
}

class _ComingSoonGrid extends StatelessWidget {
  const _ComingSoonGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: WilooTokens.space12,
      runSpacing: WilooTokens.space12,
      children: [
        for (final (icon, title, subtitle) in _comingSoonItems)
          SizedBox(
            width: 260,
            child: _ComingSoonTile(
              key: Key('coming_soon_$title'),
              icon: icon,
              title: title,
              subtitle: subtitle,
            ),
          ),
      ],
    );
  }
}

class _ComingSoonTile extends StatelessWidget {
  const _ComingSoonTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      elevation: 0,
      color: cs.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(WilooTokens.radiusSm),
        side: BorderSide(color: cs.outlineVariant),
      ),
      margin: const EdgeInsets.only(bottom: WilooTokens.space8),
      child: ListTile(
        leading: Icon(icon, color: cs.onSurfaceVariant),
        title: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: cs.onSurfaceVariant),
        ),
        subtitle: Text(
          subtitle,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
        ),
        trailing: Chip(
          visualDensity: VisualDensity.compact,
          side: BorderSide.none,
          backgroundColor: cs.surfaceContainerHighest,
          label: Text(
            'Bientôt',
            style: Theme.of(
              context,
            ).textTheme.labelSmall?.copyWith(color: cs.onSurfaceVariant),
          ),
        ),
      ),
    );
  }
}

// ── Helpers ────────────────────────────────────────────────────────────────────

String _roleLabel(UserRole role) => switch (role) {
  UserRole.admin => 'Administrateur',
  UserRole.hr => 'RH',
  UserRole.manager => 'Manager',
  UserRole.supervisor => 'Superviseur',
  UserRole.employee => 'Employé',
  UserRole.timeTerminal => 'Terminal',
};

IconData _roleIcon(UserRole role) => switch (role) {
  UserRole.admin => Icons.admin_panel_settings_outlined,
  UserRole.hr => Icons.people_outline,
  UserRole.manager => Icons.manage_accounts_outlined,
  UserRole.supervisor => Icons.supervisor_account_outlined,
  UserRole.employee => Icons.badge_outlined,
  UserRole.timeTerminal => Icons.terminal_outlined,
};
