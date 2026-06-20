import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:wiloo/app/router/app_routes.dart';
import 'package:wiloo/app/router/compliance_route_guard.dart';
import 'package:wiloo/core/error/failure.dart';
import 'package:wiloo/features/auth/application/session_controller.dart';
import 'package:wiloo/features/auth/domain/session_snapshot.dart';
import 'package:wiloo/features/auth/domain/user_role.dart';
import 'package:wiloo/features/compliance/domain/entities/declaration_export.dart';
import 'package:wiloo/features/compliance/domain/entities/declaration_line.dart';
import 'package:wiloo/features/compliance/domain/entities/declaration_period.dart';
import 'package:wiloo/features/compliance/domain/entities/social_fiscal_declaration.dart';
import 'package:wiloo/features/compliance/domain/enums/declaration_status.dart';
import 'package:wiloo/features/compliance/domain/enums/declaration_type.dart';
import 'package:wiloo/features/compliance/domain/enums/export_format.dart';
import 'package:wiloo/features/compliance/domain/enums/period_type.dart';
import 'package:wiloo/features/compliance/domain/repositories/compliance_repository.dart';
import 'package:wiloo/features/compliance/domain/value_objects/compliance_requests.dart';
import 'package:wiloo/features/compliance/domain/value_objects/declaration_download_result.dart';
import 'package:wiloo/features/compliance/domain/value_objects/money_amount.dart';
import 'package:wiloo/features/compliance/presentation/pages/declaration_detail_page.dart';
import 'package:wiloo/features/compliance/presentation/pages/declaration_export_page.dart';
import 'package:wiloo/features/compliance/presentation/pages/declaration_generate_page.dart';
import 'package:wiloo/features/compliance/presentation/pages/declaration_periods_page.dart';
import 'package:wiloo/features/compliance/presentation/providers/compliance_providers.dart';

