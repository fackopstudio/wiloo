enum ExportFormat {
  pdf('PDF'),
  excel('EXCEL'),
  csv('CSV');

  const ExportFormat(this.apiValue);

  final String apiValue;
}
