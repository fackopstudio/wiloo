enum AuthScope {
  backoffice('BACKOFFICE'),
  timeclock('TIMECLOCK');

  const AuthScope(this.apiValue);

  final String apiValue;

  static AuthScope? fromApi(String? value) {
    if (value == null) {
      return null;
    }

    final normalized = value.toUpperCase();
    for (final scope in AuthScope.values) {
      if (scope.apiValue == normalized) {
        return scope;
      }
    }

    return null;
  }
}
