import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../auth/auth_core_providers.dart';
import '../config/app_config.dart';
import 'auth_interceptor.dart';
import 'general_api_client.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConfig.apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 20),
      headers: const {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  final tokenStore = ref.watch(sessionTokenStoreProvider);
  dio.interceptors.add(
    AuthInterceptor(
      tokenStore: tokenStore,
      onUnauthorized: () => ref.read(sessionInvalidationProvider.notifier).signal(),
    ),
  );

  return dio;
});

final generalApiClientProvider = Provider<GeneralApiClient>((ref) {
  return GeneralApiClient(ref.watch(dioProvider));
});
