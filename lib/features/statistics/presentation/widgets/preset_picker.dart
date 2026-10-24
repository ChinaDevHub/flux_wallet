import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/adaptive_segmented.dart';
import 'package:flux_wallet/features/statistics/domain/entities/stats_range.dart';

/// 1 ay · 2 ay · 3 ay · 6 ay · Xüsusi. "Xüsusi" lights up by itself when the
/// slider picks a period that is none of the others.
class PresetPicker extends StatelessWidget {
  const PresetPicker({super.key, required this.current, required this.onPick});

  final StatsPreset? current;
  final ValueChanged<StatsPreset> onPick;

  static const _custom = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AdaptiveSegmented<int>(
        selected: current?.months ?? _custom,
        onChanged: (n) {
          final p = StatsPreset.values.where((p) => p.months == n).firstOrNull;
          if (p != null) onPick(p);
        },
        options: {
          for (final p in StatsPreset.values) p.months: p.label,
          _custom: 'Xüsusi',
        },
      ),
    );
  }
}
