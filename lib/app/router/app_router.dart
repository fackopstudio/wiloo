import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/auth_screen.dart';
import '../../features/employee/presentation/employee_home_screen.dart';
import '../../features/hr_admin/presentation/hr_admin_home_screen.dart';
import '../../features/manager/presentation/manager_home_screen.dart';
import '../../features/timeclock/presentation/timeclock_home_screen.dart';
import 'app_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoute.timeclock.path,
    routes: [
      GoRoute(
        path: AppRoute.auth.path,
        name: AppRoute.auth.name,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: AppRoute.timeclock.path,
        name: AppRoute.timeclock.name,
        builder: (context, state) => const TimeclockHomeScreen(),
      ),
      GoRoute(
        path: AppRoute.employee.path,
        name: AppRoute.employee.name,
        builder: (context, state) => const EmployeeHomeScreen(),
      ),
      GoRoute(
        path: AppRoute.manager.path,
        name: AppRoute.manager.name,
        builder: (context, state) => const ManagerHomeScreen(),
      ),
      GoRoute(
        path: AppRoute.hrAdmin.path,
        name: AppRoute.hrAdmin.name,
        builder: (context, state) => const HrAdminHomeScreen(),
      ),
    ],
  );
});
