import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/platform_x.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/calendar/day_marks.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/calendar/day_number.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/calendar/over_dot.dart';

/// One day of the grid: its number, and a red dot under it when that day
/// went over its limit. Nothing else is drawn on a day.
class DayCell extends StatelessWidget {
  const DayCell({
    super.key,
    required this.date,
    required this.marks,
    required this.onTap,
  });

  final DateTime date;
  final DayMarks marks;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: marks.enabled,
      selected: marks.selected,
      label: '${date.day}${marks.over ? ', limit aşılıb' : ''}',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: marks.enabled ? onTap : null,
        child: SizedBox(
          height: 54,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 3,
            children: [
              DayNumber(
                date: date,
                marks: marks,
                cupertino: context.isCupertino,
              ),
              OverDot(visible: marks.over),
            ],
          ),
        ),
      ),
    );
  }
}
