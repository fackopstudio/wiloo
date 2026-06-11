enum DeclarationStatus {
  draft('DRAFT'),
  readyToReview('READY_TO_REVIEW'),
  validated('VALIDATED'),
  exported('EXPORTED'),
  submittedManually('SUBMITTED_MANUALLY'),
  archived('ARCHIVED');

  const DeclarationStatus(this.apiValue);

  final String apiValue;
}
