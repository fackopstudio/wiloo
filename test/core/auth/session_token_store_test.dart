import 'package:flutter_test/flutter_test.dart';

import '../../support/in_memory_token_store.dart';

void main() {
  group('SessionTokenStore contract', () {
    test('read returns null when empty', () async {
      final store = InMemoryTokenStore();
      expect(await store.readToken(), isNull);
    });

    test('save then read returns the token', () async {
      final store = InMemoryTokenStore();
      await store.saveToken('token-123');
      expect(await store.readToken(), 'token-123');
    });

    test('save overwrites the previous token', () async {
      final store = InMemoryTokenStore('old');
      await store.saveToken('new');
      expect(await store.readToken(), 'new');
    });

    test('clear removes the token', () async {
      final store = InMemoryTokenStore('token-123');
      await store.clearToken();
      expect(await store.readToken(), isNull);
    });
  });
}
