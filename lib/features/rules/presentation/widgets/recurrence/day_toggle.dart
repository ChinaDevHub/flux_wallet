import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

/// One round weekday pill: filled when the rule happens on that day.
class DayToggle extends StatelessWidget {
  const DayToggle({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? c.primary : c.surfaceAlt,
          shape: BoxShape.circle,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: selected ? c.onPrimary : c.textMuted,
          ),
        ),
      ),
    );
  }
}
