class DeclarationDownloadResult {
  const DeclarationDownloadResult({
    required this.bytes,
    required this.fileName,
    required this.contentType,
  });

  final List<int> bytes;
  final String fileName;
  final String contentType;
}
