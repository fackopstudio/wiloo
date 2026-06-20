import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/app_router.dart';
import 'theme/app_theme.dart';

class WilooApp extends ConsumerWidget {
  const WilooApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Wiloo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      // Pin light mode so the brand palette stays identical across devices and
      // simulators regardless of the OS dark/light setting. Dark theme is kept
      // defined for a future, deliberate rollout.
      themeMode: ThemeMode.light,
      routerConfig: router,
    );
  }
}
