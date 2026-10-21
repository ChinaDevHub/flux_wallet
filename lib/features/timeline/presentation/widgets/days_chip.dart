import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';

class DaysChip extends StatelessWidget {
  const DaysChip(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: c.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: c.onPrimary,
        ),
      ),
    );
  }
}
