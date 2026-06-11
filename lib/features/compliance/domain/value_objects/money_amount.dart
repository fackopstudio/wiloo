class MoneyAmount {
  const MoneyAmount._(this.rawValue);

  factory MoneyAmount.fromApi(Object value) {
    return MoneyAmount._(value.toString());
  }

  /// Backend-provided value kept for display only.
  ///
  /// Flutter must not use this value for fiscal or social calculations.
  final String rawValue;

  String get displayValue => rawValue;
}
