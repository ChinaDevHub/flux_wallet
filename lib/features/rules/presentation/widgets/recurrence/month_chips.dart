import 'package:flutter/material.dart';
import 'package:flux_wallet/core/utils/az_names.dart';

/// Twelve toggle chips, Yan..Dek.
class MonthChips extends StatelessWidget {
  const MonthChips({super.key, required this.selected, required this.onToggle});

  final Set<int> selected;
  final ValueChanged<int> onToggle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        for (var m = 1; m <= 12; m++)
          FilterChip(
            label: Text(azMonthsShort[m - 1]),
            selected: selected.contains(m),
            onSelected: (_) => onToggle(m),
          ),
      ],
    );
  }
}
