import 'package:flutter/material.dart';
import 'package:flux_wallet/core/theme/app_colors.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/calendar/day_marks.dart';

/// How a day's number is painted. Selected: a filled circle. Today: a ring
/// on Android, coloured text on iOS, as each platform's own calendar does.
extension DayNumberStyle on DayMarks {
  BoxDecoration circle(AppColors c, {required bool cupertino}) {
    final ring = today && !selected && !cupertino;
    return BoxDecoration(
      shape: BoxShape.circle,
      color: selected ? c.primary : Colors.transparent,
      border: ring ? Border.all(color: c.primary, width: 1.6) : null,
    );
  }

  TextStyle number(AppColors c, DateTime date) => TextStyle(
    fontSize: 16,
    fontWeight: today || selected ? FontWeight.w800 : FontWeight.w500,
    color: selected
        ? c.onPrimary
        : today
        ? c.primary
        : date.weekday > DateTime.friday
        ? c.textMuted
        : c.text,
  );
}
