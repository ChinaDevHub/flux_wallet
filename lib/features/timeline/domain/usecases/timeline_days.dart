import 'package:flux_wallet/features/timeline/domain/entities/day_limit.dart';
import 'package:flux_wallet/features/timeline/domain/entities/month_frame.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_day.dart';
import 'package:flux_wallet/features/timeline/domain/usecases/timeline_entries.dart';

/// The days of the month. [shown] are the planned items as listed, skipped
/// ones included; the money is taken from [ends] and [limits].
List<TimelineDay> timelineDays(
  MonthFrame f, {
  required Map<DateTime, double> ends,
  required Map<DateTime, DayLimit> limits,
  required MonthFrame shown,
}) => [
  for (final d in f.days)
    TimelineDay(
      date: d,
      entries: entriesFor(
        f.transactionsOn(d),
        shown.plansOn(d),
        f.ctx,
        accountNames: f.accountNames,
      ),
      endBalance: ends[d] ?? 0,
      isToday: d == f.today,
      isPast: d.isBefore(f.today),
      isDayOff: f.ctx.offDays.contains(d),
      limit: limits[d],
    ),
];
