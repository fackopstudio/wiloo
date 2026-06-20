import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../app/theme/app_theme.dart';

/// A single shimmering placeholder block.
///
/// The shimmer repeats while visible; it is only used inside loading states,
/// which are transient, so widget tests that pump through a resolved future
/// settle normally once the real content replaces the skeleton.
class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    this.width,
    this.height = 16,
    this.radius = WilooTokens.radiusSm,
    super.key,
  });

  final double? width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(radius),
      ),
    ).animate(onPlay: (controller) => controller.repeat()).shimmer(
          duration: const Duration(milliseconds: 1100),
          color: cs.surface,
        );
  }
}

/// A card-shaped skeleton (title line + two body lines).
///
/// Content-driven height (with a [minHeight]) so it never overflows in tight
/// layouts.
class ShimmerCard extends StatelessWidget {
  const ShimmerCard({this.minHeight = 88, super.key});

  final double minHeight;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      constraints: BoxConstraints(minHeight: minHeight),
      padding: const EdgeInsets.all(WilooTokens.space16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(WilooTokens.radiusMd),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ShimmerBox(width: 160, height: 18),
          SizedBox(height: WilooTokens.space12),
          ShimmerBox(height: 12),
          SizedBox(height: WilooTokens.space8),
          ShimmerBox(width: 220, height: 12),
        ],
      ),
    );
  }
}

/// A vertical list of skeleton cards for list/dashboard loading states.
class ShimmerList extends StatelessWidget {
  const ShimmerList({this.itemCount = 4, this.itemMinHeight = 88, super.key});

  final int itemCount;
  final double itemMinHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < itemCount; i++) ...[
          if (i > 0) const SizedBox(height: WilooTokens.space12),
          ShimmerCard(minHeight: itemMinHeight),
        ],
      ],
    );
  }
}
