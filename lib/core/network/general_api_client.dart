import 'package:dio/dio.dart';

import '../error/failure.dart';

class BinaryApiResponse {
  const BinaryApiResponse({
    required this.bytes,
    required this.headers,
    required this.statusCode,
  });

  final List<int> bytes;
  final Headers headers;
  final int? statusCode;
}

class GeneralApiClient {
  const GeneralApiClient(this._dio);

  final Dio _dio;

  Future<T> getJson<T>(
    String path, {
    Map<String, Object?>? queryParameters,
  }) async {
    return _requestJson<T>(
      () => _dio.get<Object?>(path, queryParameters: queryParameters),
    );
  }

  Future<T> postJson<T>(
    String path, {
    Object? data,
    Map<String, Object?>? queryParameters,
  }) async {
    return _requestJson<T>(
      () => _dio.post<Object?>(
        path,
        data: data,
        queryParameters: queryParameters,
      ),
    );
  }

  Future<BinaryApiResponse> getBinary(
    String path, {
    Map<String, Object?>? queryParameters,
  }) async {
    try {
      final response = await _dio.get<List<int>>(
        path,
        queryParameters: queryParameters,
        options: Options(responseType: ResponseType.bytes),
      );

      return BinaryApiResponse(
        bytes: response.data ?? const [],
        headers: response.headers,
        statusCode: response.statusCode,
      );
    } on DioException catch (error) {
      throw _mapDioException(error);
    } on Object catch (error) {
      throw Failure.unknown(cause: error);
    }
  }

  Future<T> _requestJson<T>(Future<Response<Object?>> Function() run) async {
    try {
      final response = await run();
      return _decodeEnvelope<T>(response.data);
    } on DioException catch (error) {
      throw _mapDioException(error);
    } on Failure {
      rethrow;
    } on Object catch (error) {
      throw Failure.unknown(cause: error);
    }
  }

  T _decodeEnvelope<T>(Object? body) {
    if (body is! Map<String, Object?>) {
      throw Failure.decoding(cause: body);
    }

    final success = body['success'];
    if (success == false) {
      throw _failureFromEnvelope(body);
    }

    final data = body.containsKey('data') ? body['data'] : body;
    if (data is T) {
      return data;
    }

    throw Failure.decoding(cause: body);
  }

  Failure _mapDioException(DioException error) {
    final statusCode = error.response?.statusCode;
    final data = error.response?.data;

    if (statusCode == 400) {
      return Failure.invalidStateTransition(
        message: _extractErrorMessage(data) ?? 'Invalid state transition.',
        cause: error,
      );
    }

    if (statusCode == 403) {
      return Failure.forbidden(
        message: _extractErrorMessage(data) ?? 'Forbidden.',
        cause: error,
      );
    }

    if (statusCode != null && statusCode >= 500) {
      return Failure.server(
        message: _extractErrorMessage(data) ?? 'Server error.',
        statusCode: statusCode,
        cause: error,
      );
    }

    if (statusCode != null) {
      return Failure.server(
        message: _extractErrorMessage(data) ?? 'Request failed.',
        statusCode: statusCode,
        cause: error,
      );
    }

    return Failure.network(
      message: error.message ?? 'Network error.',
      cause: error,
    );
  }

  Failure _failureFromEnvelope(Map<String, Object?> body) {
    final statusCode = _extractStatusCode(body);
    final message = _extractErrorMessage(body) ?? 'Request failed.';

    if (statusCode == 400) {
      return Failure.invalidStateTransition(message: message, cause: body);
    }
    if (statusCode == 403) {
      return Failure.forbidden(message: message, cause: body);
    }

    return Failure.server(
      message: message,
      statusCode: statusCode,
      cause: body,
    );
  }

  int? _extractStatusCode(Object? data) {
    if (data is Map<String, Object?>) {
      final statusCode = data['statusCode'];
      if (statusCode is int) {
        return statusCode;
      }

      final error = data['error'];
      if (error is Map<String, Object?>) {
        final nestedStatusCode = error['statusCode'];
        if (nestedStatusCode is int) {
          return nestedStatusCode;
        }
      }
    }

    return null;
  }

  String? _extractErrorMessage(Object? data) {
    if (data is Map<String, Object?>) {
      final error = data['error'];
      if (error is Map<String, Object?>) {
        final message = error['message'];
        if (message is String) {
          return message;
        }
      }

      final message = data['message'];
      if (message is String) {
        return message;
      }
    }

    return null;
  }
}
