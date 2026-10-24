import 'package:flutter/material.dart';
import 'package:flux_wallet/features/statistics/domain/entities/statistics_view.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/bar_strip.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/chart_card.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/month_bar_group.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/month_summary.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/summary_caption.dart';

/// Income vs expense month by month over the period; tap a month to look
/// at it alone.
class MonthComparisonChart extends StatelessWidget {
  const MonthComparisonChart({
    super.key,
    required this.view,
    required this.onSelect,
  });

  final StatisticsView view;
  final ValueChanged<DateTime> onSelect;

  @override
  Widget build(BuildContext context) {
    final peak = view.months
        .map((m) => m.income > m.expense ? m.income : m.expense)
        .fold(0.0, (a, b) => a > b ? a : b);
    final pick = view.selected;
    return ChartCard(
      title: 'Gəlir və xərc müqayisəsi',
      child: Column(
        spacing: 12,
        children: [
          BarStrip(
            children: [
              for (final m in view.months)
                MonthBarGroup(
                  totals: m,
                  maxValue: peak,
                  selected: m.month == pick,
                  onTap: () => onSelect(m.month),
                ),
            ],
          ),
          SummaryCaption(view: view, onAll: () => onSelect(pick!)),
          MonthSummary(view.selectedTotals),
        ],
      ),
    );
  }
}
