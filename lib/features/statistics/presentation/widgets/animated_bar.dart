import 'package:flutter/material.dart';

/// A bar that grows to [fraction] of [maxHeight] when it first shows.
class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.fraction,
    required this.maxHeight,
    required this.color,
  });

  final double fraction, maxHeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: fraction.clamp(0.0, 1.0)),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (_, v, _) => Container(
        width: 12,
        height: (maxHeight * v).clamp(3.0, maxHeight),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ),
    );
  }
}
