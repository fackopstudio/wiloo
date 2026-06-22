import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/application/session_controller.dart';
import '../../features/auth/domain/user_role.dart';
import '../../features/compliance/domain/value_objects/compliance_access.dart';
import '../../shared/widgets/wiloo_logo.dart';
import '../router/app_routes.dart';

/// Reusable shell for authenticated backoffice routes.
///
/// Provides:
/// - Top app bar with the Wiloo logo, current-role chip and logout.
/// - Responsive navigation: [NavigationRail] on wide layouts (≥720px),
///   [NavigationBar] on narrower layouts.
/// - Role-aware destination list — only destinations the role may access are
///   shown; coming-soon entries display a snack rather than navigating.
///
/// Authorization is enforced by the centralized router and backend; this shell
/// only makes display-level visibility decisions.
class BackofficeShell extends ConsumerWidget {
  const BackofficeShell({
    required this.location,
    required this.child,
    super.key,
  });

  /// Current router location, used to highlight the active destination.
  final String location;
  final Widget child;

  /// Width at which the layout switches from NavigationBar to NavigationRail.
  static const double _railBreakpoint = 720;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionControllerProvider);
    final access = ComplianceAccess.forRole(session.role);
    final entries = _buildEntries(access);
    final selectedIndex = _selectedIndex(entries, location);
    final isWide = MediaQuery.sizeOf(context).width >= _railBreakpoint;

    void onSelected(int index) =>
        _onDestinationSelected(context, entries, index);

    return Scaffold(
      appBar: AppBar(
        title: const WilooLogo(height: 26),
        actions: [
          if (session.role != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Center(
                child: Chip(
                  key: const Key('backoffice_role_chip'),
                  visualDensity: VisualDensity.compact,
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  side: BorderSide.none,
                  label: Text(
                    _roleLabel(session.role!),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          IconButton(
            key: const Key('backoffice_logout_button'),
            tooltip: 'Déconnexion',
            icon: const Icon(Icons.logout_outlined),
            onPressed: () =>
                ref.read(sessionManagerProvider.notifier).logout(),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: isWide
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _WilooNavigationRail(
                  entries: entries,
                  selectedIndex: selectedIndex,
                  onSelected: onSelected,
                ),
                const VerticalDivider(width: 1),
                Expanded(child: child),
              ],
            )
          : child,
      bottomNavigationBar: isWide
          ? null
          : NavigationBar(
              key: const Key('backoffice_navigation_bar'),
              selectedIndex: selectedIndex,
              onDestinationSelected: onSelected,
              destinations: [
                for (final e in entries)
                  NavigationDestination(
                    key: Key('nav_${e.key}'),
                    icon: Icon(e.icon),
                    selectedIcon: Icon(e.selectedIcon),
                    label: e.shortLabel,
                  ),
              ],
            ),
    );
  }

  List<_NavEntry> _buildEntries(ComplianceAccess access) => [
    const _NavEntry(
      key: 'dashboard',
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
      label: 'Tableau de bord',
      shortLabel: 'Accueil',
      routePath: '/backoffice/dashboard',
    ),
    if (access.canView)
      _NavEntry(
        key: 'compliance',
        icon: Icons.fact_check_outlined,
        selectedIcon: Icons.fact_check,
        label: access.isReadOnly ? 'Conformité (lecture)' : 'Conformité',
        shortLabel: 'Conformité',
        routePath: AppRoute.compliance.path,
        useRoutePrefix: true,
      ),
    const _NavEntry(
      key: 'employees',
      icon: Icons.badge_outlined,
      selectedIcon: Icons.badge,
      label: 'Employés',
      shortLabel: 'Employés',
      comingSoon: true,
    ),
    const _NavEntry(
      key: 'attendance',
      icon: Icons.access_time_outlined,
      selectedIcon: Icons.access_time_filled,
      label: 'Présences',
      shortLabel: 'Présences',
      comingSoon: true,
    ),
    const _NavEntry(
      key: 'timeclock',
      icon: Icons.fingerprint_outlined,
      selectedIcon: Icons.fingerprint,
      label: 'Pointage',
      shortLabel: 'Pointage',
      routePath: '/terminal',
      useRoutePrefix: false,
    ),
  ];

  /// Returns the index of the entry whose route matches [location].
  ///
  /// When [_NavEntry.useRoutePrefix] is true the entry is considered active if
  /// [location] starts with its [_NavEntry.routePath]. This handles all
  /// `/compliance/**` sub-routes correctly.
  static int _selectedIndex(List<_NavEntry> entries, String location) {
    for (var i = 0; i < entries.length; i++) {
      final e = entries[i];
      final path = e.routePath;
      if (path == null) continue;
      if (e.useRoutePrefix) {
        if (location == path || location.startsWith('$path/')) return i;
      } else {
        if (location == path) return i;
      }
    }
    return 0; // default to dashboard
  }

  void _onDestinationSelected(
    BuildContext context,
    List<_NavEntry> entries,
    int index,
  ) {
    final entry = entries[index];
    if (entry.comingSoon || entry.routePath == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text('${entry.label} — bientôt disponible'),
          ),
        );
      return;
    }

    // Compliance and Timeclock are separate branches — push so the user can
    // return with the back button without being dropped out of the shell.
    if (entry.useRoutePrefix || entry.routePath == '/terminal') {
      context.push(entry.routePath!);
    } else {
      context.go(entry.routePath!);
    }
  }
}

// ── NavigationRail wrapper ────────────────────────────────────────────────────

class _WilooNavigationRail extends StatelessWidget {
  const _WilooNavigationRail({
    required this.entries,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<_NavEntry> entries;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return NavigationRail(
      key: const Key('backoffice_navigation_rail'),
      selectedIndex: selectedIndex,
      onDestinationSelected: onSelected,
      labelType: NavigationRailLabelType.all,
      backgroundColor: cs.surface,
      indicatorColor: cs.primaryContainer,
      selectedIconTheme: IconThemeData(color: cs.onPrimaryContainer),
      selectedLabelTextStyle: TextStyle(
        color: cs.primary,
        fontWeight: FontWeight.w700,
        fontSize: 12,
      ),
      unselectedIconTheme: IconThemeData(color: cs.onSurfaceVariant),
      unselectedLabelTextStyle: TextStyle(
        color: cs.onSurfaceVariant,
        fontSize: 11,
      ),
      destinations: [
        for (final e in entries)
          NavigationRailDestination(
            icon: Icon(e.icon),
            selectedIcon: Icon(e.selectedIcon),
            label: Text(e.label),
          ),
      ],
    );
  }
}

// ── Data model ────────────────────────────────────────────────────────────────

class _NavEntry {
  const _NavEntry({
    required this.key,
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.shortLabel,
    this.routePath,
    this.useRoutePrefix = false,
    this.comingSoon = false,
  });

  final String key;
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String shortLabel;
  final String? routePath;

  /// When true the destination is active for the route and any sub-routes.
  final bool useRoutePrefix;
  final bool comingSoon;
}

// ── Helpers ───────────────────────────────────────────────────────────────────

String _roleLabel(UserRole role) => switch (role) {
  UserRole.admin => 'Administrateur',
  UserRole.hr => 'RH',
  UserRole.manager => 'Manager',
  UserRole.supervisor => 'Superviseur',
  UserRole.employee => 'Employé',
  UserRole.timeTerminal => 'Terminal',
};
