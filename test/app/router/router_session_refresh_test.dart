import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/app/router/app_router.dart';
import 'package:wiloo/app/router/app_routes.dart';
import 'package:wiloo/core/auth/auth_core_providers.dart';
import 'package:wiloo/features/auth/application/session_controller.dart';
import 'package:wiloo/features/auth/domain/auth_repository.dart';
import 'package:wiloo/features/auth/domain/auth_user.dart';
import 'package:wiloo/features/auth/domain/session_snapshot.dart';
import 'package:wiloo/features/auth/domain/user_role.dart';
import 'package:wiloo/features/compliance/domain/entities/declaration_export.dart';
import 'package:wiloo/features/compliance/domain/entities/declaration_period.dart';
import 'package:wiloo/features/compliance/domain/entities/social_fiscal_declaration.dart';
import 'package:wiloo/features/compliance/domain/repositories/compliance_repository.dart';
import 'package:wiloo/features/compliance/domain/value_objects/compliance_requests.dart';
import 'package:wiloo/features/compliance/domain/value_objects/declaration_download_result.dart';
import 'package:wiloo/features/compliance/presentation/providers/compliance_providers.dart';

import '../../support/in_memory_token_store.dart';

void main() {
  testWidgets('logout refreshes redirects and bounces compliance to auth',
      (tester) async {
    final repo = _FakeAuthRepository(bootstrap: _adminSnapshot);
    final container = ProviderContainer(
      overrides: [
        sessionTokenStoreProvider.overrideWithValue(InMemoryTokenStore()),
        authRepositoryProvider.overrideWithValue(repo),
        complianceRepositoryProvider.overrideWithValue(_EmptyComplianceRepo()),
      ],
    );
    addTearDown(container.dispose);

    final router = container.read(appRouterProvider);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    // Authenticated admin can reach the compliance dashboard.
    router.go(AppRoute.compliance.path);
    await tester.pumpAndSettle();
    expect(find.text('Conformité sociale et fiscale'), findsOneWidget);

    // Logging out must refresh redirects and bounce away from compliance.
    await container.read(sessionManagerProvider.notifier).logout();
    await tester.pumpAndSettle();

    expect(find.text('Conformité sociale et fiscale'), findsNothing);
    expect(find.text('Connexion'), findsOneWidget);
  });
}

const _adminSnapshot = SessionSnapshot(
  isAuthenticated: true,
  user: AuthUser(id: 'u1', email: 'admin@b.com', role: UserRole.admin),
  role: UserRole.admin,
);

class _FakeAuthRepository implements AuthRepository {
  _FakeAuthRepository({required this.bootstrap});

  final SessionSnapshot bootstrap;

  @override
  Future<SessionSnapshot> bootstrapSession() async => bootstrap;

  @override
  Future<SessionSnapshot> getCurrentSession() async => bootstrap;

  @override
  Future<SessionSnapshot> signIn(String email, String password) async =>
      bootstrap;

  @override
  Future<void> logout() async {}
}

class _EmptyComplianceRepo implements ComplianceRepository {
  @override
  Future<List<DeclarationPeriod>> getPeriods(
    ListDeclarationPeriodsQuery query,
  ) async => const [];

  @override
  Future<List<SocialFiscalDeclaration>> getDeclarations(
    ListDeclarationsQuery query,
  ) async => const [];

  @override
  Future<DeclarationPeriod> createPeriod(
    CreateDeclarationPeriodRequest request,
  ) => throw UnimplementedError();

  @override
  Future<SocialFiscalDeclaration> generateDeclaration(
    GenerateDeclarationRequest request,
  ) => throw UnimplementedError();

  @override
  Future<SocialFiscalDeclaration> getDeclaration(String id) =>
      throw UnimplementedError();

  @override
  Future<SocialFiscalDeclaration> markReady(String id) =>
      throw UnimplementedError();

  @override
  Future<SocialFiscalDeclaration> validateDeclaration(String id) =>
      throw UnimplementedError();

  @override
  Future<DeclarationExport> exportDeclaration(
    String id,
    ExportDeclarationRequest request,
  ) => throw UnimplementedError();

  @override
  Future<DeclarationDownloadResult> downloadExport(String id, String exportId) =>
      throw UnimplementedError();

  @override
  Future<SocialFiscalDeclaration> markSubmitted(
    String id,
    MarkSubmittedDeclarationRequest request,
  ) => throw UnimplementedError();

  @override
  Future<SocialFiscalDeclaration> archiveDeclaration(
    String id,
    ArchiveDeclarationRequest request,
  ) => throw UnimplementedError();
}
