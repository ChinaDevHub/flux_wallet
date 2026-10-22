import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/adaptive_refresh.dart';
import 'package:flux_wallet/features/shell/presentation/widgets/main_top_bar.dart';
import 'package:flux_wallet/features/statistics/domain/entities/statistics_view.dart';
import 'package:flux_wallet/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/category_breakdown.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/month_comparison_chart.dart';

class StatisticsBody extends StatelessWidget {
  const StatisticsBody({super.key, required this.view, required this.cubit});

  final StatisticsView view;
  final StatisticsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return AdaptiveRefresh(
      onRefresh: cubit.load,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 140),
        children: [
          const MainTopBar(title: 'Statistika'),
          const SizedBox(height: 16),
          MonthComparisonChart(view: view, onSelect: cubit.select),
          const SizedBox(height: 16),
          CategoryBreakdown(view),
        ],
      ),
    );
  }
}
