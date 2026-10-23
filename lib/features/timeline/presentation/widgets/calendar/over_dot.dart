import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// The small red dot under a day that went over its limit.
class OverDot extends StatelessWidget {
  const OverDot({super.key, required this.visible});

  final bool visible;

  @override
  Widget build(BuildContext context) => AnimatedContainer(
    duration: const Duration(milliseconds: 180),
    width: 6,
    height: 6,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: visible ? context.colors.negative : Colors.transparent,
    ),
  );
}
