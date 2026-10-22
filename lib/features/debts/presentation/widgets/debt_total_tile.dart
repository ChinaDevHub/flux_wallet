import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/money_format.dart';

class DebtTotalTile extends StatelessWidget {
  const DebtTotalTile(this.label, this.amount, this.tint, {super.key});

  final String label;
  final double amount;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: c.surface,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: 12, color: c.textMuted)),
            const SizedBox(height: 4),
            FittedBox(
              child: Text(
                formatAzn(amount),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: tint,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
