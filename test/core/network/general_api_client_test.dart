import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/core/error/failure.dart';
import 'package:wiloo/core/network/general_api_client.dart';

void main() {
  test('decodes successful API envelope', () async {
    final client = GeneralApiClient(
      Dio()..httpClientAdapter = _StaticAdapter.success({'id': 'period-1'}),
    );

    final data = await client.getJson<Map<String, Object?>>('/test');

    expect(data['id'], 'period-1');
  });

  test('maps 400 envelope failure to invalidStateTransition', () async {
    final client = GeneralApiClient(
      Dio()..httpClientAdapter = _StaticAdapter.failure(400, 'Invalid state'),
    );

    expect(
      () => client.postJson<Map<String, Object?>>('/test'),
      throwsA(
        isA<Failure>().having(
          (failure) => failure.type,
          'type',
          FailureType.invalidStateTransition,
        ),
      ),
    );
  });

  test('maps 403 envelope failure to forbidden', () async {
    final client = GeneralApiClient(
      Dio()..httpClientAdapter = _StaticAdapter.failure(403, 'Forbidden'),
    );

    expect(
      () => client.getJson<Map<String, Object?>>('/test'),
      throwsA(
        isA<Failure>().having(
          (failure) => failure.type,
          'type',
          FailureType.forbidden,
        ),
      ),
    );
  });

  test('downloads binary response without JSON envelope', () async {
    final client = GeneralApiClient(
      Dio()..httpClientAdapter = _BinaryAdapter(),
    );

    final response = await client.getBinary('/download');

    expect(response.bytes, [1, 2, 3]);
    expect(response.headers.value('content-type'), 'application/pdf');
  });
}

class _StaticAdapter implements HttpClientAdapter {
  _StaticAdapter(this._statusCode, this._data);

  factory _StaticAdapter.success(Map<String, Object?> data) {
    return _StaticAdapter(200, {'success': true, 'data': data});
  }

  factory _StaticAdapter.failure(int statusCode, String message) {
    return _StaticAdapter(statusCode, {
      'success': false,
      'error': {'statusCode': statusCode, 'message': message},
    });
  }

  final int _statusCode;
  final Object? _data;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      jsonEncode(_data),
      _statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }
}

class _BinaryAdapter implements HttpClientAdapter {
  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromBytes(
      [1, 2, 3],
      200,
      headers: {
        Headers.contentTypeHeader: ['application/pdf'],
        'content-disposition': ['attachment; filename="export.pdf"'],
      },
    );
  }
}
