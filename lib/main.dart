import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/config/app_config.dart';

void main() {
  if (kDebugMode) {
    // Surface the effective runtime configuration (mode + API base URL) so a
    // missing --dart-define is visible at startup instead of silently using
    // the dev default.
    debugPrint('[Wiloo] ${AppConfig.summary}');
  }
  runApp(const ProviderScope(child: WilooApp()));
}
