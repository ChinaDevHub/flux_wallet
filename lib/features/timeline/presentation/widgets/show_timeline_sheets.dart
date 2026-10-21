import 'package:flutter/material.dart';
import 'package:flux_wallet/core/platform/adaptive_sheet.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_day.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_entry.dart';
import 'package:flux_wallet/features/timeline/presentation/cubit/timeline_cubit.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/day_sheet.dart';
import 'package:flux_wallet/features/timeline/presentation/widgets/exception_sheet.dart';

// The sheets live in a separate route, so the cubit is captured by closure.

void showEntrySheet(
  BuildContext context,
  TimelineCubit cubit,
  TimelineDay day,
  TimelineEntry entry,
) {
  showAppSheet<void>(
    context,
    (ctx) => ExceptionSheet(
      entry: entry,
      dayOff: day.isDayOff,
      onOnce: () {
        Navigator.pop(ctx);
        cubit.skipOnce(entry.rule!, day.date);
      },
      onFromHere: () {
        Navigator.pop(ctx);
        cubit.endFrom(entry.rule!, day.date);
      },
      onDayOffChanged: (off) => cubit.setDayOff(day.date, off),
    ),
  );
}

void showDaySheet(BuildContext context, TimelineCubit cubit, TimelineDay day) {
  if (day.isPast) return;
  showAppSheet<void>(
    context,
    (_) => DaySheet(
      date: day.date,
      dayOff: day.isDayOff,
      onDayOffChanged: (off) => cubit.setDayOff(day.date, off),
    ),
  );
}
