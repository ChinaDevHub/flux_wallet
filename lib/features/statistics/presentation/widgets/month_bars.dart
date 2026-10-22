import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/statistics/domain/entities/month_totals.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/animated_bar.dart';

/// The income (green) and expense (terracotta) bars of one month.
class MonthBars extends StatelessWidget {
  const MonthBars({
    super.key,
    required this.totals,
    required this.maxValue,
    required this.height,
  });

  final MonthTotals totals;
  final double maxValue, height;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    double fraction(double v) => maxValue <= 0 ? 0 : v / maxValue;
    return SizedBox(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 3,
        children: [
          AnimatedBar(
            fraction: fraction(totals.income),
            maxHeight: height,
            color: c.positive,
          ),
          AnimatedBar(
            fraction: fraction(totals.expense),
            maxHeight: height,
            color: c.accent,
          ),
        ],
      ),
    );
  }
}
