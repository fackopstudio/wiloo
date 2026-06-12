import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_core_providers.dart';
import '../../../core/network/dio_provider.dart';
import '../data/auth_remote_data_source.dart';
import '../data/auth_repository_impl.dart';
import '../domain/auth_repository.dart';
import '../domain/session_snapshot.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(ref.watch(dioProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    tokenStore: ref.watch(sessionTokenStoreProvider),
  );
});

/// Real session manager: the single source of truth for the authenticated
/// state. It bootstraps on app start, exposes login/logout and reacts to the
/// network layer's `401` invalidation signal.
final sessionManagerProvider =
    NotifierProvider<SessionManager, SessionSnapshot>(SessionManager.new);

class SessionManager extends Notifier<SessionSnapshot> {
  AuthRepository get _repository => ref.read(authRepositoryProvider);

  @override
  SessionSnapshot build() {
    // React to protected 401s surfaced by the network layer.
    ref.listen<int>(sessionInvalidationProvider, (previous, next) {
      if (previous != null && next != previous) {
        _invalidate();
      }
    });

    // Hydrate from the securely stored token without blocking startup.
    _bootstrap();

    return const SessionSnapshot.guest();
  }

  Future<void> _bootstrap() async {
    final repository = ref.read(authRepositoryProvider);
    final snapshot = await repository.bootstrapSession();
    if (!ref.mounted) {
      return;
    }
    state = snapshot;
  }

  Future<void> login(String email, String password) async {
    final snapshot = await _repository.signIn(email, password);
    if (!ref.mounted) {
      return;
    }
    state = snapshot;
  }

  Future<void> logout() async {
    await _repository.logout();
    if (!ref.mounted) {
      return;
    }
    state = const SessionSnapshot.guest();
  }

  Future<void> _invalidate() async {
    if (!state.isAuthenticated) {
      return;
    }
    // The token was already cleared by the network layer; ensure a clean local
    // logout and drop to guest so route guards react.
    await _repository.logout();
    if (!ref.mounted) {
      return;
    }
    state = const SessionSnapshot.guest();
  }
}

/// Read-only session projection consumed by the UI, route guards and the
/// compliance feature. Exposed as a `Provider<SessionSnapshot>` so existing
/// consumers and tests keep working unchanged.
final sessionControllerProvider = Provider<SessionSnapshot>((ref) {
  return ref.watch(sessionManagerProvider);
});
