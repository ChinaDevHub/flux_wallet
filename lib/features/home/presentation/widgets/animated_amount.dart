import 'package:flutter/material.dart';
import 'package:flux_wallet/core/utils/money_format.dart';

/// Counts up to [value] whenever it changes.
class AnimatedAmount extends StatelessWidget {
  const AnimatedAmount({super.key, required this.value, required this.style});

  final double value;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: value),
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      builder: (_, v, _) => Text(
        '${v < 0 ? '-' : ''}${formatMoney(v)}',
        style: style.copyWith(
          fontFeatures: const [FontFeature.tabularFigures()],
        ),
      ),
    );
  }
}
