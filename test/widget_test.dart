import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/main.dart' as app;

void main() {
  testWidgets('Wiloo app defaults to the welcome flow, not the terminal', (
    tester,
  ) async {
    app.main();
    await tester.pumpAndSettle();

    // Default APP_MODE=backoffice starts unauthenticated users on welcome.
    expect(find.text('Toute votre RH,\nau même endroit'), findsOneWidget);
    expect(find.text('Se connecter'), findsOneWidget);
    expect(find.text('Terminal de pointage'), findsNothing);
  });
}
