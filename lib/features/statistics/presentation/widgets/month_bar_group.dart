import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/az_names.dart';
import 'package:flux_wallet/features/statistics/domain/entities/month_totals.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/month_bars.dart';

/// One month of the chart: its bars and name; tap to select it.
class MonthBarGroup extends StatelessWidget {
  const MonthBarGroup({
    super.key,
    required this.totals,
    required this.maxValue,
    required this.selected,
    required this.onTap,
  });

  final MonthTotals totals;
  final double maxValue;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          spacing: 6,
          children: [
            MonthBars(totals: totals, maxValue: maxValue, height: 120),
            Text(
              azMonthsShort[totals.month.month - 1],
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected ? FontWeight.w800 : FontWeight.w500,
                color: selected ? c.text : c.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
