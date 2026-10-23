import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/az_names.dart';
import 'package:flux_wallet/core/utils/group_by.dart';

/// Android month picker: the months of each year as chips; one tap picks.
class MonthChoiceGrid extends StatelessWidget {
  const MonthChoiceGrid({
    super.key,
    required this.months,
    required this.initial,
  });

  final List<DateTime> months;
  final DateTime initial;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final byYear = groupBy(months, (m) => m.year);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          for (final e in byYear.entries) ...[
            Text(
              '${e.key}',
              style: TextStyle(fontWeight: FontWeight.w800, color: c.textMuted),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final m in e.value)
                  ChoiceChip(
                    label: Text(azMonthsShort[m.month - 1]),
                    selected: m == initial,
                    showCheckmark: false,
                    onSelected: (_) => Navigator.pop(context, m),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
