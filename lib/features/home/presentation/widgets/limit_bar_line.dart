import 'package:flutter/material.dart';

/// The thin bar on the limit card; it slides and recolours smoothly.
class LimitBarLine extends StatelessWidget {
  const LimitBarLine({super.key, required this.ratio, required this.color});

  final double ratio;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: ratio),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      builder: (_, v, _) => ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: v,
          minHeight: 6,
          backgroundColor: Colors.white24,
          valueColor: AlwaysStoppedAnimation(color),
        ),
      ),
    );
  }
}
