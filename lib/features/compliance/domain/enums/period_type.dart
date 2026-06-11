enum PeriodType {
  monthly('MONTHLY'),
  quarterly('QUARTERLY'),
  yearly('YEARLY');

  const PeriodType(this.apiValue);

  final String apiValue;
}
