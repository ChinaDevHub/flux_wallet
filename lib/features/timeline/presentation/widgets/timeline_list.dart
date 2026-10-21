import 'package:flutter/material.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_day.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_view.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/timeline_callbacks.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/timeline_day_row.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/timeline_footer.dart';

/// Opens on today: past days grow upwards from the `center` sliver.
class TimelineList extends StatelessWidget {
  const TimelineList({
    super.key,
    required this.view,
    required this.onTapDay,
    required this.onTapEntry,
  });

  static const _center = ValueKey('timeline-center');

  final TimelineView view;
  final ValueChanged<TimelineDay> onTapDay;
  final EntryTap onTapEntry;

  Widget _row(TimelineDay d) => TimelineDayRow(
    day: d,
    isLowest: d == view.lowest,
    onTapDay: onTapDay,
    onTapEntry: onTapEntry,
  );

  @override
  Widget build(BuildContext context) {
    final past = view.pastDays;
    final upcoming = view.upcomingDays;
    return CustomScrollView(
      center: _center,
      slivers: [
        SliverList.builder(
          itemCount: past.length,
          itemBuilder: (_, i) => _row(past[i]),
        ),
        SliverList.builder(
          key: _center,
          itemCount: upcoming.length,
          itemBuilder: (_, i) => _row(upcoming[i]),
        ),
        TimelineFooter(view),
      ],
    );
  }
}