void main() {
  group('role-based Compliance UI', () {
    for (final role in [UserRole.admin, UserRole.hr]) {
      testWidgets('${role.apiValue} sees write actions', (tester) async {
        await tester.pumpWidget(
          _testApp(
            role: role,
            repository: _FakeComplianceRepository(
              declaration: _declaration(status: DeclarationStatus.draft),
            ),
            child: const DeclarationPeriodsPage(),
          ),
        );
        await tester.pumpAndSettle();

        expect(
          find.widgetWithText(FloatingActionButton, 'Nouvelle période'),
          findsOneWidget,
        );

        await tester.pumpWidget(
          _testApp(
            role: role,
            repository: _FakeComplianceRepository(
              declaration: _declaration(status: DeclarationStatus.draft),
            ),
            child: const DeclarationGeneratePage(),
          ),
        );
        await tester.pumpAndSettle();
        expect(find.text('CNSS'), findsOneWidget);

        await tester.pumpWidget(
          _testApp(
            role: role,
            repository: _FakeComplianceRepository(
              declaration: _declaration(
                status: DeclarationStatus.readyToReview,
              ),
            ),
            child: const DeclarationDetailPage(declarationId: 'decl-1'),
          ),
        );
        await tester.pumpAndSettle();

        await _scrollToActions(tester);
        expect(find.text('Valider'), findsOneWidget);
        expect(find.text('Exporter'), findsOneWidget);
        expect(find.text('Archiver'), findsOneWidget);
      });
    }

    testWidgets('manager sees read-only UI and no write actions', (
      tester,
    ) async {
      final repository = _FakeComplianceRepository(periods: const []);

      await tester.pumpWidget(
        _testApp(
          role: UserRole.manager,
          repository: repository,
          child: const DeclarationPeriodsPage(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Consultation uniquement'), findsOneWidget);
      expect(find.text('Créer une période'), findsNothing);
      expect(find.byType(FloatingActionButton), findsNothing);
    });

    test('employee cannot access Compliance routes', () {
      final redirect = complianceRouteRedirect(
        location: AppRoute.compliance.path,
        session: const SessionSnapshot(
          isAuthenticated: true,
          role: UserRole.employee,
        ),
      );

      expect(redirect, AppRoute.unauthorized.path);
    });
  });

  group('DeclarationGeneratePage', () {
    testWidgets('CNSS, CNAMGS and IRPP can be selected while IS is disabled', (
      tester,
    ) async {
      await tester.pumpWidget(
        _testApp(
          role: UserRole.admin,
          repository: _FakeComplianceRepository(),
          child: const DeclarationGeneratePage(),
        ),
      );
      await tester.pumpAndSettle();

      for (final label in ['CNSS', 'CNAMGS', 'IRPP']) {
        await tester.tap(find.text(label));
        await tester.pumpAndSettle();
        expect(find.textContaining('type $label'), findsOneWidget);
      }

      expect(find.text('IS – non disponible'), findsOneWidget);
      expect(
        find.text('Type IS non disponible dans cette version.'),
        findsOneWidget,
      );
    });

    testWidgets(
      'generate calls controller with expected DTO and shows success',
      (tester) async {
        final repository = _FakeComplianceRepository(
          generatedDeclaration: _declaration(
            status: DeclarationStatus.draft,
            type: DeclarationType.cnss,
          ),
        );

        await tester.pumpWidget(
          _testApp(
            role: UserRole.admin,
            repository: repository,
            child: const DeclarationGeneratePage(),
          ),
        );
        await tester.pumpAndSettle();

        await _selectFirstDropdownItem(tester, 'Mensuelle M6');
        await tester.tap(find.text('CNSS'));
        await tester.pumpAndSettle();

        final generateButton = find.widgetWithText(
          FilledButton,
          'Générer la déclaration préparatoire',
        );
        await tester.ensureVisible(generateButton);
        await tester.tap(generateButton);
        await tester.pumpAndSettle();

        expect(repository.generatedRequest, isNotNull);
        expect(repository.generatedRequest!.declarationPeriodId, 'period-1');
        expect(repository.generatedRequest!.type, DeclarationType.cnss);
        expect(
          find.textContaining('Déclaration préparatoire CNSS générée'),
          findsOneWidget,
        );
        expect(find.text('Detail decl-1'), findsOneWidget);
      },
    );

    testWidgets('generate error displays user-friendly message', (
      tester,
    ) async {
      await tester.pumpWidget(
        _testApp(
          role: UserRole.admin,
          repository: _FakeComplianceRepository(
            generateFailure: const Failure.forbidden(),
          ),
          child: const DeclarationGeneratePage(),
        ),
      );
      await tester.pumpAndSettle();

      await _selectFirstDropdownItem(tester, 'Mensuelle M6');
      await tester.tap(find.text('CNSS'));
      await tester.pumpAndSettle();
      await _tapVisible(
        tester,
        find.widgetWithText(
          FilledButton,
          'Générer la déclaration préparatoire',
        ),
      );

      expect(find.textContaining('Accès refusé'), findsOneWidget);
    });
  });

  group('DeclarationDetailPage', () {
    testWidgets('lines section is displayed when lines exist', (tester) async {
      await tester.pumpWidget(
        _testApp(
          role: UserRole.admin,
          repository: _FakeComplianceRepository(
            declaration: _declaration(lines: [_declarationLine()]),
          ),
          child: const DeclarationDetailPage(declarationId: 'decl-1'),
        ),
      );
      await tester.pumpAndSettle();

      await _scrollToDeclarationLines(tester);

      expect(find.text('Lignes de déclaration'), findsOneWidget);
      expect(find.text('Smoke Employee'), findsOneWidget);
      expect(find.textContaining('Référence : emp-1'), findsOneWidget);
      expect(find.textContaining('smoke.employee@wiloo.test'), findsOneWidget);
    });

    testWidgets('empty state is displayed when no lines exist', (tester) async {
      await tester.pumpWidget(
        _testApp(
          role: UserRole.admin,
          repository: _FakeComplianceRepository(
            declaration: _declaration(lines: const []),
          ),
          child: const DeclarationDetailPage(declarationId: 'decl-1'),
        ),
      );
      await tester.pumpAndSettle();

      await _scrollToDeclarationLines(tester);

      expect(find.text('Lignes de déclaration'), findsOneWidget);
      expect(
        find.textContaining('Aucune ligne de déclaration retournée'),
        findsOneWidget,
      );
    });

    testWidgets('MoneyAmount display values are rendered as-is', (
      tester,
    ) async {
      await tester.pumpWidget(
        _testApp(
          role: UserRole.admin,
          repository: _FakeComplianceRepository(
            declaration: _declaration(
              lines: [
                _declarationLine(
                  grossSalary: '450000.00',
                  taxableSalary: '399999.50',
                  employeeContributionAmount: '12345.67',
                  withholdingAmount: '7654.32',
                ),
              ],
            ),
          ),
          child: const DeclarationDetailPage(declarationId: 'decl-1'),
        ),
      );
      await tester.pumpAndSettle();

      await _scrollToDeclarationLines(tester);

      expect(find.text('450000.00'), findsOneWidget);
      expect(find.text('399999.50'), findsOneWidget);
      expect(find.text('12345.67'), findsOneWidget);
      expect(find.text('7654.32'), findsOneWidget);
    });

    testWidgets('warnings attached to lines are visible if available', (
      tester,
    ) async {
      await tester.pumpWidget(
        _testApp(
          role: UserRole.admin,
          repository: _FakeComplianceRepository(
            declaration: _declaration(
              lines: [
                _declarationLine(
                  warnings: const ['Missing validated payroll for employee.'],
                ),
              ],
            ),
          ),
          child: const DeclarationDetailPage(declarationId: 'decl-1'),
        ),
      );
      await tester.pumpAndSettle();

      await _scrollToDeclarationLines(tester);

      expect(find.text('Anomalies ligne'), findsOneWidget);
      expect(
        find.textContaining('Missing validated payroll for employee.'),
        findsOneWidget,
      );
    });

    testWidgets('action buttons follow declaration transitions', (
      tester,
    ) async {
      await _pumpDetail(tester, status: DeclarationStatus.draft);
      await _scrollToActions(tester);
      expect(find.text('Marquer prêt'), findsOneWidget);
      expect(find.text('Valider'), findsNothing);
      expect(find.text('Exporter'), findsNothing);

      await _pumpDetail(tester, status: DeclarationStatus.readyToReview);
      await _scrollToActions(tester);
      expect(find.text('Marquer prêt'), findsNothing);
      expect(find.text('Valider'), findsOneWidget);
      expect(find.text('Exporter'), findsOneWidget);

      await _pumpDetail(tester, status: DeclarationStatus.validated);
      await _scrollToActions(tester);
      expect(find.text('Exporter'), findsOneWidget);
      expect(find.text('Transmis manuellement'), findsOneWidget);

      await _pumpDetail(tester, status: DeclarationStatus.exported);
      await _scrollToActions(tester);
      expect(find.text('Exporter'), findsOneWidget);
      expect(find.text('Transmis manuellement'), findsOneWidget);
    });

    testWidgets('archive requires confirmation before calling controller', (
      tester,
    ) async {
      final repository = _FakeComplianceRepository(
        declaration: _declaration(status: DeclarationStatus.validated),
      );

      await tester.pumpWidget(
        _testApp(
          role: UserRole.admin,
          repository: repository,
          child: const DeclarationDetailPage(declarationId: 'decl-1'),
        ),
      );
      await tester.pumpAndSettle();

      await _scrollToActions(tester);
      await _tapVisible(tester, find.widgetWithText(TextButton, 'Archiver'));
      await tester.pumpAndSettle();
      expect(repository.archivedId, isNull);

      await tester.tap(find.widgetWithText(FilledButton, 'Archiver'));
      await tester.pumpAndSettle();

      expect(repository.archivedId, 'decl-1');
    });

    testWidgets('400 invalid transition is displayed clearly', (tester) async {
      await tester.pumpWidget(
        _testApp(
          role: UserRole.admin,
          repository: _FakeComplianceRepository(
            declaration: _declaration(status: DeclarationStatus.draft),
            markReadyFailure: const Failure.invalidStateTransition(),
          ),
          child: const DeclarationDetailPage(declarationId: 'decl-1'),
        ),
      );
      await tester.pumpAndSettle();

      await _scrollToActions(tester);
      await _tapVisible(
        tester,
        find.widgetWithText(OutlinedButton, 'Marquer prêt'),
      );

      expect(
        find.textContaining("Action impossible dans l'état actuel"),
        findsOneWidget,
      );
    });

    testWidgets('403 forbidden displays access denied', (tester) async {
      await tester.pumpWidget(
        _testApp(
          role: UserRole.admin,
          repository: _FakeComplianceRepository(
            declaration: _declaration(status: DeclarationStatus.readyToReview),
            validateFailure: const Failure.forbidden(),
          ),
          child: const DeclarationDetailPage(declarationId: 'decl-1'),
        ),
      );
      await tester.pumpAndSettle();

      await _scrollToActions(tester);
      await _tapVisible(tester, find.widgetWithText(FilledButton, 'Valider'));
      await tester.tap(find.widgetWithText(FilledButton, 'Valider').last);
      await tester.pumpAndSettle();

      expect(find.textContaining('Accès refusé'), findsOneWidget);
    });
  });

  group('DeclarationExportPage', () {
    testWidgets(
      'PDF, EXCEL and CSV selection works and export calls controller',
      (tester) async {
        final repository = _FakeComplianceRepository(
          declaration: _declaration(status: DeclarationStatus.validated),
        );

        await tester.pumpWidget(
          _testApp(
            role: UserRole.admin,
            repository: repository,
            child: const DeclarationExportPage(declarationId: 'decl-1'),
          ),
        );
        await tester.pumpAndSettle();

        await _tapVisible(tester, find.text('Excel (.xlsx)'));
        await _tapVisible(
          tester,
          find.widgetWithText(FilledButton, 'Générer le document préparatoire'),
        );
        await tester.pumpAndSettle();
        expect(repository.exportedFormat, ExportFormat.excel);

        await _tapVisible(tester, find.text('CSV'));
        await _tapVisible(
          tester,
          find.widgetWithText(FilledButton, 'Générer le document préparatoire'),
        );
        await tester.pumpAndSettle();
        expect(repository.exportedFormat, ExportFormat.csv);
      },
    );

    testWidgets('binary download success displays filename and content type', (
      tester,
    ) async {
      final repository = _FakeComplianceRepository(
        declaration: _declaration(status: DeclarationStatus.validated),
        export: const DeclarationExport(raw: {'id': 'export-1'}),
      );

      await tester.pumpWidget(
        _testApp(
          role: UserRole.admin,
          repository: repository,
          child: const DeclarationExportPage(declarationId: 'decl-1'),
        ),
      );
      await tester.pumpAndSettle();

      await _tapVisible(
        tester,
        find.widgetWithText(FilledButton, 'Générer le document préparatoire'),
      );
      await tester.pumpAndSettle();
      await _tapVisible(
        tester,
        find.widgetWithText(OutlinedButton, 'Télécharger'),
      );
      await tester.pumpAndSettle();

      expect(repository.downloadedExportId, 'export-1');
      expect(find.textContaining('declaration.pdf'), findsOneWidget);
      expect(find.textContaining('application/pdf'), findsOneWidget);
    });

    testWidgets('composite export payload enables download', (tester) async {
      final repository = _FakeComplianceRepository(
        declaration: _declaration(status: DeclarationStatus.validated),
        export: const DeclarationExport(
          raw: {
            'declaration': {'id': 'decl-1'},
            'export': {'id': 'export-99', 'format': 'PDF'},
            'download': {
              'exportId': 'export-99',
              'mimeType': 'application/pdf',
            },
          },
        ),
      );

      await tester.pumpWidget(
        _testApp(
          role: UserRole.admin,
          repository: repository,
          child: const DeclarationExportPage(declarationId: 'decl-1'),
        ),
      );
      await tester.pumpAndSettle();

      await _tapVisible(
        tester,
        find.widgetWithText(FilledButton, 'Générer le document préparatoire'),
      );
      await tester.pumpAndSettle();
      await _tapVisible(
        tester,
        find.widgetWithText(OutlinedButton, 'Télécharger'),
      );
      await tester.pumpAndSettle();

      expect(repository.downloadedExportId, 'export-99');
      expect(find.textContaining('Export ID : export-99'), findsOneWidget);
    });

    testWidgets('missing exportId shows fallback message', (tester) async {
      await tester.pumpWidget(
        _testApp(
          role: UserRole.admin,
          repository: _FakeComplianceRepository(
            declaration: _declaration(status: DeclarationStatus.validated),
            export: const DeclarationExport(raw: {'storageKey': 'file-key'}),
          ),
          child: const DeclarationExportPage(declarationId: 'decl-1'),
        ),
      );
      await tester.pumpAndSettle();

      await _tapVisible(
        tester,
        find.widgetWithText(FilledButton, 'Générer le document préparatoire'),
      );
      await tester.pumpAndSettle();

      expect(
        find.textContaining("l'identifiant de téléchargement"),
        findsOneWidget,
      );
      expect(find.textContaining('Identifiant indisponible'), findsOneWidget);
    });
  });

  group('DeclarationPeriodsPage', () {
    for (final role in [UserRole.admin, UserRole.hr]) {
      testWidgets('${role.apiValue} can create a period', (tester) async {
        final repository = _FakeComplianceRepository(periods: const []);

        await tester.pumpWidget(
          _testApp(
            role: role,
            repository: repository,
            child: const DeclarationPeriodsPage(),
          ),
        );
        await tester.pumpAndSettle();

        await tester.tap(
          find.widgetWithText(FilledButton, 'Créer une période'),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.widgetWithText(FilledButton, 'Créer'));
        await tester.pumpAndSettle();

        expect(repository.createdPeriodRequest, isNotNull);
        expect(repository.createdPeriodRequest!.periodType, PeriodType.monthly);
      });
    }

    testWidgets('loading state renders correctly', (tester) async {
      await tester.pumpWidget(
        _testApp(
          role: UserRole.admin,
          repository: _FakeComplianceRepository(
            getPeriodsCompleter: Completer<List<DeclarationPeriod>>(),
          ),
          child: const DeclarationPeriodsPage(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('empty state renders correctly', (tester) async {
      await tester.pumpWidget(
        _testApp(
          role: UserRole.manager,
          repository: _FakeComplianceRepository(periods: const []),
          child: const DeclarationPeriodsPage(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Aucune période déclarative.'), findsOneWidget);
    });

    testWidgets('error state renders correctly', (tester) async {
      await tester.pumpWidget(
        _testApp(
          role: UserRole.admin,
          repository: _FakeComplianceRepository(
            getPeriodsFailure: const Failure.network(),
          ),
          child: const DeclarationPeriodsPage(),
        ),
      );
      await tester.pumpAndSettle();

      expect(
        find.textContaining('Connexion au serveur impossible'),
        findsOneWidget,
      );
    });
  });
}

Widget _testApp({
  required UserRole role,
  required ComplianceRepository repository,
  required Widget child,
}) {
  final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (_, _) => child),
      GoRoute(
        path: '/detail/:declarationId',
        name: AppRoute.complianceDeclarationDetail.name,
        builder: (_, state) => Scaffold(
          body: Text('Detail ${state.pathParameters['declarationId'] ?? ''}'),
        ),
      ),
      GoRoute(
        path: '/export/:declarationId',
        name: AppRoute.complianceExport.name,
        builder: (_, state) => Scaffold(
          body: Text('Export ${state.pathParameters['declarationId'] ?? ''}'),
        ),
      ),
    ],
  );

  return ProviderScope(
    overrides: [
      sessionControllerProvider.overrideWithValue(
        SessionSnapshot(isAuthenticated: true, role: role),
      ),
      complianceRepositoryProvider.overrideWithValue(repository),
    ],
    child: MaterialApp.router(routerConfig: router),
  );
}

Future<void> _pumpDetail(
  WidgetTester tester, {
  required DeclarationStatus status,
}) async {
  await tester.pumpWidget(
    _testApp(
      role: UserRole.admin,
      repository: _FakeComplianceRepository(
        declaration: _declaration(status: status),
      ),
      child: const DeclarationDetailPage(declarationId: 'decl-1'),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _selectFirstDropdownItem(
  WidgetTester tester,
  String labelContains,
) async {
  await tester.tap(find.byType(DropdownButtonFormField<String>));
  await tester.pumpAndSettle();
  await tester.tap(find.textContaining(labelContains).last);
  await tester.pumpAndSettle();
}

Future<void> _tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _scrollToActions(WidgetTester tester) async {
  await tester.scrollUntilVisible(
    find.text('Actions'),
    200,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pumpAndSettle();
}

Future<void> _scrollToDeclarationLines(WidgetTester tester) async {
  await tester.scrollUntilVisible(
    find.text('Lignes de déclaration'),
    200,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pumpAndSettle();
}

class _FakeComplianceRepository implements ComplianceRepository {
  _FakeComplianceRepository({
    List<DeclarationPeriod>? periods,
    SocialFiscalDeclaration? declaration,
    SocialFiscalDeclaration? generatedDeclaration,
    DeclarationExport? export,
    this.getPeriodsFailure,
    this.generateFailure,
    this.markReadyFailure,
    this.validateFailure,
    this.getPeriodsCompleter,
  }) : periods = periods ?? [_period],
       declaration = declaration ?? _declaration(),
       generatedDeclaration =
           generatedDeclaration ?? declaration ?? _declaration(),
       export = export ?? const DeclarationExport(raw: {'id': 'export-1'});

  final List<DeclarationPeriod> periods;
  final SocialFiscalDeclaration declaration;
  final SocialFiscalDeclaration generatedDeclaration;
  final DeclarationExport export;
  final Object? getPeriodsFailure;
  final Object? generateFailure;
  final Object? markReadyFailure;
  final Object? validateFailure;
  final Completer<List<DeclarationPeriod>>? getPeriodsCompleter;

  CreateDeclarationPeriodRequest? createdPeriodRequest;
  GenerateDeclarationRequest? generatedRequest;
  String? markReadyId;
  String? validatedId;
  ExportFormat? exportedFormat;
  String? downloadedExportId;
  String? archivedId;

  @override
  Future<List<DeclarationPeriod>> getPeriods(
    ListDeclarationPeriodsQuery query,
  ) async {
    if (getPeriodsFailure != null) {
      throw getPeriodsFailure!;
    }
    if (getPeriodsCompleter != null) {
      return getPeriodsCompleter!.future;
    }
    return periods;
  }

  @override
  Future<DeclarationPeriod> createPeriod(
    CreateDeclarationPeriodRequest request,
  ) async {
    createdPeriodRequest = request;
    return DeclarationPeriod(
      id: 'period-created',
      tenantId: 'tenant-1',
      periodType: request.periodType,
      year: request.year,
      month: request.month,
      quarter: request.quarter,
      startDate: request.startDate,
      endDate: request.endDate,
      payrollMonth: request.payrollMonth,
      payrollYear: request.payrollYear,
      status: DeclarationStatus.draft,
      createdAt: _now,
      updatedAt: _now,
    );
  }

  @override
  Future<List<SocialFiscalDeclaration>> getDeclarations(
    ListDeclarationsQuery query,
  ) async {
    return [declaration];
  }

  @override
  Future<SocialFiscalDeclaration> generateDeclaration(
    GenerateDeclarationRequest request,
  ) async {
    generatedRequest = request;
    if (generateFailure != null) {
      throw generateFailure!;
    }
    return generatedDeclaration;
  }

  @override
  Future<SocialFiscalDeclaration> getDeclaration(String id) async {
    return declaration;
  }

  @override
  Future<SocialFiscalDeclaration> markReady(String id) async {
    markReadyId = id;
    if (markReadyFailure != null) {
      throw markReadyFailure!;
    }
    return declaration;
  }

  @override
  Future<SocialFiscalDeclaration> validateDeclaration(String id) async {
    validatedId = id;
    if (validateFailure != null) {
      throw validateFailure!;
    }
    return declaration;
  }

  @override
  Future<DeclarationExport> exportDeclaration(
    String id,
    ExportDeclarationRequest request,
  ) async {
    exportedFormat = request.format;
    return export;
  }

  @override
  Future<DeclarationDownloadResult> downloadExport(
    String id,
    String exportId,
  ) async {
    downloadedExportId = exportId;
    return const DeclarationDownloadResult(
      bytes: [1, 2, 3],
      fileName: 'declaration.pdf',
      contentType: 'application/pdf',
    );
  }

  @override
  Future<SocialFiscalDeclaration> markSubmitted(
    String id,
    MarkSubmittedDeclarationRequest request,
  ) async {
    return declaration;
  }

  @override
  Future<SocialFiscalDeclaration> archiveDeclaration(
    String id,
    ArchiveDeclarationRequest request,
  ) async {
    archivedId = id;
    return declaration;
  }
}

final _period = DeclarationPeriod(
  id: 'period-1',
  tenantId: 'tenant-1',
  periodType: PeriodType.monthly,
  year: 2026,
  month: 6,
  startDate: _start,
  endDate: _end,
  status: DeclarationStatus.draft,
  createdAt: _now,
  updatedAt: _now,
);

SocialFiscalDeclaration _declaration({
  DeclarationStatus status = DeclarationStatus.readyToReview,
  DeclarationType type = DeclarationType.cnss,
  List<DeclarationLine>? lines,
}) {
  return SocialFiscalDeclaration(
    id: 'decl-1',
    tenantId: 'tenant-1',
    declarationPeriodId: 'period-1',
    type: type,
    status: status,
    totalGrossSalary: MoneyAmount.fromApi('1000'),
    totalTaxableBase: MoneyAmount.fromApi('900'),
    totalEmployeeContributions: MoneyAmount.fromApi('100'),
    totalEmployerContributions: MoneyAmount.fromApi('150'),
    totalWithholdings: MoneyAmount.fromApi('50'),
    lines: lines,
    createdAt: _now,
    updatedAt: _now,
  );
}

DeclarationLine _declarationLine({
  String grossSalary = '1000.00',
  String taxableSalary = '900.00',
  String socialContributionBase = '850.00',
  String employeeContributionAmount = '100.00',
  String employerContributionAmount = '150.00',
  String withholdingAmount = '50.00',
  List<String>? warnings,
}) {
  return DeclarationLine(
    raw: const {'id': 'line-1'},
    id: 'line-1',
    employeeId: 'emp-1',
    userId: 'user-1',
    employeeSnapshot: const {
      'name': 'Smoke Employee',
      'email': 'smoke.employee@wiloo.test',
      'employeeId': 'emp-1',
    },
    grossSalary: MoneyAmount.fromApi(grossSalary),
    taxableSalary: MoneyAmount.fromApi(taxableSalary),
    socialContributionBase: MoneyAmount.fromApi(socialContributionBase),
    employeeContributionAmount: MoneyAmount.fromApi(employeeContributionAmount),
    employerContributionAmount: MoneyAmount.fromApi(employerContributionAmount),
    withholdingAmount: MoneyAmount.fromApi(withholdingAmount),
    warnings: warnings,
  );
}

final _start = DateTime(2026, 6);
final _end = DateTime(2026, 6, 30);
final _now = DateTime(2026, 6, 12);
