import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/core/network/auth_interceptor.dart';
import 'package:wiloo/features/auth/data/auth_remote_data_source.dart';
import 'package:wiloo/features/auth/domain/auth_scope.dart';
import 'package:wiloo/features/auth/domain/user_role.dart';

void main() {
  group('AuthRemoteDataSourceImpl', () {
    test('signInEmail captures set-auth-token from headers', () async {
      final dataSource = AuthRemoteDataSourceImpl(
        _dio(
          _JsonResponse(
            statusCode: 200,
            body: {
              'user': {'id': 'u1', 'email': 'a@b.com'},
            },
            headers: {
              kSetAuthTokenHeader: ['header-token'],
            },
          ),
        ),
      );

      final result = await dataSource.signInEmail('a@b.com', 'pw');

      expect(result.token, 'header-token');
      expect(result.user?.id, 'u1');
    });

    test(
      'signInEmail falls back to body token when header is absent',
      () async {
        final dataSource = AuthRemoteDataSourceImpl(
          _dio(
            _JsonResponse(
              statusCode: 200,
              body: {
                'token': 'body-token',
                'user': {'id': 'u1', 'email': 'a@b.com'},
              },
            ),
          ),
        );

        final result = await dataSource.signInEmail('a@b.com', 'pw');

        expect(result.token, 'body-token');
      },
    );

    test('getSession returns null for a 200 null body', () async {
      final dataSource = AuthRemoteDataSourceImpl(
        _dio(_JsonResponse(statusCode: 200, body: null)),
      );

      expect(await dataSource.getSession(), isNull);
    });

    test(
      'getSession parses user role, scope and session tenant fallback',
      () async {
        final dataSource = AuthRemoteDataSourceImpl(
          _dio(
            _JsonResponse(
              statusCode: 200,
              body: {
                'user': {
                  'id': 'u1',
                  'email': 'hr@b.com',
                  'role': 'hr',
                  'scope': 'BACKOFFICE',
                },
                'session': {'tenantId': 'tenant-from-session'},
              },
            ),
          ),
        );

        final session = await dataSource.getSession();

        expect(session, isNotNull);
        expect(session!.role, UserRole.hr);
        expect(session.scope, AuthScope.backoffice);
        expect(session.tenantId, 'tenant-from-session');
      },
    );

    test('getSession unwraps the standard API envelope', () async {
      final dataSource = AuthRemoteDataSourceImpl(
        _dio(
          _JsonResponse(
            statusCode: 200,
            body: {
              'success': true,
              'data': {
                'user': {'id': 'u1', 'email': 'a@b.com', 'role': 'admin'},
              },
            },
          ),
        ),
      );

      final session = await dataSource.getSession();

      expect(session?.role, UserRole.admin);
    });
  });
}

Dio _dio(_JsonResponse response) {
  return Dio(BaseOptions(baseUrl: 'https://example.test'))
    ..httpClientAdapter = _StubAdapter(response);
}

class _JsonResponse {
  _JsonResponse({required this.statusCode, required this.body, this.headers});

  final int statusCode;
  final Object? body;
  final Map<String, List<String>>? headers;
}

class _StubAdapter implements HttpClientAdapter {
  _StubAdapter(this._response);

  final _JsonResponse _response;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      jsonEncode(_response.body),
      _response.statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
        ...?_response.headers,
      },
    );
  }
}
