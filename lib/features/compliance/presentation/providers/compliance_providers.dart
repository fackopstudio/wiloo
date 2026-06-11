import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../../auth/application/session_controller.dart';
import '../../data/datasources/compliance_remote_data_source.dart';
import '../../data/repositories/compliance_repository_impl.dart';
import '../../domain/entities/compliance_dashboard_view.dart';
import '../../domain/entities/declaration_export.dart';
import '../../domain/entities/declaration_period.dart';
import '../../domain/entities/social_fiscal_declaration.dart';
import '../../domain/repositories/compliance_repository.dart';
import '../../domain/value_objects/compliance_access.dart';
import '../../domain/value_objects/compliance_requests.dart';
import '../../domain/value_objects/declaration_download_result.dart';

final complianceAccessProvider = Provider<ComplianceAccess>((ref) {
  // UX/display guard only. Backend RBAC remains the source of truth.
  final session = ref.watch(sessionControllerProvider);
  return ComplianceAccess.forRole(session.role);
});

final complianceRemoteDataSourceProvider = Provider<ComplianceRemoteDataSource>(
  (ref) => ComplianceRemoteDataSourceImpl(ref.watch(generalApiClientProvider)),
);

final complianceRepositoryProvider = Provider<ComplianceRepository>((ref) {
  return ComplianceRepositoryImpl(
    ref.watch(complianceRemoteDataSourceProvider),
  );
});

final declarationPeriodsProvider =
    FutureProvider.family<List<DeclarationPeriod>, ListDeclarationPeriodsQuery>(
      (ref, query) {
        return ref.watch(complianceRepositoryProvider).getPeriods(query);
      },
    );

final declarationsProvider =
    FutureProvider.family<List<SocialFiscalDeclaration>, ListDeclarationsQuery>(
      (ref, query) {
        return ref.watch(complianceRepositoryProvider).getDeclarations(query);
      },
    );

final declarationDetailProvider =
    FutureProvider.family<SocialFiscalDeclaration, String>((ref, id) {
      return ref.watch(complianceRepositoryProvider).getDeclaration(id);
    });

final complianceDashboardProvider = FutureProvider<ComplianceDashboardView>((
  ref,
) async {
  final repository = ref.watch(complianceRepositoryProvider);
  final periods = await repository.getPeriods(
    const ListDeclarationPeriodsQuery(),
  );
  final declarations = await repository.getDeclarations(
    const ListDeclarationsQuery(),
  );

  return ComplianceDashboardView(periods: periods, declarations: declarations);
});

final createPeriodControllerProvider =
    AsyncNotifierProvider<CreatePeriodController, DeclarationPeriod?>(
      CreatePeriodController.new,
    );

class CreatePeriodController extends AsyncNotifier<DeclarationPeriod?> {
  @override
  Future<DeclarationPeriod?> build() async => null;

  Future<void> create(CreateDeclarationPeriodRequest request) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final period = await ref
          .read(complianceRepositoryProvider)
          .createPeriod(request);
      ref.invalidate(declarationPeriodsProvider);
      ref.invalidate(complianceDashboardProvider);
      return period;
    });
  }
}

final generateDeclarationControllerProvider =
    AsyncNotifierProvider<
      GenerateDeclarationController,
      SocialFiscalDeclaration?
    >(GenerateDeclarationController.new);

class GenerateDeclarationController
    extends AsyncNotifier<SocialFiscalDeclaration?> {
  @override
  Future<SocialFiscalDeclaration?> build() async => null;

  Future<void> generate(GenerateDeclarationRequest request) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final declaration = await ref
          .read(complianceRepositoryProvider)
          .generateDeclaration(request);
      ref.invalidate(declarationsProvider);
      ref.invalidate(complianceDashboardProvider);
      return declaration;
    });
  }
}

final markReadyControllerProvider =
    AsyncNotifierProvider<MarkReadyController, SocialFiscalDeclaration?>(
      MarkReadyController.new,
    );

class MarkReadyController extends AsyncNotifier<SocialFiscalDeclaration?> {
  @override
  Future<SocialFiscalDeclaration?> build() async => null;

  Future<void> markReady(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final declaration = await ref
          .read(complianceRepositoryProvider)
          .markReady(id);
      ref.invalidate(declarationDetailProvider(id));
      ref.invalidate(declarationsProvider);
      ref.invalidate(complianceDashboardProvider);
      return declaration;
    });
  }
}

final validateDeclarationControllerProvider =
    AsyncNotifierProvider<
      ValidateDeclarationController,
      SocialFiscalDeclaration?
    >(ValidateDeclarationController.new);

class ValidateDeclarationController
    extends AsyncNotifier<SocialFiscalDeclaration?> {
  @override
  Future<SocialFiscalDeclaration?> build() async => null;

  Future<void> validate(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final declaration = await ref
          .read(complianceRepositoryProvider)
          .validateDeclaration(id);
      ref.invalidate(declarationDetailProvider(id));
      ref.invalidate(declarationsProvider);
      ref.invalidate(complianceDashboardProvider);
      return declaration;
    });
  }
}

final exportDeclarationControllerProvider =
    AsyncNotifierProvider<ExportDeclarationController, DeclarationExport?>(
      ExportDeclarationController.new,
    );

class ExportDeclarationController extends AsyncNotifier<DeclarationExport?> {
  @override
  Future<DeclarationExport?> build() async => null;

  Future<void> export(String id, ExportDeclarationRequest request) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final export = await ref
          .read(complianceRepositoryProvider)
          .exportDeclaration(id, request);
      ref.invalidate(declarationDetailProvider(id));
      ref.invalidate(declarationsProvider);
      ref.invalidate(complianceDashboardProvider);
      return export;
    });
  }
}

final downloadExportControllerProvider =
    AsyncNotifierProvider<DownloadExportController, DeclarationDownloadResult?>(
      DownloadExportController.new,
    );

class DownloadExportController
    extends AsyncNotifier<DeclarationDownloadResult?> {
  @override
  Future<DeclarationDownloadResult?> build() async => null;

  Future<void> download(String id, String exportId) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref
          .read(complianceRepositoryProvider)
          .downloadExport(id, exportId);
    });
  }
}

final markSubmittedControllerProvider =
    AsyncNotifierProvider<MarkSubmittedController, SocialFiscalDeclaration?>(
      MarkSubmittedController.new,
    );

class MarkSubmittedController extends AsyncNotifier<SocialFiscalDeclaration?> {
  @override
  Future<SocialFiscalDeclaration?> build() async => null;

  Future<void> markSubmitted(
    String id,
    MarkSubmittedDeclarationRequest request,
  ) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final declaration = await ref
          .read(complianceRepositoryProvider)
          .markSubmitted(id, request);
      ref.invalidate(declarationDetailProvider(id));
      ref.invalidate(declarationsProvider);
      ref.invalidate(complianceDashboardProvider);
      return declaration;
    });
  }
}

final archiveDeclarationControllerProvider =
    AsyncNotifierProvider<
      ArchiveDeclarationController,
      SocialFiscalDeclaration?
    >(ArchiveDeclarationController.new);

class ArchiveDeclarationController
    extends AsyncNotifier<SocialFiscalDeclaration?> {
  @override
  Future<SocialFiscalDeclaration?> build() async => null;

  Future<void> archive(String id, ArchiveDeclarationRequest request) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final declaration = await ref
          .read(complianceRepositoryProvider)
          .archiveDeclaration(id, request);
      ref.invalidate(declarationDetailProvider(id));
      ref.invalidate(declarationsProvider);
      ref.invalidate(complianceDashboardProvider);
      return declaration;
    });
  }
}
