import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/features/compliance/domain/entities/declaration_export.dart';
import 'package:wiloo/features/compliance/presentation/widgets/compliance_widgets.dart';

void main() {
  group('exportIdFromRaw', () {
    test('reads a top-level id (direct export object)', () {
      const export = DeclarationExport(raw: {'id': 'export-1'});
      expect(exportIdFromRaw(export), 'export-1');
    });

    test('reads a top-level exportId', () {
      const export = DeclarationExport(raw: {'exportId': 'export-2'});
      expect(exportIdFromRaw(export), 'export-2');
    });

    test('reads the nested export.id from the composite POST response', () {
      // Mirrors the confirmed runtime payload:
      // { declaration: {...}, export: { id, ... }, download: { exportId, ... } }
      const export = DeclarationExport(
        raw: {
          'declaration': {'id': 'decl-1', 'status': 'EXPORTED'},
          'export': {
            'id': '7fc927b7-b427-4ba1-bb7c-e34bfc766580',
            'format': 'PDF',
            'fileName': 'CNSS_preparatory_summary_2026_10.pdf',
          },
          'download': {
            'exportId': '7fc927b7-b427-4ba1-bb7c-e34bfc766580',
            'fileName': 'CNSS_preparatory_summary_2026_10.pdf',
            'mimeType': 'application/pdf',
          },
        },
      );

      expect(exportIdFromRaw(export), '7fc927b7-b427-4ba1-bb7c-e34bfc766580');
    });

    test('falls back to download.exportId when export object lacks an id', () {
      const export = DeclarationExport(
        raw: {
          'download': {'exportId': 'download-export-id'},
        },
      );

      expect(exportIdFromRaw(export), 'download-export-id');
    });

    test('returns null when no usable id is present', () {
      const export = DeclarationExport(raw: {'storageKey': 'file-key'});
      expect(exportIdFromRaw(export), isNull);
    });
  });
}
