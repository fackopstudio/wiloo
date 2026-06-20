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
/// Provides the top app bar (Wiloo title, current role, logout) and a
/// responsive navigation surface (a [NavigationRail] on wide layouts, a bottom
/// [NavigationBar] on narrow layouts). Navigation items are role-aware for
/// display only; the centralized router redirect and the backend remain the
/// source of truth for authorization.
class BackofficeShell extends ConsumerWidget {
  const BackofficeShell({required this.location, required this.child, super.key});

  /// Current router location, used to highlight the active destination.
  final String location;
  final Widget child;

  static const double _railBreakpoint = 720;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionControllerProvider);
    final access = ComplianceAccess.forRole(session.role);
    final entries = _navEntries(access);
    final selectedIndex = _selectedIndex(entries);

    final isWide = MediaQuery.sizeOf(context).width >= _railBreakpoint;

    void onSelected(int index) => _onDestinationSelected(context, entries, index);

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
                  label: Text(_roleLabel(session.role!)),
                ),
              ),
            ),
          IconButton(
            key: const Key('backoffice_logout_button'),
            tooltip: 'Déconnexion',
            icon: const Icon(Icons.logout),
            onPressed: () =>
                ref.read(sessionManagerProvider.notifier).logout(),
          ),
        ],
      ),
      body: isWide
          ? Row(
              children: [
                NavigationRail(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: onSelected,
                  labelType: NavigationRailLabelType.all,
                  destinations: [
                    for (final entry in entries)
                      NavigationRailDestination(
                        icon: Icon(entry.icon),
                        selectedIcon: Icon(entry.selectedIcon),
                        label: Text(entry.label),
                      ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(child: child),
              ],
            )
          : child,
      bottomNavigationBar: isWide
          ? null
          : NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: onSelected,
              destinations: [
                for (final entry in entries)
                  NavigationDestination(
                    icon: Icon(entry.icon),
                    selectedIcon: Icon(entry.selectedIcon),
                    label: entry.shortLabel,
                  ),
              ],
            ),
    );
  }

  List<_NavEntry> _navEntries(ComplianceAccess access) {
    return [
      const _NavEntry(
        icon: Icons.dashboard_outlined,
        selectedIcon: Icons.dashboard,
        label: 'Tableau de bord',
        shortLabel: 'Accueil',
        routePath: '/backoffice/dashboard',
      ),
      if (access.canView)
        _NavEntry(
          icon: Icons.fact_check_outlined,
          selectedIcon: Icons.fact_check,
          label: access.isReadOnly ? 'Conformité (lecture)' : 'Conformité',
          shortLabel: 'Conformité',
          routePath: AppRoute.compliance.path,
          pushRoute: true,
        ),
      const _NavEntry(
        icon: Icons.badge_outlined,
        selectedIcon: Icons.badge,
        label: 'Employés',
        shortLabel: 'Employés',
        comingSoon: true,
      ),
      const _NavEntry(
        icon: Icons.access_time_outlined,
        selectedIcon: Icons.access_time_filled,
        label: 'Présences',
        shortLabel: 'Présences',
        comingSoon: true,
      ),
      const _NavEntry(
        icon: Icons.payments_outlined,
        selectedIcon: Icons.payments,
        label: 'Paie',
        shortLabel: 'Paie',
        comingSoon: true,
      ),
    ];
  }

  int _selectedIndex(List<_NavEntry> entries) {
    for (var i = 0; i < entries.length; i++) {
      final path = entries[i].routePath;
      if (path != null && !entries[i].pushRoute && location == path) {
        return i;
      }
    }
    // The shell only persists for in-shell routes (the dashboard); other
    // entries either push a separate branch or are not yet available.
    return 0;
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
          SnackBar(content: Text('${entry.label} — bientôt disponible')),
        );
      return;
    }

    if (entry.pushRoute) {
      context.push(entry.routePath!);
    } else {
      context.go(entry.routePath!);
    }
  }
}

class _NavEntry {
  const _NavEntry({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.shortLabel,
    this.routePath,
    this.pushRoute = false,
    this.comingSoon = false,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String shortLabel;
  final String? routePath;
  final bool pushRoute;
  final bool comingSoon;
}

String _roleLabel(UserRole role) => switch (role) {
  UserRole.admin => 'Administrateur',
  UserRole.hr => 'RH',
  UserRole.manager => 'Manager',
  UserRole.supervisor => 'Superviseur',
  UserRole.employee => 'Employé',
  UserRole.timeTerminal => 'Terminal',
};
