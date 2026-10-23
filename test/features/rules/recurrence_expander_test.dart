import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurrence_end.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/schedule_context.dart';
import 'package:flux_wallet/features/rules/domain/usecases/recurrence_expander.dart';
import 'package:flux_wallet/features/rules/domain/usecases/resolve_rule_end.dart';

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
      ctx: ScheduleContext(offDays: {DateTime(2026, 10, 21)}),
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

  test('weekly repeats on the weekday of the start date', () {
    final r = rule(Frequency.weekly, DateTime(2026, 10, 7)); // Wednesday
    final dates = expander.expand(
      r,
      DateTime(2026, 10, 20),
      DateTime(2026, 11, 5),
    );
    expect(dates, [
      DateTime(2026, 10, 21),
      DateTime(2026, 10, 28),
      DateTime(2026, 11, 4),
    ]);
  });

  test('custom weekdays and paused months narrow a day-based rule', () {
    final r = RecurringRule(
      title: 't',
      amount: 1,
      category: 'bus',
      frequency: Frequency.weekdays,
      startDate: DateTime(2026, 10, 1),
      weekdays: const {1, 2, 4, 5}, // remote Wednesdays
      skipMonths: const {11},
    );
    final oct = expander.expand(
      r,
      DateTime(2026, 10, 19),
      DateTime(2026, 10, 25),
    );
    expect(oct, [
      DateTime(2026, 10, 19),
      DateTime(2026, 10, 20),
      DateTime(2026, 10, 22),
      DateTime(2026, 10, 23),
    ]);
    expect(
      expander.expand(r, DateTime(2026, 11, 1), DateTime(2026, 11, 30)),
      isEmpty,
    );
  });

  test('"after N times" resolves to the N-th occurrence from the start', () {
    const resolve = ResolveRuleEnd();
    final monthly = rule(Frequency.monthly, DateTime(2026, 10, 20));
    expect(resolve(monthly, const EndsAfter(4)), DateTime(2027, 1, 20));
    final weekly = rule(Frequency.weekly, DateTime(2026, 10, 21));
    expect(resolve(weekly, const EndsAfter(3)), DateTime(2026, 11, 4));
    expect(resolve(weekly, RecurrenceEnd.never), isNull);
    expect(
      resolve(weekly, EndsOn(DateTime(2026, 12, 1, 15))),
      DateTime(2026, 12, 1),
    );
  });

  test('exceptions remove only that rule on that date', () {
    final r = RecurringRule(
      id: 1,
      title: 't',
      amount: 1,
      category: 'bus',
      frequency: Frequency.daily,
      startDate: DateTime(2026, 10, 1),
    );
    final ctx = ScheduleContext(
      exceptions: {
        1: {DateTime(2026, 10, 21)},
      },
    );
    final dates = expander.expand(
      r,
      DateTime(2026, 10, 20),
      DateTime(2026, 10, 22),
      ctx: ctx,
    );
    expect(dates, [DateTime(2026, 10, 20), DateTime(2026, 10, 22)]);
  });
}
