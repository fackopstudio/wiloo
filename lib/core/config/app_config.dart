import 'app_environment.dart';
import 'app_mode.dart';

class AppConfig {
  const AppConfig._();

  static const _environmentName = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'dev',
  );

  static const _appModeName = String.fromEnvironment(
    'APP_MODE',
    defaultValue: 'backoffice',
  );

  /// Safe development default for the local Wiloo Docker backend.
  ///
  /// Override at launch for another target, for example:
  /// `--dart-define=API_BASE_URL=http://10.0.2.2:3002/api` on Android emulator.
  static const _defaultApiBaseUrl = 'http://localhost:3002/api';

  static const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: _defaultApiBaseUrl,
  );

  static AppEnvironment get environment =>
      AppEnvironment.fromName(_environmentName);

  static AppMode get appMode => AppMode.fromName(_appModeName);

  /// True when `API_BASE_URL` was not provided and the dev fallback is used.
  static bool get usesDefaultApiBaseUrl => apiBaseUrl == _defaultApiBaseUrl;

  /// Human-readable summary of the active runtime configuration. Useful for
  /// startup logging so the effective API base URL/mode is always visible.
  static String get summary =>
      'env=${environment.name} mode=${appMode.name} apiBaseUrl=$apiBaseUrl'
      '${usesDefaultApiBaseUrl ? ' (default API_BASE_URL)' : ''}';
}
