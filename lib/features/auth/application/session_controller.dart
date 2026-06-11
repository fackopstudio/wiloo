import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/session_snapshot.dart';

final sessionControllerProvider = Provider<SessionSnapshot>((ref) {
  return const SessionSnapshot.guest();
});
