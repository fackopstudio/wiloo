import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:wiloo/app/router/app_router.dart';
import 'package:wiloo/app/router/app_routes.dart';
import 'package:wiloo/core/auth/auth_core_providers.dart';
import 'package:wiloo/core/config/app_mode.dart';
import 'package:wiloo/features/auth/application/session_controller.dart';
import 'package:wiloo/features/auth/domain/auth_repository.dart';
import 'package:wiloo/features/auth/domain/session_snapshot.dart';
import 'package:wiloo/features/compliance/domain/entities/declaration_export.dart';
import 'package:wiloo/features/compliance/domain/entities/declaration_period.dart';
import 'package:wiloo/features/compliance/domain/entities/social_fiscal_declaration.dart';
import 'package:wiloo/features/compliance/domain/repositories/compliance_repository.dart';
import 'package:wiloo/features/compliance/domain/value_objects/compliance_requests.dart';
import 'package:wiloo/features/compliance/domain/value_objects/declaration_download_result.dart';
import 'package:wiloo/features/compliance/presentation/providers/compliance_providers.dart';

import '../../support/in_memory_token_store.dart';

void main() {
  testWidgets('backoffice mode starts unauthenticated users on welcome', (
    tester,
  ) async {
    final router = await _pumpApp(tester, mode: AppMode.backoffice);

    expect(
      router.routeInformationProvider.value.uri.path,
      AppRoute.welcome.path,
    );
    expect(find.text('Toute votre RH,\nau même endroit'), findsOneWidget);
    expect(find.text('Terminal de pointage'), findsNothing);
  });

  testWidgets('terminal mode starts on /terminal', (tester) async {
    final router = await _pumpApp(tester, mode: AppMode.terminal);

    expect(
      router.routeInformationProvider.value.uri.path,
      AppRoute.terminal.path,
    );
    expect(find.text('Terminal de pointage'), findsOneWidget);
  });

  testWidgets(
    'terminal mode keeps compliance hidden by bouncing to /terminal',
    (tester) async {
      final router = await _pumpApp(tester, mode: AppMode.terminal);

      router.go(AppRoute.compliance.path);
      await tester.pumpAndSettle();

      expect(
        router.routeInformationProvider.value.uri.path,
        AppRoute.terminal.path,
      );
      expect(find.text('Conformité sociale et fiscale'), findsNothing);
    },
  );
}

Future<GoRouter> _pumpApp(WidgetTester tester, {required AppMode mode}) async {
  final container = ProviderContainer(
    overrides: [
      appModeProvider.overrideWithValue(mode),
      sessionTokenStoreProvider.overrideWithValue(InMemoryTokenStore()),
      authRepositoryProvider.overrideWithValue(_GuestAuthRepository()),
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

  return router;
}

class _GuestAuthRepository implements AuthRepository {
  @override
  Future<SessionSnapshot> bootstrapSession() async =>
      const SessionSnapshot.guest();

  @override
  Future<SessionSnapshot> getCurrentSession() async =>
      const SessionSnapshot.guest();

  @override
  Future<SessionSnapshot> signIn(String email, String password) async =>
      const SessionSnapshot.guest();

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
  Future<DeclarationDownloadResult> downloadExport(
    String id,
    String exportId,
  ) => throw UnimplementedError();

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
