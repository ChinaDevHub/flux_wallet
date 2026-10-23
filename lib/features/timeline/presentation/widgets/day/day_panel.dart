import 'package:flutter/material.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_cubit.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_state.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day/add_to_day_button.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day/day_entries.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day/day_header.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day/day_summary.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day_off_row.dart';

/// Everything about the picked day, under the calendar.
class DayPanel extends StatelessWidget {
  const DayPanel({super.key, required this.state, required this.cubit});

  final TimelineLoaded state;
  final TimelineCubit cubit;

  @override
  Widget build(BuildContext context) {
    final day = state.selectedDay;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 14,
      children: [
        DayHeader(date: day.date, today: state.today, onToday: cubit.goToToday),
        DaySummary(day),
        DayEntries(day: day, cubit: cubit),
        if (!day.isPast)
          DayOffRow(
            key: ValueKey(day.date),
            initial: day.isDayOff,
            onChanged: (off) => cubit.setDayOff(day.date, off),
          ),
        AddToDayButton(day),
      ],
    );
  }
}
