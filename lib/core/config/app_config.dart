import 'app_environment.dart';

class AppConfig {
  const AppConfig._();

  static const _environmentName = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'dev',
  );

  static const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:3000/api',
  );

  static AppEnvironment get environment =>
      AppEnvironment.fromName(_environmentName);
}
