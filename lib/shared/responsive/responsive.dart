import 'package:flutter/material.dart';

import '../../app/theme/app_theme.dart';

/// Layout breakpoints used across the app.
enum WilooFormFactor { mobile, tablet, desktop }

class WilooBreakpoints {
  const WilooBreakpoints._();

  static const double tablet = 600;
  static const double desktop = 1024;

  static WilooFormFactor of(double width) {
    if (width >= desktop) return WilooFormFactor.desktop;
    if (width >= tablet) return WilooFormFactor.tablet;
    return WilooFormFactor.mobile;
  }
}

extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;

  WilooFormFactor get formFactor => WilooBreakpoints.of(screenWidth);

  bool get isMobile => formFactor == WilooFormFactor.mobile;
  bool get isTablet => formFactor == WilooFormFactor.tablet;
  bool get isDesktop => formFactor == WilooFormFactor.desktop;

  /// Adaptive horizontal page padding based on the current form factor.
  double get pagePadding => switch (formFactor) {
    WilooFormFactor.mobile => WilooTokens.space16,
    WilooFormFactor.tablet => WilooTokens.space24,
    WilooFormFactor.desktop => WilooTokens.space40,
  };

  /// Suggested number of grid columns for card layouts.
  int gridColumns({int max = 4}) {
    final columns = switch (formFactor) {
      WilooFormFactor.mobile => 1,
      WilooFormFactor.tablet => 2,
      WilooFormFactor.desktop => 3,
    };
    return columns > max ? max : columns;
  }
}

/// A safe, centered page container that caps content width on large screens
/// and applies adaptive padding. Use as the body wrapper for backoffice pages.
class PageContainer extends StatelessWidget {
  const PageContainer({
    required this.child,
    this.maxWidth = WilooTokens.maxContentWidth,
    this.verticalPadding = WilooTokens.space24,
    this.scrollable = false,
    super.key,
  });

  final Widget child;
  final double maxWidth;
  final double verticalPadding;

  /// When true the content is wrapped in a [SingleChildScrollView] so short
  /// screens never overflow on small devices.
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final padding = EdgeInsets.symmetric(
      horizontal: context.pagePadding,
      vertical: verticalPadding,
    );

    final content = Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(padding: padding, child: child),
      ),
    );

    if (!scrollable) {
      return content;
    }

    return SingleChildScrollView(child: content);
  }
}

/// Lightweight responsive grid for equal-width cards. Falls back to a single
/// column on mobile. Avoids heavy grid packages for a maintainable layout.
class ResponsiveCardGrid extends StatelessWidget {
  const ResponsiveCardGrid({
    required this.children,
    this.spacing = WilooTokens.space16,
    this.maxColumns = 3,
    this.minTileWidth = 280,
    super.key,
  });

  final List<Widget> children;
  final double spacing;
  final int maxColumns;
  final double minTileWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        var columns = (width / minTileWidth).floor();
        if (columns < 1) columns = 1;
        if (columns > maxColumns) columns = maxColumns;

        if (columns == 1) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) SizedBox(height: spacing),
                children[i],
              ],
            ],
          );
        }

        final tileWidth = (width - (columns - 1) * spacing) / columns;
        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: [
            for (final child in children)
              SizedBox(width: tileWidth, child: child),
          ],
        );
      },
    );
  }
}
