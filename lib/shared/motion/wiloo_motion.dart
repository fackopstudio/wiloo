import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Subtle, professional entrance motion used across Wiloo screens.
///
/// Animations are intentionally short and non-distracting. They never block
/// user input and always end in the resting state (so widget tests settle).
const Duration wilooEntranceDuration = Duration(milliseconds: 300);
const Duration wilooStagger = Duration(milliseconds: 55);

extension WilooMotion on Widget {
  /// Fade + gentle upward slide. Use [index] to stagger a list of items.
  ///
  /// The stagger is applied as an effect-level delay (part of the animation
  /// timeline) rather than an `Animate(delay:)` timer, so widget tests settle
  /// without leaving pending timers.
  Widget wilooEntrance({int index = 0, double beginY = 0.06}) {
    final delay = wilooStagger * index;
    return animate()
        .fadeIn(
          delay: delay,
          duration: wilooEntranceDuration,
          curve: Curves.easeOutCubic,
        )
        .slideY(
          begin: beginY,
          end: 0,
          delay: delay,
          duration: wilooEntranceDuration,
          curve: Curves.easeOutCubic,
        );
  }

  /// Fade + subtle scale, suited to hero cards and empty-state illustrations.
  Widget wilooScaleIn({int index = 0}) {
    final delay = wilooStagger * index;
    return animate()
        .fadeIn(
          delay: delay,
          duration: wilooEntranceDuration,
          curve: Curves.easeOut,
        )
        .scale(
          begin: const Offset(0.97, 0.97),
          end: const Offset(1, 1),
          delay: delay,
          duration: wilooEntranceDuration,
          curve: Curves.easeOutCubic,
        );
  }
}
