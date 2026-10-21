import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/core/utils/az_calendar.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_day.dart';

/// "BUGÜN" (today only), the day number and the short weekday below it.
class DayDateColumn extends StatelessWidget {
  const DayDateColumn(this.day, {super.key});

  final TimelineDay day;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SizedBox(
      width: 56,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (day.isToday)
            Text(
              'BUGÜN',
              style: TextStyle(
                fontSize: 9,
                letterSpacing: 0.5,
                color: c.textMuted,
              ),
            ),
          Text(
            '${day.date.day}',
            style: TextStyle(
              fontSize: 17,
              height: 1.1,
              fontWeight: FontWeight.w800,
              color: day.isToday ? c.primary : c.text,
            ),
          ),
          Text(
            azWeekdaysShort[day.date.weekday - 1],
            style: TextStyle(fontSize: 11, color: c.textMuted),
          ),
        ],
      ),
    );
  }
}
