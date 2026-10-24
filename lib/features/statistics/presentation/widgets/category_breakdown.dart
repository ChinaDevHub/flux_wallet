import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/statistics/domain/entities/statistics_view.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/category_donut.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/category_legend_row.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/chart_card.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/range_label.dart';

/// Share of each category in the period's (or the picked month's) spending.
String _period(StatisticsView v) {
  final pick = v.selected;
  return pick == null ? rangeLabel(v.range) : monthLabel(pick);
}

class CategoryBreakdown extends StatelessWidget {
  const CategoryBreakdown(this.view, {super.key});

  final StatisticsView view;

  @override
  Widget build(BuildContext context) {
    return ChartCard(
      title: 'Xərc bölgüsü · ${_period(view)}',
      child: view.shares.isEmpty
          ? Text(
              'Bu dövrdə xərc yoxdur',
              style: TextStyle(color: context.colors.textMuted),
            )
          : Column(
              spacing: 14,
              children: [
                Center(child: CategoryDonut(view.shares)),
                for (final s in view.shares) CategoryLegendRow(s),
              ],
            ),
    );
  }
}
