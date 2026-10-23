import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// How much of the day's limit is used; red once it is over.
class LimitBar extends StatelessWidget {
  const LimitBar({super.key, required this.used, required this.over});

  final double used;
  final bool over;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final color = over
        ? c.negative
        : used > 0.85
        ? c.accent
        : c.primary;
    return TweenAnimationBuilder<double>(
      tween: Tween(end: used),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      builder: (_, v, _) => ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: v,
          minHeight: 6,
          backgroundColor: c.surfaceAlt,
          valueColor: AlwaysStoppedAnimation(color),
        ),
      ),
    );
  }
}
