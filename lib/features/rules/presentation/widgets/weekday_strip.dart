import 'package:flutter/material.dart';
import 'package:flux_wallet/features/rules/presentation/widgets/day_toggle.dart';

/// Monday..Sunday toggles (DateTime weekday numbers).
class WeekdayStrip extends StatelessWidget {
  const WeekdayStrip({
    super.key,
    required this.selected,
    required this.onToggle,
  });

  static const _labels = ['B.e', 'Ç.a', 'Ç', 'C.a', 'C', 'Ş', 'B'];

  final Set<int> selected;
  final ValueChanged<int> onToggle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var d = DateTime.monday; d <= DateTime.sunday; d++)
          DayToggle(
            label: _labels[d - 1],
            selected: selected.contains(d),
            onTap: () => onToggle(d),
          ),
      ],
    );
  }
}
