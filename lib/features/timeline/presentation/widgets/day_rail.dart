import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_day.dart';

/// The vertical line with one dot per day.
class DayRail extends StatelessWidget {
  const DayRail(this.day, {super.key});

  final TimelineDay day;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final size = day.isToday ? 14.0 : 9.0;
    return SizedBox(
      width: 26,
      child: Column(
        children: [
          const SizedBox(height: 6),
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: day.isToday ? c.surface : c.divider,
              border: day.isToday
                  ? Border.all(color: c.primary, width: 3)
                  : null,
            ),
          ),
          Expanded(child: Container(width: 2, color: c.divider)),
        ],
      ),
    );
  }
}
