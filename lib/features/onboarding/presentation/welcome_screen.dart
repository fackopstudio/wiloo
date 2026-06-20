import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/app_routes.dart';
import '../../../app/theme/app_theme.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _pageController = PageController();
  var _currentPage = 0;

  static const _pages = [
    _WelcomePageData(
      eyebrow: 'ÉQUIPES',
      title: 'Toute votre RH,\nau même endroit',
      description:
          'Centralisez les collaborateurs, les contrats et les demandes '
          'dans un espace clair.',
      backgroundColor: WilooColors.brand50,
      accentColor: WilooColors.brand,
      visualType: _WelcomeVisualType.people,
    ),
    _WelcomePageData(
      eyebrow: 'TEMPS DE TRAVAIL',
      title: 'Le pointage devient\nsimple et fiable',
      description:
          'Suivez les présences et donnez à chaque équipe une vision '
          'partagée de son activité.',
      backgroundColor: Color(0xFFFFEFE5),
      accentColor: WilooColors.accentOrange,
      visualType: _WelcomeVisualType.time,
    ),
    _WelcomePageData(
      eyebrow: 'CONFORMITÉ',
      title: 'Préparez vos échéances\navec confiance',
      description:
          'Pilotez vos déclarations préparatoires CNSS, CNAMGS et IRPP '
          'sans calcul fiscal dans l’application.',
      backgroundColor: Color(0xFFE6F3E8),
      accentColor: WilooColors.accentGreen,
      visualType: _WelcomeVisualType.compliance,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _selectPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: WilooColors.canvas,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
                  child: Row(
                    children: [
                      Semantics(
                        label: 'Wiloo',
                        image: true,
                        child: Image.asset(
                          'assets/brand/wiloo_logo_horizontal.png',
                          width: 118,
                          height: 36,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '${_currentPage + 1}/${_pages.length}',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: colors.onSurfaceVariant,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    key: const Key('welcome_page_view'),
                    controller: _pageController,
                    itemCount: _pages.length,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemBuilder: (context, index) {
                      return _WelcomePage(data: _pages[index]);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _pages.length,
                      (index) => Semantics(
                        label: 'Afficher la page ${index + 1}',
                        button: true,
                        selected: index == _currentPage,
                        child: InkWell(
                          key: Key('welcome_indicator_$index'),
                          borderRadius: BorderRadius.circular(12),
                          onTap: () => _selectPage(index),
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              width: index == _currentPage ? 28 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: index == _currentPage
                                    ? WilooColors.brand
                                    : WilooColors.neutral300,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 4, 24, 24),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final stackActions = constraints.maxWidth < 300;
                      final signIn = OutlinedButton(
                        key: const Key('welcome_sign_in_button'),
                        onPressed: () => context.go(AppRoute.auth.path),
                        child: const Text('Se connecter'),
                      );
                      final invitation = FilledButton(
                        key: const Key('welcome_invitation_button'),
                        onPressed: () => context.go(AppRoute.register.path),
                        child: const Text('Accès sur invitation'),
                      );

                      if (stackActions) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            invitation,
                            const SizedBox(height: 10),
                            signIn,
                          ],
                        );
                      }

                      return Row(
                        children: [
                          Expanded(child: signIn),
                          const SizedBox(width: 12),
                          Expanded(child: invitation),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _WelcomePage extends StatelessWidget {
  const _WelcomePage({required this.data});

  final _WelcomePageData data;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxHeight < 570;
        final visualHeight = compact ? 210.0 : 300.0;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: visualHeight,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: data.backgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(compact ? 18 : 28),
                      child: _WelcomeVisual(
                        type: data.visualType,
                        accentColor: data.accentColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: compact ? 20 : 28),
                Text(
                  data.eyebrow,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: data.accentColor,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  data.title,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w900,
                    height: 1.08,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  data.description,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}

enum _WelcomeVisualType { people, time, compliance }

class _WelcomeVisual extends StatelessWidget {
  const _WelcomeVisual({required this.type, required this.accentColor});

  final _WelcomeVisualType type;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      _WelcomeVisualType.people => _PeopleVisual(accentColor: accentColor),
      _WelcomeVisualType.time => _TimeVisual(accentColor: accentColor),
      _WelcomeVisualType.compliance => _ComplianceVisual(
        accentColor: accentColor,
      ),
    };
  }
}

class _PeopleVisual extends StatelessWidget {
  const _PeopleVisual({required this.accentColor});

  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: 8,
          top: 18,
          child: _VisualBadge(
            icon: Icons.badge_outlined,
            label: 'Contrats',
            color: WilooColors.accentGreen,
          ),
        ),
        Positioned(
          right: 8,
          top: 48,
          child: _VisualBadge(
            icon: Icons.event_available_outlined,
            label: 'Congés',
            color: WilooColors.accentOrange,
          ),
        ),
        Positioned(
          right: 28,
          bottom: 12,
          child: _VisualBadge(
            icon: Icons.insights_outlined,
            label: 'Suivi',
            color: accentColor,
          ),
        ),
        _LargeVisualIcon(icon: Icons.groups_2_outlined, color: accentColor),
      ],
    );
  }
}

class _TimeVisual extends StatelessWidget {
  const _TimeVisual({required this.accentColor});

  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: 14,
          bottom: 10,
          child: _VisualBadge(
            icon: Icons.qr_code_rounded,
            label: 'QR',
            color: WilooColors.accentTeal,
          ),
        ),
        Positioned(
          right: 12,
          top: 14,
          child: _VisualBadge(
            icon: Icons.verified_outlined,
            label: 'Validé',
            color: WilooColors.accentGreen,
          ),
        ),
        _LargeVisualIcon(icon: Icons.schedule_rounded, color: accentColor),
      ],
    );
  }
}

class _ComplianceVisual extends StatelessWidget {
  const _ComplianceVisual({required this.accentColor});

  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          left: 8,
          top: 16,
          child: _VisualBadge(
            icon: Icons.description_outlined,
            label: 'CNSS',
            color: WilooColors.brand,
          ),
        ),
        Positioned(
          right: 8,
          top: 56,
          child: _VisualBadge(
            icon: Icons.health_and_safety_outlined,
            label: 'CNAMGS',
            color: WilooColors.accentOrange,
          ),
        ),
        Positioned(
          right: 26,
          bottom: 10,
          child: _VisualBadge(
            icon: Icons.receipt_long_outlined,
            label: 'IRPP',
            color: WilooColors.accentPurple,
          ),
        ),
        _LargeVisualIcon(icon: Icons.fact_check_outlined, color: accentColor),
      ],
    );
  }
}

class _LargeVisualIcon extends StatelessWidget {
  const _LargeVisualIcon({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.24), width: 2),
      ),
      child: SizedBox.square(
        dimension: 132,
        child: Icon(icon, size: 68, color: color),
      ),
    );
  }
}

class _VisualBadge extends StatelessWidget {
  const _VisualBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.22)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 19, color: color),
            const SizedBox(width: 7),
            Text(
              label,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: color,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WelcomePageData {
  const _WelcomePageData({
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.backgroundColor,
    required this.accentColor,
    required this.visualType,
  });

  final String eyebrow;
  final String title;
  final String description;
  final Color backgroundColor;
  final Color accentColor;
  final _WelcomeVisualType visualType;
}
