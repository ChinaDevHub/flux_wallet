import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_day.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day/forecast_summary.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day/limit_summary.dart';

/// The card above a day's lines: spent against the limit once the day has
/// come, the plan and the forecast balance before it.
class DaySummary extends StatelessWidget {
  const DaySummary(this.day, {super.key});

  final TimelineDay day;

  @override
  Widget build(BuildContext context) {
    final limit = day.limit;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(22),
      ),
      child: limit == null
          ? ForecastSummary(day: day)
          : LimitSummary(limit: limit, isToday: day.isToday),
    );
  }
}
