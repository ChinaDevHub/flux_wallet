import 'package:flutter/material.dart';
import 'package:flux_wallet/core/widgets/surface_card.dart';
import 'package:flux_wallet/features/statistics/domain/entities/statistics_view.dart';
import 'package:flux_wallet/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/month_range_slider.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/preset_picker.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/period_header.dart';

/// "Dövr": a ready-made period, or any months picked on the slider.
class StatsRangeCard extends StatelessWidget {
  const StatsRangeCard({super.key, required this.view, required this.cubit});

  final StatisticsView view;
  final StatisticsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SurfaceCard(
      child: Column(
        spacing: 14,
        children: [
          PeriodHeader(view.range),
          PresetPicker(current: view.preset, onPick: cubit.setPreset),
          MonthRangeSlider(
            months: view.available,
            range: view.range,
            onRange: cubit.setRange,
          ),
        ],
      ),
    );
  }
}
