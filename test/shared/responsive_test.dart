import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wiloo/shared/responsive/responsive.dart';

void main() {
  group('WilooBreakpoints', () {
    test('classifies widths into form factors', () {
      expect(WilooBreakpoints.of(420), WilooFormFactor.mobile);
      expect(WilooBreakpoints.of(599), WilooFormFactor.mobile);
      expect(WilooBreakpoints.of(600), WilooFormFactor.tablet);
      expect(WilooBreakpoints.of(900), WilooFormFactor.tablet);
      expect(WilooBreakpoints.of(1024), WilooFormFactor.desktop);
      expect(WilooBreakpoints.of(1600), WilooFormFactor.desktop);
    });
  });

  group('ResponsiveContext', () {
    testWidgets('exposes form factor from MediaQuery', (tester) async {
      late WilooFormFactor mobileFactor;
      late WilooFormFactor desktopFactor;

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(400, 800)),
          child: Builder(
            builder: (context) {
              mobileFactor = context.formFactor;
              return const SizedBox();
            },
          ),
        ),
      );
      expect(mobileFactor, WilooFormFactor.mobile);

      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(size: Size(1300, 800)),
          child: Builder(
            builder: (context) {
              desktopFactor = context.formFactor;
              return const SizedBox();
            },
          ),
        ),
      );
      expect(desktopFactor, WilooFormFactor.desktop);
    });
  });

  group('PageContainer', () {
    for (final size in const [Size(360, 640), Size(1440, 900)]) {
      testWidgets('renders without overflow at $size', (tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.reset);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PageContainer(
                scrollable: true,
                child: Column(
                  children: List.generate(
                    8,
                    (i) => Card(child: ListTile(title: Text('Item $i'))),
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull);
        expect(find.text('Item 0'), findsOneWidget);
      });
    }
  });

  group('ResponsiveCardGrid', () {
    testWidgets('renders all children without overflow', (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ResponsiveCardGrid(
              children: [
                for (var i = 0; i < 4; i++)
                  Card(child: SizedBox(height: 80, child: Text('Tile $i'))),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.textContaining('Tile'), findsNWidgets(4));
    });
  });
}
