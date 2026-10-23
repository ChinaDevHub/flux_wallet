import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/haptics.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_state.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/calendar/day_cell.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/calendar/day_marks.dart';

/// The days of a month in weeks, Monday first.
class MonthGrid extends StatelessWidget {
  const MonthGrid({super.key, required this.state, required this.onSelect});

  final TimelineLoaded state;
  final ValueChanged<DateTime> onSelect;

  List<Widget> _cells() {
    final cells = <Widget>[
      for (var i = 1; i < state.month.weekday; i++) const SizedBox.shrink(),
      for (final d in state.view.days)
        DayCell(
          date: d.date,
          marks: DayMarks(
            selected: d.date == state.selected,
            today: d.date == state.today,
            enabled: state.bounds.contains(d.date),
            over: d.isOver,
          ),
          onTap: withTick(() => onSelect(d.date)),
        ),
    ];
    while (cells.length % 7 != 0) {
      cells.add(const SizedBox.shrink());
    }
    return cells;
  }

  @override
  Widget build(BuildContext context) {
    final cells = _cells();
    return Column(
      children: [
        for (var w = 0; w < cells.length; w += 7)
          Row(
            children: [
              for (final c in cells.sublist(w, w + 7)) Expanded(child: c),
            ],
          ),
      ],
    );
  }
}
