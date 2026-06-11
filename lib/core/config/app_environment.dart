enum AppEnvironment {
  dev,
  staging,
  prod;

  static AppEnvironment fromName(String value) {
    return AppEnvironment.values.firstWhere(
      (environment) => environment.name == value,
      orElse: () => AppEnvironment.dev,
    );
  }
}
