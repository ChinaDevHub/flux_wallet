import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/rules/domain/entities/schedule_context.dart';
import 'package:flux_wallet/features/timeline/domain/entities/timeline_view.dart';
import 'package:flux_wallet/features/timeline/domain/usecases/build_timeline.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';

RecurringRule rule(
  int id,
  String t,
  double a,
  Frequency f,
  DateTime start, {
  TxType type = TxType.expense,
}) => RecurringRule(
  id: id,
  title: t,
  amount: a,
  category: t,
  frequency: f,
  startDate: start,
  type: type,
);

Transaction spent(double amount, DateTime date) => Transaction(
  amount: amount,
  type: TxType.expense,
  category: 'cafe',
  accountId: 1,
  date: date,
);

void main() {
  final today = DateTime(2026, 10, 20); // Tuesday
  final salary = rule(
    1,
    'Maaş',
    1200,
    Frequency.monthly,
    DateTime(2026, 9, 29),
    type: TxType.income,
  );
  final rent = rule(2, 'Kirayə', 250, Frequency.monthly, DateTime(2026, 8, 25));
  final bus = rule(3, 'Avtobus', 1, Frequency.weekdays, DateTime(2026, 1, 1));
  final rules = [salary, rent, bus];

  TimelineView build({
    ScheduleContext ctx = ScheduleContext.empty,
    List<Transaction> tx = const [],
    int month = 10,
  }) => const BuildTimeline()(
    today: today,
    month: DateTime(2026, month),
    balance: 412,
    rules: rules,
    ctx: ctx,
    transactions: tx,
  );

  double endOf(TimelineView v, int day) =>
      v.days.firstWhere((d) => d.date.day == day).endBalance;

  test('lists every day of the month', () {
    final v = build();
    expect(v.days, hasLength(31));
    expect(v.days.where((d) => d.isToday).single.date.day, 20);
    expect(v.days.where((d) => d.isPast), hasLength(19));
  });

  test('forecast applies virtual items day by day', () {
    final v = build();
    expect(endOf(v, 20), 411); // bus
    expect(endOf(v, 23), 408);
    expect(endOf(v, 24), 408); // Saturday: no bus
    expect(endOf(v, 25), 158); // rent on Sunday
    expect(endOf(v, 28), 155);
    expect(endOf(v, 29), 1354); // salary + bus
  });

  test('past days are rebuilt from real transactions', () {
    final v = build(
      tx: [spent(5, today), spent(10, DateTime(2026, 10, 18, 12))],
    );
    expect(endOf(v, 19), 417);
    expect(endOf(v, 18), 417);
    expect(endOf(v, 17), 427);
    expect(v.days[17].entries.single.isVirtual, isFalse);
  });

  test('today keeps real and planned entries, past days no virtual ones', () {
    final v = build(tx: [spent(5, today)]);
    final todayEntries = v.days[19].entries;
    expect([for (final e in todayEntries) e.isVirtual], [false, true]);
    expect(v.days[18].entries, isEmpty);
  });

  test(
    'an exception switches one virtual entry off and removes its effect',
    () {
      final ctx = ScheduleContext(
        exceptions: {
          3: {DateTime(2026, 10, 21)},
        },
      );
      final v = build(ctx: ctx);
      // The line stays listed, switched off, so it can be switched back on.
      final skipped = v.days[20].entries.single;
      expect(skipped.skipped, isTrue);
      expect(skipped.counts, isFalse);
      expect(v.days[20].hasExpense, isFalse);
      expect(endOf(v, 21), 411);
    },
  );

  test('a day off removes weekday rules and is flagged', () {
    final v = build(ctx: ScheduleContext(offDays: {DateTime(2026, 10, 22)}));
    expect(v.days[21].isDayOff, isTrue);
    expect(v.days[21].entries, isEmpty);
  });

  test('cycle and lowest forecast day', () {
    final v = build();
    expect(v.cycle!.daysLeft, 9);
    expect(v.cycle!.title, 'Maaş');
    expect(v.cycle!.progress, closeTo(0.7, 0.001));
    expect(v.lowest!.date.day, 28);
    expect(v.lowest!.endBalance, 155);
  });

  test('next month continues from this month\'s forecast', () {
    final v = build(month: 11);
    expect(v.days, hasLength(30));
    expect(endOf(v, 1), 1353); // Sunday, nothing happens
    expect(endOf(v, 2), 1352); // Monday bus
    expect(v.days.every((d) => !d.isPast), isTrue);
  });
}
