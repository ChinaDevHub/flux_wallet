import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/money_format.dart';
import 'package:flux_wallet/features/debts/domain/entities/debt_summary.dart';

/// Progress bar with "paid / total" underneath.
class DebtProgress extends StatelessWidget {
  const DebtProgress(this.summary, {super.key});

  final DebtSummary summary;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final small = TextStyle(fontSize: 11, color: c.textMuted);
    return Column(
      spacing: 6,
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(end: summary.progress),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
          builder: (_, v, _) => ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: v,
              minHeight: 6,
              backgroundColor: c.surfaceAlt,
              valueColor: AlwaysStoppedAnimation(c.primary),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${formatMoney(summary.paid)} $azn qaytarılıb', style: small),
            Text('${(summary.progress * 100).round()}%', style: small),
          ],
        ),
      ],
    );
  }
}
