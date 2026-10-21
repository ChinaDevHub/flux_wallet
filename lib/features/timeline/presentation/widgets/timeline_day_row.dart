import 'package:flutter/material.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_day.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day_date_column.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day_rail.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/timeline_callbacks.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/timeline_day_card.dart';

/// date | rail | card. Past days are dimmed.
class TimelineDayRow extends StatelessWidget {
  const TimelineDayRow({
    super.key,
    required this.day,
    required this.isLowest,
    required this.onTapDay,
    required this.onTapEntry,
  });

  final TimelineDay day;
  final bool isLowest;
  final ValueChanged<TimelineDay> onTapDay;
  final EntryTap onTapEntry;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: day.isPast ? 0.6 : 1,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DayDateColumn(day),
            DayRail(day),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TimelineDayCard(
                  day: day,
                  isLowest: isLowest,
                  onTapDay: () => onTapDay(day),
                  onTapEntry: (e) => onTapEntry(day, e),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
