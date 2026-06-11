import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/main.dart' as app;

void main() {
  testWidgets('Wiloo app starts on timeclock screen', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.text('Wiloo Pointage'), findsOneWidget);
    expect(find.text('Terminal de pointage'), findsOneWidget);
  });
}
