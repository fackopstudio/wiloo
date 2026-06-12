import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/core/network/auth_interceptor.dart';

import '../../support/in_memory_token_store.dart';

void main() {
  group('AuthInterceptor', () {
    test('injects Authorization: Bearer when a token is stored', () async {
      final store = InMemoryTokenStore('stored-token');
      final adapter = _RecordingAdapter(statusCode: 200, body: {'ok': true});
      final dio = _dioWith(store, adapter);

      await dio.get<Object?>('/protected');

      expect(adapter.lastHeaders?['Authorization'], 'Bearer stored-token');
    });

    test('does not inject Authorization when no token is stored', () async {
      final store = InMemoryTokenStore();
      final adapter = _RecordingAdapter(statusCode: 200, body: {'ok': true});
      final dio = _dioWith(store, adapter);

      await dio.get<Object?>('/protected');

      expect(adapter.lastHeaders?.containsKey('Authorization'), isFalse);
    });

    test('captures set-auth-token from the response', () async {
      final store = InMemoryTokenStore();
      final adapter = _RecordingAdapter(
        statusCode: 200,
        body: {'ok': true},
        responseHeaders: {
          kSetAuthTokenHeader: ['fresh-token'],
        },
      );
      final dio = _dioWith(store, adapter);

      await dio.post<Object?>('/auth/sign-in/email');

      expect(await store.readToken(), 'fresh-token');
      expect(store.saveCount, 1);
    });

    test('captures rotated set-auth-token and ignores unchanged token',
        () async {
      final store = InMemoryTokenStore('old-token');
      final adapter = _RecordingAdapter(
        statusCode: 200,
        body: {'ok': true},
        responseHeaders: {
          kSetAuthTokenHeader: ['rotated-token'],
        },
      );
      final dio = _dioWith(store, adapter);

      await dio.get<Object?>('/protected');
      expect(await store.readToken(), 'rotated-token');

      // Same token again must not trigger another save.
      adapter.responseHeaders = {
        kSetAuthTokenHeader: ['rotated-token'],
      };
      final before = store.saveCount;
      await dio.get<Object?>('/protected');
      expect(store.saveCount, before);
    });

    test('clears token and signals on protected 401', () async {
      final store = InMemoryTokenStore('stored-token');
      final adapter = _RecordingAdapter(statusCode: 401, body: {'error': true});
      var unauthorizedCalls = 0;
      final dio = _dioWith(store, adapter, () => unauthorizedCalls++);

      await expectLater(
        dio.get<Object?>('/protected'),
        throwsA(isA<DioException>()),
      );

      expect(await store.readToken(), isNull);
      expect(unauthorizedCalls, 1);
    });
  });
}

Dio _dioWith(
  InMemoryTokenStore store,
  _RecordingAdapter adapter, [
  void Function()? onUnauthorized,
]) {
  final dio = Dio(BaseOptions(baseUrl: 'https://example.test'))
    ..httpClientAdapter = adapter
    ..interceptors.add(
      AuthInterceptor(
        tokenStore: store,
        onUnauthorized: onUnauthorized ?? () {},
      ),
    );
  return dio;
}

class _RecordingAdapter implements HttpClientAdapter {
  _RecordingAdapter({
    required this.statusCode,
    required this.body,
    this.responseHeaders,
  });

  final int statusCode;
  final Object? body;
  Map<String, List<String>>? responseHeaders;

  Map<String, dynamic>? lastHeaders;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastHeaders = Map<String, dynamic>.from(options.headers);
    return ResponseBody.fromString(
      jsonEncode(body),
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
        ...?responseHeaders,
      },
    );
  }
}
