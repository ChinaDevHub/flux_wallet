import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// One digit's dot: pops in when filled, outlined when empty.
class PinDot extends StatelessWidget {
  const PinDot({super.key, required this.filled, required this.error});

  final bool filled, error;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final tint = error ? c.negative : c.primary;
    return AnimatedScale(
      duration: const Duration(milliseconds: 160),
      curve: Curves.easeOutBack,
      scale: filled ? 1 : 0.85,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: filled ? tint : Colors.transparent,
          border: Border.all(
            width: 1.6,
            color: filled || error ? tint : c.textMuted.withValues(alpha: 0.6),
          ),
        ),
      ),
    );
  }
}
