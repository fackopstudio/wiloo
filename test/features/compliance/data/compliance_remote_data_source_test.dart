import 'dart:async';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/core/network/general_api_client.dart';
import 'package:wiloo/features/compliance/data/datasources/compliance_remote_data_source.dart';

void main() {
  test('downloadExport reads filename from Content-Disposition', () async {
    final dataSource = ComplianceRemoteDataSourceImpl(
      GeneralApiClient(Dio()..httpClientAdapter = _DownloadAdapter()),
    );

    final result = await dataSource.downloadExport('decl-1', 'export-1');

    expect(result.bytes, [10, 20]);
    expect(result.fileName, 'cnss-export.pdf');
    expect(result.contentType, 'application/pdf');
  });
}

class _DownloadAdapter implements HttpClientAdapter {
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
        'content-disposition': ['attachment; filename="cnss-export.pdf"'],
      },
    );
  }
}
