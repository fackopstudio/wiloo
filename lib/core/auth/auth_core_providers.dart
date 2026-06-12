import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'secure_session_token_store.dart';
import 'session_token_store.dart';

/// Secure persistence for the Better Auth bearer token.
final sessionTokenStoreProvider = Provider<SessionTokenStore>((ref) {
  return const SecureSessionTokenStore();
});

/// Counter-based signal raised by the network layer when a protected request
/// is rejected with `401`. The session controller listens to it and clears the
/// session so route guards can react. This keeps `core/network` decoupled from
/// `features/auth` (no import cycle): the network layer only increments a
/// core-owned counter.
final sessionInvalidationProvider =
    NotifierProvider<SessionInvalidationNotifier, int>(
      SessionInvalidationNotifier.new,
    );

class SessionInvalidationNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void signal() => state++;
}
