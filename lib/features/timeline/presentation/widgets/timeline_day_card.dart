import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_day.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_entry.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day_card_style.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day_entries.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day_forecast.dart';

class TimelineDayCard extends StatelessWidget {
  const TimelineDayCard({
    super.key,
    required this.day,
    required this.isLowest,
    required this.onTapDay,
    required this.onTapEntry,
  });

  final TimelineDay day;
  final bool isLowest;
  final VoidCallback onTapDay;
  final ValueChanged<TimelineEntry> onTapEntry;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(16);
    return Material(
      color: dayTint(context.colors, day),
      borderRadius: radius,
      child: InkWell(
        borderRadius: radius,
        onTap: onTapDay,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: DayEntries(day: day, onTapEntry: onTapEntry),
              ),
              DayForecast(
                caption: dayCaption(day, isLowest: isLowest),
                balance: day.endBalance,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
