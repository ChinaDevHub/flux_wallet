import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/widgets/section_label.dart';
import 'package:flux_wallet/features/statistics/domain/entities/stats_range.dart';
import 'package:flux_wallet/features/statistics/presentation/widgets/range_label.dart';

/// "Dövr ............ May – Okt 2026".
class PeriodHeader extends StatelessWidget {
  const PeriodHeader(this.range, {super.key});

  final StatsRange range;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      const Expanded(child: SectionLabel('Dövr')),
      Text(
        rangeLabel(range),
        style: TextStyle(color: context.colors.textMuted),
      ),
    ],
  );
}
