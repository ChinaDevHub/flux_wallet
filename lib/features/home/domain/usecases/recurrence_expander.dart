import 'package:flux_wallet/core/utils/date_utils.dart';
import 'package:flux_wallet/features/home/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/home/domain/usecases/monthly_dates.dart';

/// Turns a [RecurringRule] into concrete dates inside `[from, to]` (inclusive).
class RecurrenceExpander {
  const RecurrenceExpander();

  List<DateTime> expand(
    RecurringRule rule,
    DateTime from,
    DateTime to, {
    Set<DateTime> offDays = const {},
  }) {
    if (!rule.isActive) return const [];
    final start = dateOnly(rule.startDate);
    final lo = from.isBefore(start) ? start : dateOnly(from);
    final end = rule.endDate == null ? null : dateOnly(rule.endDate!);
    final hi = end != null && end.isBefore(to) ? end : dateOnly(to);
    if (lo.isAfter(hi)) return const [];
    return switch (rule.frequency) {
      Frequency.daily => _days(lo, hi, (_) => true),
      Frequency.weekdays => _days(
        lo,
        hi,
        (d) => d.weekday <= DateTime.friday && !offDays.contains(d),
      ),
      Frequency.monthly => monthlyDates(start.day, lo, hi),
    };
  }

  List<DateTime> _days(DateTime lo, DateTime hi, bool Function(DateTime) ok) {
    return [
      for (var d = lo; !d.isAfter(hi); d = addDays(d, 1))
        if (ok(d)) d,
    ];
  }
}
