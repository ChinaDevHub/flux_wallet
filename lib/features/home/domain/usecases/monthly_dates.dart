import 'package:flux_wallet/core/utils/date_utils.dart';

/// Every month's [day] inside `[lo, hi]`; the day is clamped to month length
/// (31st -> 28th/30th in short months).
List<DateTime> monthlyDates(int day, DateTime lo, DateTime hi) {
  final dates = <DateTime>[];
  for (var m = 0; ; m++) {
    final first = DateTime(lo.year, lo.month + m);
    final last = daysInMonth(first.year, first.month);
    final date = DateTime(first.year, first.month, day.clamp(1, last));
    if (date.isAfter(hi)) return dates;
    if (!date.isBefore(lo)) dates.add(date);
  }
}
