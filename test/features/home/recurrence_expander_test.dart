import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/home/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/home/domain/usecases/recurrence_expander.dart';

RecurringRule rule(Frequency f, DateTime start, {DateTime? end}) =>
    RecurringRule(
      title: 't',
      amount: 1,
      category: 'bus',
      frequency: f,
      startDate: start,
      endDate: end,
    );

void main() {
  const expander = RecurrenceExpander();

  test('daily covers every day inclusive', () {
    final r = rule(Frequency.daily, DateTime(2026, 10, 1));
    expect(
      expander.expand(r, DateTime(2026, 10, 20), DateTime(2026, 10, 28)),
      hasLength(9),
    );
  });

  test('weekdays skip weekends and off days', () {
    final r = rule(Frequency.weekdays, DateTime(2026, 10, 1));
    // Oct 20 2026 is Tuesday; Oct 24-25 are the weekend.
    final all = expander.expand(
      r,
      DateTime(2026, 10, 20),
      DateTime(2026, 10, 28),
    );
    expect(all, hasLength(7));
    final off = expander.expand(
      r,
      DateTime(2026, 10, 20),
      DateTime(2026, 10, 28),
      offDays: {DateTime(2026, 10, 21)},
    );
    expect(off, hasLength(6));
  });

  test('monthly clamps day to month length', () {
    final r = rule(Frequency.monthly, DateTime(2026, 1, 31));
    final dates = expander.expand(
      r,
      DateTime(2026, 2, 1),
      DateTime(2026, 4, 30),
    );
    expect(dates, [
      DateTime(2026, 2, 28),
      DateTime(2026, 3, 31),
      DateTime(2026, 4, 30),
    ]);
  });

  test('one-off payment is a monthly rule ending on its start date', () {
    final d = DateTime(2026, 10, 27);
    final r = rule(Frequency.monthly, d, end: d);
    expect(expander.expand(r, DateTime(2026, 10, 1), DateTime(2027, 3, 1)), [
      d,
    ]);
  });

  test('inactive rule and ranges before start yield nothing', () {
    final r = rule(Frequency.daily, DateTime(2026, 10, 25));
    expect(
      expander.expand(r, DateTime(2026, 10, 1), DateTime(2026, 10, 24)),
      isEmpty,
    );
  });
}
