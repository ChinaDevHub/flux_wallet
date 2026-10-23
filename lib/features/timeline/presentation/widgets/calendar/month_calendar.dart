import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_cubit.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_state.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/calendar/month_grid.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/calendar/month_swipe.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/calendar/weekday_header.dart';

/// The month card. Swipe it sideways to change the month; the grid fades to
/// the next one and the card grows or shrinks with the number of weeks.
class MonthCalendar extends StatelessWidget {
  const MonthCalendar({super.key, required this.state, required this.cubit});

  final TimelineLoaded state;
  final TimelineCubit cubit;

  @override
  Widget build(BuildContext context) {
    return MonthSwipe(
      state: state,
      onMonth: cubit.selectMonth,
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
        decoration: BoxDecoration(
          color: context.colors.surface,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            const WeekdayHeader(),
            const SizedBox(height: 4),
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.topCenter,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: MonthGrid(
                  key: ValueKey(state.month),
                  state: state,
                  onSelect: cubit.selectDay,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
