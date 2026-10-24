import 'package:flutter/material.dart';
import 'package:flux_wallet/features/statistics/domain/entities/stats_range.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/month_range_slider_state.dart';

/// Drag the knobs over the [months] to pick any period; it loads on lift.
class MonthRangeSlider extends StatefulWidget {
  const MonthRangeSlider({
    super.key,
    required this.months,
    required this.range,
    required this.onRange,
  });

  final List<DateTime> months;
  final StatsRange range;
  final ValueChanged<StatsRange> onRange;

  @override
  State<MonthRangeSlider> createState() => MonthRangeSliderState();
}
