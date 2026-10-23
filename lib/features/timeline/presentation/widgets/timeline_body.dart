import 'package:flutter/material.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_cubit.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_state.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/calendar/calendar_header.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/calendar/month_calendar.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day/day_panel.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/smart_forecast_card.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/timeline_top_bar.dart';

/// The calendar tab: the month on top, the picked day under it.
class TimelineBody extends StatelessWidget {
  const TimelineBody({super.key, required this.state, required this.cubit});

  final TimelineLoaded state;
  final TimelineCubit cubit;

  @override
  Widget build(BuildContext context) {
    final current = state.view.days.any((d) => d.isToday);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 140),
      children: [
        const TimelineTopBar(),
        const SizedBox(height: 8),
        CalendarHeader(state: state, cubit: cubit),
        const SizedBox(height: 6),
        MonthCalendar(state: state, cubit: cubit),
        const SizedBox(height: 20),
        DayPanel(state: state, cubit: cubit),
        if (current) ...[
          const SizedBox(height: 16),
          SmartForecastCard(state.view),
        ],
      ],
    );
  }
}
