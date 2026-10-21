import 'package:flutter_test/flutter_test.dart';
import 'package:flux_wallet/features/rules/domain/entities/recurring_rule.dart';
import 'package:flux_wallet/features/transactions/domain/entities/transaction.dart';
import 'package:flux_wallet/features/home/domain/usecases/calculate_daily_limit.dart';
import 'package:flux_wallet/features/rules/domain/entities/schedule_context.dart';
import 'package:flux_wallet/features/rules/domain/usecases/next_income_finder.dart';

RecurringRule monthly(
  String t,
  double a,
  DateTime start, {
  DateTime? end,
  TxType type = TxType.expense,
}) => RecurringRule(
  title: t,
  amount: a,
  category: t,
  frequency: Frequency.monthly,
  startDate: start,
  endDate: end,
  type: type,
);

void main() {
  const calc = CalculateDailyLimit();
  final today = DateTime(2026, 10, 20);
  final salary = monthly(
    'salary',
    1200,
    DateTime(2026, 9, 29),
    type: TxType.income,
  );
  final rent = monthly('rent', 250, DateTime(2026, 8, 25));
  final debt = monthly(
    'debt',
    50,
    DateTime(2026, 10, 27),
    end: DateTime(2026, 10, 27),
  );
  final bus = RecurringRule(
    title: 'bus',
    amount: 1,
    category: 'bus',
    frequency: Frequency.weekdays,
    startDate: DateTime(2026, 1, 1),
  );

  test('finds the next income strictly after today', () {
    expect(
      const NextIncomeFinder()([salary, rent], today),
      DateTime(2026, 10, 29),
    );
    expect(
      const NextIncomeFinder()([salary], DateTime(2026, 10, 29)),
      DateTime(2026, 11, 29),
    );
    expect(const NextIncomeFinder()([rent], today), isNull);
  });

  test('free money = balance - obligations; limit = free / days', () {
    final next = const NextIncomeFinder()([salary], today);
    final limit = calc(
      totalBalance: 412,
      rules: [salary, rent, debt, bus],
      today: today,
      nextIncome: next,
    );
    // Oct 20..28 => 9 days; rent 250 + debt 50 + bus on 7 weekdays (20-23, 26-28).
    expect(limit.daysLeft, 9);
    expect(limit.obligations, 307);
    expect(limit.freeMoney, 105);
    expect(calc.perDay(limit), 11.66);
    expect(limit.hasShortfall, isFalse);
  });

  test('income day itself is excluded from obligations', () {
    final lateRent = monthly('rent', 250, DateTime(2026, 8, 29));
    final limit = calc(
      totalBalance: 500,
      rules: [lateRent],
      today: today,
      nextIncome: DateTime(2026, 10, 29),
    );
    expect(limit.obligations, 0);
  });

  test('shortfall when obligations exceed balance', () {
    final limit = calc(
      totalBalance: 100,
      rules: [rent],
      today: today,
      nextIncome: DateTime(2026, 10, 29),
    );
    expect(limit.hasShortfall, isTrue);
    expect(limit.shortfall, 150);
    expect(calc.perDay(limit), 0);
  });

  test('falls back to the first of next month without an income rule', () {
    final limit = calc(totalBalance: 100, rules: [], today: today);
    expect(limit.nextIncome, DateTime(2026, 11, 1));
    expect(limit.daysLeft, 12);
  });

  test('off days remove weekday obligations', () {
    final next = DateTime(2026, 10, 29);
    final off = calc(
      totalBalance: 100,
      rules: [bus],
      today: today,
      nextIncome: next,
      ctx: ScheduleContext(
        offDays: {DateTime(2026, 10, 21), DateTime(2026, 10, 22)},
      ),
    );
    expect(off.obligations, 5);
  });
}
