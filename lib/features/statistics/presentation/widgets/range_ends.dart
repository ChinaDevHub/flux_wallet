import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/statistics/domain/entities/stats_range.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/range_label.dart';

/// The first and last month under the slider's knobs.
class RangeEnds extends StatelessWidget {
  const RangeEnds({super.key, required this.range});

  final StatsRange range;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: context.colors.textMuted,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(monthLabel(range.from), style: style),
          Text(monthLabel(range.to), style: style),
        ],
      ),
    );
  }
}
