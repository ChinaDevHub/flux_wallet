import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/adaptive_segmented.dart';
import 'package:flux_wallet/core/utils/az_names.dart';

/// Current month / next month switch (native segmented control per platform).
class MonthSelector extends StatelessWidget {
  const MonthSelector({
    super.key,
    required this.month,
    required this.selected,
    required this.onChanged,
  });

  /// First day of the currently displayed month.
  final DateTime month;
  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final current = DateTime(month.year, month.month - selected);
    final next = DateTime(current.year, current.month + 1);
    return AdaptiveSegmented<int>(
      selected: selected,
      onChanged: onChanged,
      options: {0: azMonths[current.month - 1], 1: azMonths[next.month - 1]},
    );
  }
}
