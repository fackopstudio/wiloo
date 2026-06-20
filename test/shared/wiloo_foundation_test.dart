import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/shared/motion/wiloo_motion.dart';
import 'package:wiloo/shared/widgets/wiloo_logo.dart';
import 'package:wiloo/shared/widgets/wiloo_shimmer.dart';

void main() {
  testWidgets('WilooLogo renders and settles', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: Center(child: WilooLogo()))),
    );
    await tester.pumpAndSettle();

    // Either the asset image or its text fallback is present; never throws.
    expect(tester.takeException(), isNull);
    expect(find.byType(WilooLogo), findsOneWidget);
  });

  testWidgets('entrance animation completes (settles)', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: const Text('Animated content').wilooEntrance(index: 2),
        ),
      ),
    );
    // If the entrance animation looped forever, pumpAndSettle would time out.
    await tester.pumpAndSettle();

    expect(find.text('Animated content'), findsOneWidget);
  });

  testWidgets('ShimmerList renders skeleton cards', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: ShimmerList(itemCount: 3)),
      ),
    );
    // Shimmer repeats while visible; a single frame is enough to render it.
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(ShimmerCard), findsNWidgets(3));
    expect(tester.takeException(), isNull);

    // Dispose the skeleton so the repeating animation is cancelled before the
    // test ends (loading states are transient in real usage).
    await tester.pumpWidget(const MaterialApp(home: Scaffold()));
  });
}
