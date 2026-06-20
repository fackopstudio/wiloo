import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/core/network/general_api_client.dart';
import 'package:wiloo/features/compliance/data/datasources/compliance_remote_data_source.dart';
import 'package:wiloo/features/compliance/data/dtos/archive_declaration_dto.dart';
import 'package:wiloo/features/compliance/data/dtos/create_declaration_period_dto.dart';
import 'package:wiloo/features/compliance/data/dtos/generate_declaration_dto.dart';
import 'package:wiloo/features/compliance/data/dtos/list_declaration_periods_query.dart';
import 'package:wiloo/features/compliance/data/dtos/list_declarations_query.dart';
import 'package:wiloo/features/compliance/data/dtos/mark_submitted_declaration_dto.dart';

void main() {
  group('ComplianceRemoteDataSourceImpl request guards', () {
    test(
      'never sends tenantId in request bodies or query parameters',
      () async {
        final adapter = _ComplianceRequestGuardAdapter();
        final dataSource = ComplianceRemoteDataSourceImpl(
          GeneralApiClient(Dio()..httpClientAdapter = adapter),
        );

        await dataSource.getPeriods(
          const ListDeclarationPeriodsQueryDto(
            companyId: 'company-1',
            periodType: 'MONTHLY',
            year: 2026,
          ),
        );
        await dataSource.getDeclarations(
          const ListDeclarationsQueryDto(
            declarationPeriodId: 'period-1',
            type: 'CNSS',
            status: 'DRAFT',
          ),
        );
        await dataSource.createPeriod(
          const CreateDeclarationPeriodDto(
            companyId: 'company-1',
            periodType: 'MONTHLY',
            year: 2026,
            month: 6,
            startDate: '2026-06-01T00:00:00.000Z',
            endDate: '2026-06-30T00:00:00.000Z',
          ),
        );
        await dataSource.generateDeclaration(
          const GenerateDeclarationDto(
            declarationPeriodId: 'period-1',
            type: 'CNSS',
          ),
        );
        await dataSource.markSubmitted(
          'decl-1',
          const MarkSubmittedDeclarationDto(
            submittedAt: '2026-06-16T00:00:00.000Z',
            notes: 'Submitted manually',
          ),
        );
        await dataSource.archiveDeclaration(
          'decl-1',
          const ArchiveDeclarationDto(reason: 'Archived after smoke test'),
        );

        expect(adapter.checkedRequests, 6);
      },
    );
  });

  group('downloadExport filename parsing', () {
    test('reads standard quoted filename from Content-Disposition', () async {
      final result = await _downloadWith(
        'attachment; filename="cnss-export.pdf"',
      );

      expect(result.fileName, 'cnss-export.pdf');
      expect(result.bytes, [10, 20]);
      expect(result.contentType, 'application/pdf');
    });

    test('reads plain filename from Content-Disposition', () async {
      final result = await _downloadWith(
        'attachment; filename=cnss-export.csv',
      );

      expect(result.fileName, 'cnss-export.csv');
    });

    test('reads UTF-8 encoded filename from Content-Disposition', () async {
      final result = await _downloadWith(
        "attachment; filename*=UTF-8''CNSS_pr%C3%A9paratoire.pdf",
      );

      expect(result.fileName, 'CNSS_préparatoire.pdf');
    });
  });
}

Future<dynamic> _downloadWith(String contentDisposition) async {
  final dataSource = ComplianceRemoteDataSourceImpl(
    GeneralApiClient(
      Dio()
        ..httpClientAdapter = _DownloadAdapter(
          contentDisposition: contentDisposition,
        ),
    ),
  );

  return dataSource.downloadExport('decl-1', 'export-1');
}

class _DownloadAdapter implements HttpClientAdapter {
  const _DownloadAdapter({required this.contentDisposition});

  final String contentDisposition;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    expect(
      options.path,
      '/compliance/declarations/decl-1/exports/export-1/download',
    );
    expect(options.responseType, ResponseType.bytes);

    return ResponseBody.fromBytes(
      [10, 20],
      200,
      headers: {
        Headers.contentTypeHeader: ['application/pdf'],
        'content-disposition': [contentDisposition],
      },
    );
  }
}

class _ComplianceRequestGuardAdapter implements HttpClientAdapter {
  int checkedRequests = 0;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    checkedRequests++;
    _expectNoTenantId(options.queryParameters);
    _expectNoTenantId(options.data);

    final data = switch ((options.method, options.path)) {
      ('GET', '/compliance/periods') => [_periodJson],
      ('GET', '/compliance/declarations') => [_declarationJson],
      ('POST', '/compliance/periods') => _periodJson,
      ('POST', '/compliance/declarations/generate') => _declarationJson,
      ('POST', '/compliance/declarations/decl-1/mark-submitted') =>
        _declarationJson,
      ('POST', '/compliance/declarations/decl-1/archive') => _declarationJson,
      _ => throw StateError(
        'Unexpected request: ${options.method} ${options.path}',
      ),
    };

    return ResponseBody.fromString(
      jsonEncode({'success': true, 'data': data, 'error': null}),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }
}

void _expectNoTenantId(Object? value) {
  if (value is Map) {
    expect(value.containsKey('tenantId'), isFalse);
    for (final nested in value.values) {
      _expectNoTenantId(nested);
    }
  } else if (value is Iterable) {
    for (final nested in value) {
      _expectNoTenantId(nested);
    }
  }
}

final _periodJson = {
  'id': 'period-1',
  'tenantId': 'tenant-from-backend',
  'companyId': 'company-1',
  'periodType': 'MONTHLY',
  'year': 2026,
  'month': 6,
  'quarter': null,
  'startDate': '2026-06-01T00:00:00.000Z',
  'endDate': '2026-06-30T00:00:00.000Z',
  'payrollMonth': null,
  'payrollYear': null,
  'status': 'DRAFT',
  'metadata': null,
  'createdAt': '2026-06-01T00:00:00.000Z',
  'updatedAt': '2026-06-01T00:00:00.000Z',
};

final _declarationJson = {
  'id': 'decl-1',
  'tenantId': 'tenant-from-backend',
  'companyId': 'company-1',
  'declarationPeriodId': 'period-1',
  'type': 'CNSS',
  'status': 'DRAFT',
  'ruleSetId': null,
  'totalGrossSalary': '1000.00',
  'totalTaxableBase': '900.00',
  'totalEmployeeContributions': '100.00',
  'totalEmployerContributions': '150.00',
  'totalWithholdings': '50.00',
  'warnings': null,
  'metadata': null,
  'validatedBy': null,
  'validatedAt': null,
  'exportedAt': null,
  'submittedManuallyAt': null,
  'period': null,
  'lines': null,
  'exports': null,
  'attachments': null,
  'createdAt': '2026-06-01T00:00:00.000Z',
  'updatedAt': '2026-06-01T00:00:00.000Z',
};
